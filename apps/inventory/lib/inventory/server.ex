defmodule Inventory.Server do
  use GenServer

  def start_link(_) do
    GenServer.start_link(
      # module genserver will call
      __MODULE__,
      # init params
      [],
      name: __MODULE__
    )
  end

  def init(_opts) do
    Messaging.subscribe(Inventory.topic())
    {:ok, %{last_refresh: nil}, {:continue, :init}}
  end

  def handle_info({:retrieve_asset, msg}, state) do
    Messaging.publish(
      {:asset_retrieved, Inventory.Repo.get_by(Inventory.Assets.Asset, name: msg)},
      Inventory.topic()
    )

    {:noreply, state}
  end

  def handle_info(_, state) do
    {:noreply, state}
  end

  def handle_continue(:init, state) do
    {:noreply, %{state | last_refresh: DateTime.utc_now()}}
  end
end
