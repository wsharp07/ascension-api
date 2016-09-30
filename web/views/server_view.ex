defmodule AscensionApi.ServerView do
  use AscensionApi.Web, :view
  require Logger

  attributes [:id, :name, :ip_address, :is_deleted]
  has_many :services, link: "/servers/:id/services"

  def render("index.json-api", %{servers: servers}) do
    Logger.debug "Render many servers"
    %{data: render_many(servers, AscensionApi.ServerView, "server.json")}
  end

  def render("show.json-api", %{server: server}) do
    Logger.debug "Render one server"
    %{data: render_one(server, AscensionApi.ServerView, "server.json")}
  end

  def render("server.json-api", %{server: server}) do
    Logger.debug "Render server json"
    %{id: server.id,
      name: server.name,
      ip_address: server.ip_address,
      is_deleted: server.is_deleted}
  end
end
