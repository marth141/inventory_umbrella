defmodule Inventory.Assets do
  import Ecto.Changeset
  alias Inventory.Repo
  alias Inventory.Assets.Asset

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

  @doc """
  Returns the list of assets.

  ## Examples

      iex> list_assets()
      [%Asset{}, ...]

  """
  def list_assets do
    Repo.all(Asset)
  end

  @doc """
  Gets a single asset.

  Raises `Ecto.NoResultsError` if the Asset does not exist.

  ## Examples

      iex> get_asset!(123)
      %Asset{}

      iex> get_asset!(456)
      ** (Ecto.NoResultsError)

  """
  def get_asset!(id), do: Repo.get!(Asset, id)

  @doc """
  Creates a asset.

  ## Examples

      iex> create_asset(%{field: value})
      {:ok, %Asset{}}

      iex> create_asset(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_asset(attrs \\ %{}) do
    with qr_code <- Inventory.QrCodes.new_from_binary(attrs["name"]) do
      %Asset{}
      |> Asset.changeset(attrs |> Map.put("qr_code", qr_code))
      |> Repo.insert()
    end
  end

  @doc """
  Updates a asset.

  ## Examples

      iex> update_asset(asset, %{field: new_value})
      {:ok, %Asset{}}

      iex> update_asset(asset, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_asset(%Asset{} = asset, attrs) do
    asset
    |> Asset.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a asset.

  ## Examples

      iex> delete_asset(asset)
      {:ok, %Asset{}}

      iex> delete_asset(asset)
      {:error, %Ecto.Changeset{}}

  """
  def delete_asset(%Asset{} = asset) do
    Repo.delete(asset)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking asset changes.

  ## Examples

      iex> change_asset(asset)
      %Ecto.Changeset{data: %Asset{}}

  """
  def change_asset(%Asset{} = asset, attrs \\ %{}) do
    Asset.changeset(asset, attrs)
  end
end
