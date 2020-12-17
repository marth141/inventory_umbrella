defmodule InventoryWeb.QrScannerLive.Index do
  use InventoryWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket |> assign(:scan, "Need QR")}
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
  def handle_event("jsEventToPhx", params, socket) do
    {:noreply, assign(socket, :scan, "Scan: " <> params["qrCodeMessage"])}
  end
end
