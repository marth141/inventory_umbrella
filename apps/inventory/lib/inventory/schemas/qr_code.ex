defmodule Inventory.QrCode do
  use Ecto.Schema
  import Ecto.Changeset

  alias Inventory.Asset

  schema "qr_codes" do
    field :qr_img, :binary
    field :qr_data, :string

    timestamps()

    belongs_to(:asset, Asset)
  end

  @doc false
  def changeset(%__MODULE__{} = qr_code, %{} = attrs \\ %{}) do
    qr_code
    |> cast(attrs, [:qr_data, :qr_img])
    |> validate_required([:qr_data, :qr_img])
    |> unique_constraint(:asset_id)
  end

  def new_struct_from_binary(attrs) do
    {:ok, image} = attrs |> QrGen.create_qr_image()

    %__MODULE__{
      qr_data: attrs,
      qr_img: image
    }
  end
end
