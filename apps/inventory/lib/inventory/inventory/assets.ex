defmodule Inventory.Asset do
  use Ecto.Schema
  import Ecto.Changeset

  alias Inventory.Product

  schema "assets" do
    belongs_to(:product, Product)

    field :qr_img, :binary
    field :qr_data, :string

    timestamps()
  end

  @doc false
  def changeset(assets, attrs) do
    assets
    |> cast(attrs, [:qr_data, :qr_img])
    |> validate_required([:qr_data, :qr_img])
    |> unique_constraint([:qr_img])
  end

  def new(%{qr_data: qr_data, qr_img: qr_img}) do
    %__MODULE__{
      qr_data: qr_data,
      qr_img: qr_img
    }
  end

  # CRUD
  def create(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
    |> Inventory.Repo.insert!()
  end

  def read() do
    Inventory.Repo.all(__MODULE__)
  end

  def read(query) do
    Inventory.Repo.get_by(__MODULE__, query)
  end

  def update(original, attrs) do
    original
    |> changeset(attrs)
    |> Inventory.Repo.update()
  end

  def delete(original) do
    original
    |> Inventory.Repo.delete!()
  end
end
