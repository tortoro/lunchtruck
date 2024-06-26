defmodule Lunchtruck.Businesses.Truck do
  use Ecto.Schema
  import Ecto.Changeset

  schema "trucks" do
    field :name,    :string
    field :details, :string
    field :address, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(truck, attrs) do
    truck
    |> cast(attrs, [:name, :details, :address])
    |> validate_required([:name])
  end
end
