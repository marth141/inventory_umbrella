defmodule InventoryWeb.QrCodeLiveTest do
  use InventoryWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Inventory.QrCodes

  @create_attrs %{qr_data: "some qr_data", qr_img: "some qr_img"}
  @update_attrs %{qr_data: "some updated qr_data", qr_img: "some updated qr_img"}
  @invalid_attrs %{qr_data: nil, qr_img: nil}

  defp fixture(:qr_code) do
    {:ok, qr_code} = QrCodes.create_qr_code(@create_attrs)
    qr_code
  end

  defp create_qr_code(_) do
    qr_code = fixture(:qr_code)
    %{qr_code: qr_code}
  end

  describe "Index" do
    setup [:create_qr_code]

    test "lists all qr_codes", %{conn: conn, qr_code: qr_code} do
      {:ok, _index_live, html} = live(conn, Routes.qr_code_index_path(conn, :index))

      assert html =~ "Listing Qr codes"
      assert html =~ qr_code.qr_data
    end

    test "saves new qr_code", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.qr_code_index_path(conn, :index))

      assert index_live |> element("a", "New Qr code") |> render_click() =~
               "New Qr code"

      assert_patch(index_live, Routes.qr_code_index_path(conn, :new))

      assert index_live
             |> form("#qr_code-form", qr_code: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#qr_code-form", qr_code: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.qr_code_index_path(conn, :index))

      assert html =~ "Qr code created successfully"
      assert html =~ "some qr_data"
    end

    test "updates qr_code in listing", %{conn: conn, qr_code: qr_code} do
      {:ok, index_live, _html} = live(conn, Routes.qr_code_index_path(conn, :index))

      assert index_live |> element("#qr_code-#{qr_code.id} a", "Edit") |> render_click() =~
               "Edit Qr code"

      assert_patch(index_live, Routes.qr_code_index_path(conn, :edit, qr_code))

      assert index_live
             |> form("#qr_code-form", qr_code: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#qr_code-form", qr_code: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.qr_code_index_path(conn, :index))

      assert html =~ "Qr code updated successfully"
      assert html =~ "some updated qr_data"
    end

    test "deletes qr_code in listing", %{conn: conn, qr_code: qr_code} do
      {:ok, index_live, _html} = live(conn, Routes.qr_code_index_path(conn, :index))

      assert index_live |> element("#qr_code-#{qr_code.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#qr_code-#{qr_code.id}")
    end
  end

  describe "Show" do
    setup [:create_qr_code]

    test "displays qr_code", %{conn: conn, qr_code: qr_code} do
      {:ok, _show_live, html} = live(conn, Routes.qr_code_show_path(conn, :show, qr_code))

      assert html =~ "Show Qr code"
      assert html =~ qr_code.qr_data
    end

    test "updates qr_code within modal", %{conn: conn, qr_code: qr_code} do
      {:ok, show_live, _html} = live(conn, Routes.qr_code_show_path(conn, :show, qr_code))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Qr code"

      assert_patch(show_live, Routes.qr_code_show_path(conn, :edit, qr_code))

      assert show_live
             |> form("#qr_code-form", qr_code: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#qr_code-form", qr_code: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.qr_code_show_path(conn, :show, qr_code))

      assert html =~ "Qr code updated successfully"
      assert html =~ "some updated qr_data"
    end
  end
end
