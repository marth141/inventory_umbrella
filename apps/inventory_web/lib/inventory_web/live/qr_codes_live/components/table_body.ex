defmodule InventoryWeb.QrCodeTableBodyComponent do
  use InventoryWeb, :live_component

  @impl true
  def render(assigns) do
    ~L"""
    <tbody>
      <%= for data <- @table_dataset do %>
        <tr>
          <%= for header <- @table_headers do %>
            <%= if header == :qr_img do %>
              <td><%= Phoenix.HTML.raw(
                "<img src=data:image/png;base64," <> Base.encode64(Map.get(data, header)) <> " alt=\"Red Dot\"/>"
              ) %></td>
            <% else %>
              <td><%= Map.get(data, header) %></td>
            <% end %>
          <% end %>
        </tr>
      <% end %>
    </tbody>
    """
  end
end
