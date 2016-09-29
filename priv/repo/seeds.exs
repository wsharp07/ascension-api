# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     AscensionApi.Repo.insert!(%AscensionApi.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias AscensionApi.Repo
alias AscensionApi.Service
alias AscensionApi.Server
alias AscensionApi.ServerService

[
  %Service{
    name: "LocationService",
    status: :offline
  },
  %Service{
    name: "CatalogService",
    status: :unknown
  },
  %Service{
    name: "MessageService",
    status: :online
  }
] |> Enum.each(&Repo.insert!(&1))