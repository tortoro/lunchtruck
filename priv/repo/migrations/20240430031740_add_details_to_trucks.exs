defmodule Lunchtruck.Repo.Migrations.AddDetailsToTrucks do
  use Ecto.Migration

  def change do
    alter table("trucks") do
      add :details, :text
      add :address, :string
      add :owner,   :string
    end
  end
end
