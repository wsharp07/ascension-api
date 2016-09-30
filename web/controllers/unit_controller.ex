defmodule AscensionApi.UnitController do
    use AscensionApi.Web, :controller
    alias AscensionApi.Unit
    require Logger

    def create(conn, %{"data" => data}) do
        attrs = JaSerializer.Params.to_attributes(data)
        changeset = Unit.changeset(%Unit{}, attrs)

        case Repo.insert(changeset) do
        {:ok, unit} ->
            conn
            |> put_status(:created)
            |> render("show.json-api", data: unit)
        {:error, changeset} ->
            conn
            |> put_status(:unprocessable_entity)
            |> render(AscensionApi.ChangesetView, "error.json-api", changeset: changeset)
        end
    end
end