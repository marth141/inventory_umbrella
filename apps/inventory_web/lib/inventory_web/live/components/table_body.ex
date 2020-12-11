defmodule InventoryWeb.TableBodyComponent do
  use InventoryWeb, :live_component

  @impl true
  def render(assigns) do
    ~L"""
    <tbody>
      <%= for data <- @table_dataset do %>
        <tr>
          <%= for header <- @table_headers do %>
            <td><%= Map.get(data, header) %></td>
          <% end %>
        </tr>
      <% end %>
    </tbody>
    """
  end
end
