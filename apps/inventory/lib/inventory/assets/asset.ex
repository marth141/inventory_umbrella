defmodule Inventory.Assets.Asset do
  use Ecto.Schema
  import Ecto.Changeset

  @fields ~w(
    name
    description
    serial_number
    manufacturer
    amount
    qr_img
  )a

  schema "assets" do
    field :name, :string
    field :description, :string
    field :serial_number, :string
    field :model_number, :string
    field :manufacturer, :string
    field :amount, :decimal
    field :qr_img, :binary

    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = asset, %{} = attrs \\ %{}) do
    asset
    |> cast(attrs, @fields)
    |> validate_required([:name, :description])
  end
end
