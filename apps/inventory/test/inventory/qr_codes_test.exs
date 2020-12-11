defmodule Inventory.QrCodesTest do
  use Inventory.DataCase

  alias Inventory.QrCodes

  describe "qr_codes" do
    alias Inventory.QrCodes.QrCode

    @valid_attrs %{qr_data: "some qr_data", qr_img: "some qr_img"}
    @update_attrs %{qr_data: "some updated qr_data", qr_img: "some updated qr_img"}
    @invalid_attrs %{qr_data: nil, qr_img: nil}

    def qr_code_fixture(attrs \\ %{}) do
      {:ok, qr_code} =
        attrs
        |> Enum.into(@valid_attrs)
        |> QrCodes.create_qr_code()

      qr_code
    end

    test "list_qr_codes/0 returns all qr_codes" do
      qr_code = qr_code_fixture()
      assert QrCodes.list_qr_codes() == [qr_code]
    end

    test "get_qr_code!/1 returns the qr_code with given id" do
      qr_code = qr_code_fixture()
      assert QrCodes.get_qr_code!(qr_code.id) == qr_code
    end

    test "create_qr_code/1 with valid data creates a qr_code" do
      assert {:ok, %QrCode{} = qr_code} = QrCodes.create_qr_code(@valid_attrs)
      assert qr_code.qr_data == "some qr_data"
      assert qr_code.qr_img == "some qr_img"
    end

    test "create_qr_code/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = QrCodes.create_qr_code(@invalid_attrs)
    end

    test "update_qr_code/2 with valid data updates the qr_code" do
      qr_code = qr_code_fixture()
      assert {:ok, %QrCode{} = qr_code} = QrCodes.update_qr_code(qr_code, @update_attrs)
      assert qr_code.qr_data == "some updated qr_data"
      assert qr_code.qr_img == "some updated qr_img"
    end

    test "update_qr_code/2 with invalid data returns error changeset" do
      qr_code = qr_code_fixture()
      assert {:error, %Ecto.Changeset{}} = QrCodes.update_qr_code(qr_code, @invalid_attrs)
      assert qr_code == QrCodes.get_qr_code!(qr_code.id)
    end

    test "delete_qr_code/1 deletes the qr_code" do
      qr_code = qr_code_fixture()
      assert {:ok, %QrCode{}} = QrCodes.delete_qr_code(qr_code)
      assert_raise Ecto.NoResultsError, fn -> QrCodes.get_qr_code!(qr_code.id) end
    end

    test "change_qr_code/1 returns a qr_code changeset" do
      qr_code = qr_code_fixture()
      assert %Ecto.Changeset{} = QrCodes.change_qr_code(qr_code)
    end
  end
end
