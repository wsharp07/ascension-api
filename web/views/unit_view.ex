defmodule AscensionApi.UnitView do
    use AscensionApi.Web, :view

    def render("unit.json-api", %{unit: unit}) do
        %{service_id: unit.service_id,
          server_id: unit.server_id}
    end
end