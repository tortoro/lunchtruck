defmodule Lunchtruck.Repo.Migrations.CreateTrucks do
  use Ecto.Migration

  def change do
    create table(:trucks) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
