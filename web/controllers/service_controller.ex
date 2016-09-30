defmodule AscensionApi.ServiceController do
  use AscensionApi.Web, :controller
  require Logger

  alias AscensionApi.Service

  def index(conn, _params) do
    services = Repo.all(Service)
    render(conn, "index.json-api", data: services)
  end

  def create(conn, %{"data" => data}) do
    attrs = JaSerializer.Params.to_attributes(data)
    changeset = Service.changeset(%Service{}, attrs)

    case Repo.insert(changeset) do
      {:ok, service} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", service_path(conn, :show, service))
        |> render("show.json-api", data: service)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(AscensionApi.ChangesetView, "error.json-api", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    service = Repo.get!(Service, id)
    render(conn, "show.json-api", data: service)
  end

  def update(conn, %{"id" => id, "service" => service_params}) do
    service = Repo.get!(Service, id)
    changeset = Service.changeset(service, service_params)

    case Repo.update(changeset) do
      {:ok, service} ->
        render(conn, "show.json-api", data: service)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(AscensionApi.ChangesetView, "error.json-api", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    service = Repo.get!(Service, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(service)

    send_resp(conn, :no_content, "")
  end
end
