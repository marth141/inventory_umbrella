defmodule Inventory do
  @moduledoc """
  Inventory keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def create_inventory_for(label, description, minimum \\ 1, maximum \\ 1) do
    inventory =
      Enum.map(minimum..maximum, fn _n ->
        %{
          name: label,
          description: description,
          amount: maximum
        }
      end)
      |> Enum.map(fn map ->
        Inventory.Assets.new_asset_from_map(map)
      end)

    Inventory.Repo.insert_all(Inventory.Assets.Asset, inventory)
  end

  def test() do
    Inventory.create_inventory_for("Lappy", "Strongbad's computer")
  end
end
