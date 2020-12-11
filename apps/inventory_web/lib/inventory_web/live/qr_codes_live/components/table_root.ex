defmodule InventoryWeb.QrCodeTableComponent do
  use InventoryWeb, :live_component

  @impl true
  def render(assigns) do
    ~L"""
    <table>
      <%= live_component @socket, InventoryWeb.QrCodeTableHeadComponent, assigns %>
      <%= live_component @socket, InventoryWeb.QrCodeTableBodyComponent, assigns %>
    </table>
    """
  end
end
