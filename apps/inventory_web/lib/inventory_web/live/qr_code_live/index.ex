defmodule InventoryWeb.QrCodeLive.Index do
  use InventoryWeb, :live_view

  alias Inventory.QrCodes
  alias Inventory.QrCodes.QrCode

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :qr_codes, list_qr_codes())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Qr code")
    |> assign(:qr_code, QrCodes.get_qr_code!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Qr code")
    |> assign(:qr_code, %QrCode{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Qr codes")
    |> assign(:qr_code, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    qr_code = QrCodes.get_qr_code!(id)
    {:ok, _} = QrCodes.delete_qr_code(qr_code)

    {:noreply, assign(socket, :qr_codes, list_qr_codes())}
  end

  defp list_qr_codes do
    QrCodes.list_qr_codes()
  end
end
