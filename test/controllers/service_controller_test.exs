defmodule AscensionApi.ServiceControllerTest do
  use AscensionApi.ConnCase

  alias AscensionApi.Service
  @valid_attrs %{name: "some content", status: :unknown, is_deleted: false}
  @invalid_attrs %{}

  setup %{conn: conn} do
    conn =
      conn
      |> put_req_header("accept", "application/vnd.api+json")
      |> put_req_header("content-type", "application/vnd.api+json")

    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, service_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    service = Repo.insert! %Service{}
    conn = get conn, service_path(conn, :show, service)
    assert json_response(conn, 200)["data"] == %{"attributes" => %{
      "id" => service.id,
      "name" => service.name,
      "status" => service.status,
      "is-deleted" => service.is_deleted},
      "id" => Integer.to_string(service.id),
      "type" => "service"}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, service_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, service_path(conn, :create), @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Service, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, service_path(conn, :create), service: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    service = Repo.insert! %Service{}
    conn = put conn, service_path(conn, :update, service), service: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Service, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    service = Repo.insert! %Service{}
    conn = put conn, service_path(conn, :update, service), service: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    service = Repo.insert! %Service{}
    conn = delete conn, service_path(conn, :delete, service)
    assert response(conn, 204)
    refute Repo.get(Service, service.id)
  end
end
