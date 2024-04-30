defmodule Lunchtruck.BusinessesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Lunchtruck.Businesses` context.
  """

  @doc """
  Generate a truck.
  """
  def truck_fixture(attrs \\ %{}) do
    {:ok, truck} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Lunchtruck.Businesses.create_truck()

    truck
  end
end
