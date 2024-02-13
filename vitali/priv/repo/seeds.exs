# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Vitali.Repo.insert!(%Vitali.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# email and password for each user
users = [
  %{email: "batman@example.com", password: "password"},
  %{email: "wolverine@example.com", password: "password"},
  %{email: "hulk@example.com", password: "password"},
  %{email: "drmanhattan@example.com", password: "password"},
  %{email: "ironman@example.com", password: "password"}
  ]

Enum.map(users, fn user -> Vitali.Accounts.User.register_user(%Vitali.Accounts.User{}, user) end)
