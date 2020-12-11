defmodule InventoryWeb.TableComponent do
  use InventoryWeb, :live_component

  @impl true
  def render(assigns) do
    ~L"""
    <table>
      <%= live_component @socket, InventoryWeb.TableHeadComponent, assigns %>
      <%= live_component @socket, InventoryWeb.TableBodyComponent, assigns %>
    </table>
    """
  end
end
