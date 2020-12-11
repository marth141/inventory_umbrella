defmodule InventoryWeb.ProductsLive do
  use InventoryWeb, :live_view

  @impl true
  def mount(_params, session, socket) do
    {:ok,
     socket
     |> assign(:table_dataset, Inventory.Assets.read())
     |> assign(
       :table_headers,
       Map.keys(%Inventory.Asset{})
       |> List.delete(:__meta__)
       |> List.delete(:__struct__)
       |> List.delete(:qr_codes)
     )
     |> assign_current_user(session)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Products")
  end

  @impl true
  def render(assigns) do
    ~L"""
    <%= live_component @socket, InventoryWeb.TableComponent, assigns %>
    """
  end
end
