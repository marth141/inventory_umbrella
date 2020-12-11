defmodule InventoryWeb.QrCodeLive.Show do
  use InventoryWeb, :live_view

  alias Inventory.QrCodes

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:qr_code, QrCodes.get_qr_code!(id))}
  end

  defp page_title(:show), do: "Show Qr code"
  defp page_title(:edit), do: "Edit Qr code"
end
