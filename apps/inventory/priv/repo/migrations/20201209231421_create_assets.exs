defmodule Inventory.Repo.Migrations.CreateAssets do
  use Ecto.Migration

  def change do
    create table(:assets) do
      add :qr_img, :binary
      add :qr_data, :string

      timestamps()
    end

    create unique_index(:assets, [:qr_img])

  end
end
