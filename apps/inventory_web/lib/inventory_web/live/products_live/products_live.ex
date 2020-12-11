defmodule InventoryWeb.ProductsLive do
  use InventoryWeb, :live_view
  import Ecto.Query
  alias Inventory.Repo

  @impl true
  def mount(_params, session, socket) do
    {:ok,
     socket
     |> assign(:products, fetch_assets())
     |> assign(:headers, Map.keys(%Inventory.Asset{}))
     |> assign_current_user(session)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "DM Panel")
  end

  defp fetch_assets() do
    from(a in Inventory.Asset, as: :asset)
    |> order_by([asset: a], desc: a.name)
    |> Repo.all()
  end

  @impl true
  def render(assigns) do
    ~L"""
    <%= live_component @socket, InventoryWeb.TableComponent, assigns %>
    """
  end
end
