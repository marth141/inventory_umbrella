defmodule InventoryWeb.QrCodeLive.FormComponent do
  use InventoryWeb, :live_component

  alias Inventory.QrCodes

  @impl true
  def update(%{qr_code: qr_code} = assigns, socket) do
    changeset = QrCodes.change_qr_code(qr_code)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"qr_code" => qr_code_params}, socket) do
    changeset =
      socket.assigns.qr_code
      |> QrCodes.change_qr_code(qr_code_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"qr_code" => qr_code_params}, socket) do
    save_qr_code(socket, socket.assigns.action, qr_code_params)
  end

  defp save_qr_code(socket, :edit, qr_code_params) do
    new_code =
      QrCodes.QrCode.new_struct_from_binary(qr_code_params["qr_data"]) |> Map.from_struct()

    case QrCodes.update_qr_code(socket.assigns.qr_code, new_code) do
      {:ok, _qr_code} ->
        {:noreply,
         socket
         |> put_flash(:info, "Qr code updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_qr_code(socket, :new, qr_code_params) do
    new_code =
      QrCodes.QrCode.new_struct_from_binary(qr_code_params["qr_data"]) |> Map.from_struct()

    case QrCodes.create_qr_code(new_code) do
      {:ok, _qr_code} ->
        {:noreply,
         socket
         |> put_flash(:info, "Qr code created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
