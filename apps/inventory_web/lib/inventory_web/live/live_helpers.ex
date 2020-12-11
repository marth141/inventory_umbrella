defmodule InventoryWeb.LiveHelpers do
  import Phoenix.LiveView
  import Phoenix.LiveView.Helpers

  @doc """
  Renders a component inside the `InventoryWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal @socket, InventoryWeb.UserLive.FormComponent,
        id: @user.id || :new,
        action: @live_action,
        user: @user,
        return_to: Routes.user_index_path(@socket, :index) %>
  """
  def live_modal(socket, component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts]
    live_component(socket, InventoryWeb.ModalComponent, modal_opts)
  end

  def assign_current_user(socket, %{"user_token" => user_token}) do
    assign_new(
      socket,
      :current_user,
      fn -> Inventory.Accounts.get_user_by_session_token(user_token) end
    )
  end
end
