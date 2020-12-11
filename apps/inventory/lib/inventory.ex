defmodule Inventory do
  @moduledoc """
  Inventory keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  @defaults %{minimum: 1, maximum: 1}

  def create_inventory_for(opts \\ []) do
    label = Keyword.get(opts, :label)
    description = Keyword.get(opts, :description)
    %{minimum: minimum, maximum: maximum} = Enum.into(opts, @defaults)

    assets =
      Enum.map(minimum..maximum, fn _n ->
        Inventory.Asset.new_struct_from_map(%{
          name: label,
          description: description,
          amount: maximum
        })
        |> Inventory.Repo.preload(:qr_codes)
      end)
      |> Enum.map(fn asset ->
        qr_code =
          Inventory.QrCode.new_struct_from_binary(asset.name <> to_string(asset.id))
          |> Inventory.QrCodes.create()

        Inventory.Asset.changeset(asset, %{
          qr_code: qr_code
        })
      end)
      |> IO.inspect()

    for asset <- assets do
      Inventory.Assets.create(asset.data)
    end
  end

  def test() do
    for x <- 1..5, y <- 6..10 do
      {x, y}
    end
  end
end
