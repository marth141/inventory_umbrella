defmodule Inventory.Assets.Asset do
  use Ecto.Schema
  import Ecto.Changeset

  @fields ~w(
    name
    description
    serial_number
    model_number
    manufacturer
    amount
    qr_img
    check_in_date
    check_out_date
  )a

  schema "assets" do
    field :name, :string
    field :description, :string
    field :serial_number, :string
    field :model_number, :string
    field :manufacturer, :string
    field :amount, :decimal
    field :qr_img, :binary
    field :check_in_date, :utc_datetime
    field :check_out_date, :utc_datetime

    belongs_to(:users, Inventory.Accounts.User)

    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = asset, %{} = attrs \\ %{}) do
    asset
    |> cast(attrs, @fields)
    |> cast_assoc(:users)
    |> validate_required([:name, :description])
  end
end

# Adds a user to an asset
# asset = Inventory.Repo.get_by(Inventory.Assets.Asset, name: "Test-1") |> Inventory.Repo.preload(:users)
# asset
# |> Ecto.Changeset.change()
# |> Ecto.Changeset.put_assoc(:users, Inventory.Accounts.get_user!(1))
# |> Inventory.Repo.update()
