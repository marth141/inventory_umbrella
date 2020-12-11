defmodule Inventory.AssetsTest do
  use Inventory.DataCase

  alias Inventory.Assets

  describe "assets" do
    alias Inventory.Assets.Asset

    @valid_attrs %{amount: "120.5", description: "some description", manufacturer: "some manufacturer", model_number: "some model_number", name: "some name", serial_number: "some serial_number"}
    @update_attrs %{amount: "456.7", description: "some updated description", manufacturer: "some updated manufacturer", model_number: "some updated model_number", name: "some updated name", serial_number: "some updated serial_number"}
    @invalid_attrs %{amount: nil, description: nil, manufacturer: nil, model_number: nil, name: nil, serial_number: nil}

    def asset_fixture(attrs \\ %{}) do
      {:ok, asset} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Assets.create_asset()

      asset
    end

    test "list_assets/0 returns all assets" do
      asset = asset_fixture()
      assert Assets.list_assets() == [asset]
    end

    test "get_asset!/1 returns the asset with given id" do
      asset = asset_fixture()
      assert Assets.get_asset!(asset.id) == asset
    end

    test "create_asset/1 with valid data creates a asset" do
      assert {:ok, %Asset{} = asset} = Assets.create_asset(@valid_attrs)
      assert asset.amount == Decimal.new("120.5")
      assert asset.description == "some description"
      assert asset.manufacturer == "some manufacturer"
      assert asset.model_number == "some model_number"
      assert asset.name == "some name"
      assert asset.serial_number == "some serial_number"
    end

    test "create_asset/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Assets.create_asset(@invalid_attrs)
    end

    test "update_asset/2 with valid data updates the asset" do
      asset = asset_fixture()
      assert {:ok, %Asset{} = asset} = Assets.update_asset(asset, @update_attrs)
      assert asset.amount == Decimal.new("456.7")
      assert asset.description == "some updated description"
      assert asset.manufacturer == "some updated manufacturer"
      assert asset.model_number == "some updated model_number"
      assert asset.name == "some updated name"
      assert asset.serial_number == "some updated serial_number"
    end

    test "update_asset/2 with invalid data returns error changeset" do
      asset = asset_fixture()
      assert {:error, %Ecto.Changeset{}} = Assets.update_asset(asset, @invalid_attrs)
      assert asset == Assets.get_asset!(asset.id)
    end

    test "delete_asset/1 deletes the asset" do
      asset = asset_fixture()
      assert {:ok, %Asset{}} = Assets.delete_asset(asset)
      assert_raise Ecto.NoResultsError, fn -> Assets.get_asset!(asset.id) end
    end

    test "change_asset/1 returns a asset changeset" do
      asset = asset_fixture()
      assert %Ecto.Changeset{} = Assets.change_asset(asset)
    end
  end
end
