defmodule InventoryWeb.LiveHelpers do
  import Phoenix.LiveView

  @spec assign_current_user(Phoenix.LiveView.Socket.t(), map) :: Phoenix.LiveView.Socket.t()
  def assign_current_user(socket, %{"user_token" => user_token}) do
    assign_new(
      socket,
      :current_user,
      fn -> Inventory.Accounts.get_user_by_session_token(user_token) end
    )
  end
end
