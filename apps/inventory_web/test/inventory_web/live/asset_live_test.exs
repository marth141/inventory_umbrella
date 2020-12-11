defmodule InventoryWeb.AssetLiveTest do
  use InventoryWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Inventory.Assets

  @create_attrs %{amount: "120.5", description: "some description", manufacturer: "some manufacturer", model_number: "some model_number", name: "some name", serial_number: "some serial_number"}
  @update_attrs %{amount: "456.7", description: "some updated description", manufacturer: "some updated manufacturer", model_number: "some updated model_number", name: "some updated name", serial_number: "some updated serial_number"}
  @invalid_attrs %{amount: nil, description: nil, manufacturer: nil, model_number: nil, name: nil, serial_number: nil}

  defp fixture(:asset) do
    {:ok, asset} = Assets.create_asset(@create_attrs)
    asset
  end

  defp create_asset(_) do
    asset = fixture(:asset)
    %{asset: asset}
  end

  describe "Index" do
    setup [:create_asset]

    test "lists all assets", %{conn: conn, asset: asset} do
      {:ok, _index_live, html} = live(conn, Routes.asset_index_path(conn, :index))

      assert html =~ "Listing Assets"
      assert html =~ asset.description
    end

    test "saves new asset", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.asset_index_path(conn, :index))

      assert index_live |> element("a", "New Asset") |> render_click() =~
               "New Asset"

      assert_patch(index_live, Routes.asset_index_path(conn, :new))

      assert index_live
             |> form("#asset-form", asset: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#asset-form", asset: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.asset_index_path(conn, :index))

      assert html =~ "Asset created successfully"
      assert html =~ "some description"
    end

    test "updates asset in listing", %{conn: conn, asset: asset} do
      {:ok, index_live, _html} = live(conn, Routes.asset_index_path(conn, :index))

      assert index_live |> element("#asset-#{asset.id} a", "Edit") |> render_click() =~
               "Edit Asset"

      assert_patch(index_live, Routes.asset_index_path(conn, :edit, asset))

      assert index_live
             |> form("#asset-form", asset: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#asset-form", asset: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.asset_index_path(conn, :index))

      assert html =~ "Asset updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes asset in listing", %{conn: conn, asset: asset} do
      {:ok, index_live, _html} = live(conn, Routes.asset_index_path(conn, :index))

      assert index_live |> element("#asset-#{asset.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#asset-#{asset.id}")
    end
  end

  describe "Show" do
    setup [:create_asset]

    test "displays asset", %{conn: conn, asset: asset} do
      {:ok, _show_live, html} = live(conn, Routes.asset_show_path(conn, :show, asset))

      assert html =~ "Show Asset"
      assert html =~ asset.description
    end

    test "updates asset within modal", %{conn: conn, asset: asset} do
      {:ok, show_live, _html} = live(conn, Routes.asset_show_path(conn, :show, asset))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Asset"

      assert_patch(show_live, Routes.asset_show_path(conn, :edit, asset))

      assert show_live
             |> form("#asset-form", asset: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#asset-form", asset: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.asset_show_path(conn, :show, asset))

      assert html =~ "Asset updated successfully"
      assert html =~ "some updated description"
    end
  end
end
