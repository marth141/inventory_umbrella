defmodule Inventory.Repo.Migrations.CreateQrCodes do
  use Ecto.Migration

  def change do
    create table(:qr_codes) do
      add :qr_img, :binary
      add :qr_data, :string

      timestamps()

      add :asset_id, references(:assets, on_delete: :nothing)
    end

    create index(:qr_codes, :asset_id)
  end
end
