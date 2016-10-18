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
alias AscensionApi.Unit

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

[
  %Server{
    name: "HELI201",
    ip_address: "192.168.0.10"
  },
  %Server{
    name: "ARC951",
    ip_address: "172.32.28.1"
  },
  %Server{
    name: "PRD201",
    ip_address: "10.10.2.10"
  }
] |> Enum.each(&Repo.insert!(&1))

[
  %Unit{
    server_id: 1,
    service_id: 1
  }
] |> Enum.each(&Repo.insert!(&1))