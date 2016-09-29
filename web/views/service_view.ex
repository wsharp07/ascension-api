defmodule AscensionApi.ServiceView do
  use AscensionApi.Web, :view

  attributes [:id, :name, :status, :is_deleted]

  def render("index.json-api", %{services: services}) do
    %{data: render_many(services, AscensionApi.ServiceView, "service.json-api")}
  end

  def render("show.json-api", %{service: service}) do
    %{data: render_one(service, AscensionApi.ServiceView, "service.json-api")}
  end

  def render("service.json-api", %{service: service}) do
    %{id: service.id,
      name: service.name,
      status: service.status,
      is_deleted: service.is_deleted}
  end
end
