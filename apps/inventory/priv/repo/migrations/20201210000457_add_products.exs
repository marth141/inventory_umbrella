defmodule Inventory.Repo.Migrations.AddProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :description, :string
      add :amount, :decimal

      timestamps()
    end
  end
end
