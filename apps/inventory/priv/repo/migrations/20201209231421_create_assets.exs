defmodule Inventory.Repo.Migrations.CreateAssets do
  use Ecto.Migration

  def change do
    create table(:assets) do
      add :name, :string
      add :description, :string
      add :serial_number, :string
      add :model_number, :string
      add :manufacturer, :string
      add :amount, :decimal
      add :qr_img, :binary

      timestamps()
    end
  end
end
