defmodule InventoryWeb.QrScannerLive.Index do
  use InventoryWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Inventory.Assets.subscribe()

    {:ok, socket |> assign(:qr_code_message, "")}
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
  def handle_info({:asset_retrieved, asset}, socket) do
    IO.inspect(asset)
    {:noreply, socket |> assign(:asset, asset)}
  end

  def handle_info(_, socket) do
    {:noreply, socket}
  end

  @impl true
  def handle_event("qrCodeMessage", params, socket) do
    Messaging.publish({:retrieve_asset, params["qrCodeMessage"]}, Inventory.Assets.topic())
    {:noreply, assign(socket, :qr_code_message, "Scanned: " <> params["qrCodeMessage"])}
  end
end
