defmodule Inventory.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Inventory.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Inventory.PubSub},
      # Start a worker by calling: Inventory.Worker.start_link(arg)
      # {Inventory.Worker, arg}
      {Inventory.Server, []}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Inventory.Supervisor)
  end
end
