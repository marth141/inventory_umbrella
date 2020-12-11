defmodule Inventory.Assets do
  alias Inventory.Repo
  alias Inventory.Asset

  # CRUD
  def create(%Asset{} = attrs) do
    attrs
    |> Asset.changeset()
    |> Repo.insert!()
  end

  def create(%{} = attrs) do
    %Asset{}
    |> Asset.changeset(attrs)
    |> Repo.insert!()
  end

  def read() do
    Repo.all(Asset)
  end

  def read(query) do
    Repo.get_by(Asset, query)
  end

  def update(%Asset{} = original, attrs) do
    original
    |> Asset.changeset(attrs)
    |> Repo.update()
  end

  def delete(%Asset{} = to_delete) do
    to_delete
    |> Repo.delete!()
  end
end
