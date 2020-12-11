defmodule Inventory do
  @moduledoc """
  Inventory keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  import Ecto.Changeset

  def create_inventory_for(label, description, minimum \\ 1, maximum \\ 1) do
    Enum.map(minimum..maximum, fn _n ->
      %{
        name: label,
        description: description,
        amount: maximum
      }
    end)
    |> Enum.map(fn map ->
      Inventory.Assets.Asset.new_struct_from_map(map)
      |> Inventory.Assets.Asset.changeset()
      |> put_assoc(:qr_code, [Inventory.QrCodes.QrCode.new_struct_from_binary(map.name)])
    end)
    |> Enum.map(fn asset -> Inventory.Repo.insert(asset) end)
  end

  def test() do
    Inventory.create_inventory_for("Lappy", "Strongbad's computer")
  end
end
