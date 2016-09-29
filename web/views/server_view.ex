defmodule AscensionApi.ServerView do
  use AscensionApi.Web, :view

  attributes [:id, :name, :ip_address, :is_deleted]
  has_many :services, link: "/server/:id/services"

  def render("index.json-api", %{servers: servers}) do
    %{data: render_many(servers, AscensionApi.ServerView, "server.json")}
  end

  def render("show.json-api", %{server: server}) do
    %{data: render_one(server, AscensionApi.ServerView, "server.json")}
  end

  def render("server.json-api", %{server: server}) do
    %{id: server.id,
      name: server.name,
      ip_address: server.ip_address,
      is_deleted: server.is_deleted}
  end
end
