defmodule Lunchtruck.Repo do
  use Ecto.Repo,
    otp_app: :lunchtruck,
    adapter: Ecto.Adapters.Postgres
end
