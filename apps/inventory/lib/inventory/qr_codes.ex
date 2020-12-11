defmodule Inventory.QrCodes do
  alias Inventory.Repo
  alias Inventory.QrCodes.QrCode

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

  alias Inventory.QrCodes.QrCode

  @doc """
  Returns the list of qr_codes.

  ## Examples

      iex> list_qr_codes()
      [%QrCode{}, ...]

  """
  def list_qr_codes do
    Repo.all(QrCode)
  end

  @doc """
  Gets a single qr_code.

  Raises `Ecto.NoResultsError` if the Qr code does not exist.

  ## Examples

      iex> get_qr_code!(123)
      %QrCode{}

      iex> get_qr_code!(456)
      ** (Ecto.NoResultsError)

  """
  def get_qr_code!(id), do: Repo.get!(QrCode, id)

  @doc """
  Creates a qr_code.

  ## Examples

      iex> create_qr_code(%{field: value})
      {:ok, %QrCode{}}

      iex> create_qr_code(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_qr_code(attrs \\ %{}) do
    %QrCode{}
    |> QrCode.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a qr_code.

  ## Examples

      iex> update_qr_code(qr_code, %{field: new_value})
      {:ok, %QrCode{}}

      iex> update_qr_code(qr_code, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_qr_code(%QrCode{} = qr_code, attrs) do
    qr_code
    |> QrCode.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a qr_code.

  ## Examples

      iex> delete_qr_code(qr_code)
      {:ok, %QrCode{}}

      iex> delete_qr_code(qr_code)
      {:error, %Ecto.Changeset{}}

  """
  def delete_qr_code(%QrCode{} = qr_code) do
    Repo.delete(qr_code)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking qr_code changes.

  ## Examples

      iex> change_qr_code(qr_code)
      %Ecto.Changeset{data: %QrCode{}}

  """
  def change_qr_code(%QrCode{} = qr_code, attrs \\ %{}) do
    QrCode.changeset(qr_code, attrs)
  end
end
