defmodule InventoryWeb.QrCodesLive do
  use InventoryWeb, :live_view

  @impl true
  def mount(_params, session, socket) do
    {:ok,
     socket
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
    <%= live_component @socket, InventoryWeb.TableComponent,
      table_dataset: Inventory.QrCodes.read(),
      table_headers:
        Map.keys(%Inventory.QrCode{})
          |> List.delete(:__meta__)
          |> List.delete(:__struct__) %>
    """
  end
end
