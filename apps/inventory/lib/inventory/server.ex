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

  def handle_info(_, state) do
    {:noreply, state}
  end

  def handle_info({:qr_code_scanned, qr_contents}, _state), do: IO.inspect(qr_contents)

  def handle_continue(:init, state) do
    {:noreply, %{state | last_refresh: DateTime.utc_now()}}
  end
end
