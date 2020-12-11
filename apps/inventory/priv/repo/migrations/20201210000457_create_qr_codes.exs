defmodule Inventory.Repo.Migrations.CreateQrCodes do
  use Ecto.Migration

  def change do
    create table(:qr_codes) do
      add :qr_img, :binary
      add :qr_data, :string

      add :asset, references(:assets)

      timestamps()
    end

    create unique_index(:qr_codes, [:qr_img])
    create unique_index(:qr_codes, [:qr_data])

    alter table(:assets) do
      add :qr_code, references(:qr_codes)
    end
  end
end
