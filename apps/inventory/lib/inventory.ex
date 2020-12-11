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
      Enum.map(minimum..maximum, fn n ->
        Inventory.Asset.new_struct_from_map(%{
          name: label,
          qr_code:
            Inventory.QrCode.new_struct_from_binary(label <> n) |> Inventory.QrCodes.create(),
          description: description,
          amount: maximum
        })
      end)

    for asset <- assets do
      Inventory.Assets.create(asset)
    end
  end
end
