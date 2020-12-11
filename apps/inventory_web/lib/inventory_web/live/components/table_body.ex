defmodule InventoryWeb.TableBodyComponent do
  use InventoryWeb, :live_component

  @impl true
  def render(assigns) do
    ~L"""
    <tbody>
      <tr>
        <%= for data <- @dataset do %>
          <%= for header <- @headers do %>
            <td><%= data[header] %></td>
          <% end %>
        <% end %>
      </tr>
    </tbody>
    """
  end
end
