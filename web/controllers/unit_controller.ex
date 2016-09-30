defmodule AscensionApi.UnitController do
    use AscensionApi.Web, :controller
    alias AscensionApi.ServerService
    require Logger

    def create(conn, %{"data" => data}) do
        Logger.debug "creating a unit"
        attrs = JaSerializer.Params.to_attributes(data)
        changeset = ServerService.changeset(%ServerService{}, attrs)

        case Repo.insert(changeset) do
        {:ok, server_service} ->
            conn
            |> put_status(:created)
            |> render("show.json-api", data: server_service)
        {:error, changeset} ->
            conn
            |> put_status(:unprocessable_entity)
            |> render(AscensionApi.ChangesetView, "error.json-api", changeset: changeset)
        end
    end
end