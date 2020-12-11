defmodule InventoryWeb.TableHeadComponent do
  use InventoryWeb, :live_component

  @impl true
  def render(assigns) do
    ~L"""
    <thead>
      <tr>
        <%= for header <- @headers do %>
          <th><%= header %></th>
        <% end %>
      </tr>
    </thead>
    """
  end
end
