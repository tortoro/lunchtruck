defmodule Lunchtruck.SeedsHelpers do
  def get_data(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, parse_csv(body)}
      {:ok, %HTTPoison.Response{status_code: code}} ->
        {:error, "Failed to retrieve CSV with status: #{code}"}
      {:error, error} ->
        {:error, "Failed to retrieve CSV with error: #{error}"}
    end
  end

  defp parse_csv(body) do
    [headers | rows] = body
                       |> String.split("\n")
                       |> Enum.map(&String.split(&1, ","))

    rows |> Enum.map(&parse_row(&1, headers))
  end

  defp parse_row(row, headers) do
    Enum.zip(headers, row) |> Enum.into(%{})
  end
end
