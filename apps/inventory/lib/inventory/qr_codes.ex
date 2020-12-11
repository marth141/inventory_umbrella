defmodule Inventory.QrCodes do
  alias Inventory.Repo
  alias Inventory.QrCode

  # CRUD
  def create(%QrCode{} = attrs) do
    attrs
    |> QrCode.changeset()
    |> Repo.insert!()
  end

  def create(%{} = attrs) do
    %QrCode{}
    |> QrCode.changeset(attrs)
    |> Repo.insert!()
  end

  def read() do
    Repo.all(QrCode)
  end

  def read(query) do
    Repo.get_by(QrCode, query)
  end

  def update(%QrCode{} = original, attrs) do
    original
    |> QrCode.changeset(attrs)
    |> Repo.update()
  end

  def delete(%QrCode{} = to_delete) do
    to_delete
    |> Repo.delete!()
  end
end
