defmodule Inventory.Assets do
  alias Inventory.Repo
  alias Inventory.Assets.Asset

  def topic(), do: inspect(__MODULE__)

  def subscribe, do: Messaging.subscribe(topic())

  def new_asset_from_map(%{name: name, description: description, amount: amount} = _attrs) do
    %Asset{
      name: name,
      description: description,
      amount: amount,
      qr_img: QrGen.create_qr_image!(name)
    }
    |> Asset.changeset()
  end

  def fetch_asset_by_name(name) do
    case Inventory.Repo.get_by(Inventory.Assets.Asset, name: name) do
      nil -> {:error, "Not found"}
      asset -> asset
    end
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
    image = QrGen.create_qr_image!(attrs["name"])
    new_attrs = Map.put_new(attrs, "qr_img", image)

    %Asset{}
    |> Asset.changeset(new_attrs)
    |> Repo.insert()
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
    with {:ok, image} <- QrGen.create_qr_image(attrs["name"]) do
      asset
      |> Asset.changeset(Map.put(attrs, "qr_img", image))
      |> Repo.update()
    end
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
