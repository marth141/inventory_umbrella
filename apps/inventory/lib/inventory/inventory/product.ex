defmodule Inventory.Product do
  use Ecto.Schema
  import Ecto.Changeset

  alias Inventory.Asset

  schema "products" do
    field :name, :string
    field :description, :string
    field :amount, :decimal

    has_many(:assets, Asset)

    timestamps()
  end

  @doc false
  def changeset(assets, attrs) do
    assets
    |> cast(attrs, [:name, :description, :amount])
    |> validate_required([:name, :description])
  end

  # def count_of_assets(product_id) do
  #   from(a in Asset, where: a.product_id == ^product_id, select: count())
  #   |> Repo.one()
  # end
end
