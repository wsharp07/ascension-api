defmodule AscensionApi.ServerControllerTest do
  use AscensionApi.ConnCase

  alias AscensionApi.Server
  @valid_attrs %{ip_address: "10.10.10.10", name: "some content", is_deleted: false}
  @invalid_attrs %{}

  setup %{conn: conn} do
    conn =
      conn
      |> put_req_header("accept", "application/vnd.api+json")
      |> put_req_header("content-type", "application/vnd.api+json")

    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, server_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    server = Repo.insert! %Server{}
    conn = get conn, server_path(conn, :show, server)
    assert json_response(conn, 200)["data"] == %{"attributes" => %{
      "id" => server.id,
      "name" => server.name,
      "ip-address" => server.ip_address,
      "is-deleted" => server.is_deleted},
      "id" => Integer.to_string(server.id),
      "type" => "server", 
      "relationships" => %{
        "services" => %{
          "links" => %{
            "related" => "/servers/#{server.id}/services"
          }
        }
      }
    }
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, server_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    params = Poison.encode!(%{data: %{attributes: @valid_attrs}})
    conn = post conn, server_path(conn, :create), params
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Server, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    params = Poison.encode!(%{data: %{attributes: @invalid_attrs}})
    conn = post conn, server_path(conn, :create), params
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    server = Repo.insert! %Server{}
    conn = put conn, server_path(conn, :update, server), server: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Server, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    server = Repo.insert! %Server{}
    conn = put conn, server_path(conn, :update, server), server: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    server = Repo.insert! %Server{}
    conn = delete conn, server_path(conn, :delete, server)
    assert response(conn, 204)
    refute Repo.get(Server, server.id)
  end
end
