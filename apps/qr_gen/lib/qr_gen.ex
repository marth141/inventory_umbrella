defmodule QrGen do
  @moduledoc """
  Documentation for `QrGen`.
  """

  @doc """
  Creates labels for a given string and count.

  ## Examples

      iex> QrGen.create_labels_for("LAPTOP-0", 0, 100)
      {:ok, results}

  """
  @spec create_labels_for(binary, integer, integer) ::
          {:ok, [%{qr_img: binary(), qr_data: String.t()}]}
  def create_labels_for(label, min \\ 0, max \\ 100) do
    qr_codes =
      Enum.map(min..max, fn n ->
        %{
          qr_img: (label <> to_string(n)) |> EQRCode.encode() |> EQRCode.png(),
          qr_data: label <> to_string(n)
        }
      end)

    # for %{image: image, label: label} <- images do
    #   File.touch(label <> ".png")
    #   File.write(label <> ".png", image, [:binary])
    # end

    {:ok, qr_codes}
  end
end
