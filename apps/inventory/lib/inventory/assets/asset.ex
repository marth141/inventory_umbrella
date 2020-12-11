defmodule Inventory.Assets.Asset do
  use Ecto.Schema
  import Ecto.Changeset

  alias Inventory.QrCodes.QrCode

  schema "assets" do
    field :name, :string
    field :description, :string
    field :serial_number, :string
    field :model_number, :string
    field :manufacturer, :string
    field :amount, :decimal

    timestamps()

    has_many(:qr_code, QrCode)
  end

  @doc false
  def changeset(%__MODULE__{} = asset, %{} = attrs \\ %{}) do
    asset
    |> cast(attrs, [:name, :description, :amount])
    |> validate_required([:name, :description])
  end

  def new_struct_from_map(%{name: name, description: description, amount: amount} = _attrs) do
    %__MODULE__{
      name: name,
      description: description,
      amount: amount
    }
  end
end
