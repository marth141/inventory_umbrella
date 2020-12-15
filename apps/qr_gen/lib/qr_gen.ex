defmodule QrGen do
  @moduledoc """
  Documentation for `QrGen`.
  """

  @spec write_qr_images_for(binary, integer, integer) ::
          {:ok, [%{qr_img: binary(), qr_data: String.t()}]}
  @doc """
  Creates labels for a given string and count.

  ## Examples

      iex> QrGen.create_labels_for("LAPTOP-0", 0, 100)
      {:ok, results}

  """
  def write_qr_images_for(label \\ "Test-", min \\ 1, max \\ 1) do
    qr_codes =
      Enum.map(min..max, fn n ->
        %{
          qr_img: (label <> to_string(n)) |> EQRCode.encode() |> EQRCode.png(),
          qr_data: label <> to_string(n)
        }
      end)

    for %{qr_img: image, qr_data: label} <- qr_codes do
      File.touch(label <> ".png")
      File.write(label <> ".png", image, [:binary])
    end

    {:ok, qr_codes}
  end

  @spec create_qr_image(binary) :: {:ok, binary}
  @doc """
  Creates image for a given binary.

  ## Examples

      iex> QrGen.create_qr_image("Test-1")
      {:ok, image}

  """
  def create_qr_image(data) do
    {:ok,
     data
     |> EQRCode.encode()
     |> EQRCode.png()}
  end

  @spec create_qr_image!(binary) :: binary
  @doc """
  Creates image for a given binary.

  ## Examples

      iex> QrGen.create_qr_image("Test-1")
      image

  """
  def create_qr_image!(data) do
    data
    |> EQRCode.encode()
    |> EQRCode.png()
  end
end
