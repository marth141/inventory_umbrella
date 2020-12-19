defmodule InventoryWeb.QrScannerLive.Index do
  use InventoryWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Inventory.Assets.subscribe()

    {:ok,
     socket
     |> assign(:qr_code_message, "")
     |> assign(:assets, [])}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "QR Scanner")
  end

  @impl true
  def handle_event("qrCodeMessage", %{"qrCodeMessage" => qr_code_message}, socket) do
    asset = Inventory.Assets.fetch_asset_by_name(qr_code_message)

    {:noreply,
     socket
     |> assign(:qr_code_message, "Scanned: " <> qr_code_message)
     |> assign(:assets, [asset | socket.assigns.assets])}
  end
end
