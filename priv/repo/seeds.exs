# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Lunchtruck.Repo.insert!(%Lunchtruck.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# San Francisco open data on registered lunch trucks
url = "https://data.sfgov.org/api/views/rqzj-sfat/rows.csv"
