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

require Logger

alias Lunchtruck.Businesses
alias Lunchtruck.SeedsHelpers

# San Francisco open data on registered lunch trucks
url = "https://data.sfgov.org/api/views/rqzj-sfat/rows.csv"

{:ok, rows} = SeedsHelpers.get_data(url)

Enum.filter(rows, fn truck -> truck["Status"] == "APPROVED" end)
|> Enum.each(fn truck ->
  try do
    attrs = %{name: truck["Applicant"], address: truck["Address"], details: truck["FoodItems"]}
    Businesses.create_truck(attrs)
  rescue
    _error -> Logger.error("Error inserting truck into database.")
  end
end)
