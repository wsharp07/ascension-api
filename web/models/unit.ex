defmodule AscensionApi.Unit do
  use AscensionApi.Web, :model

  @primary_key false
  schema "units" do
    belongs_to :server, AscensionApi.Server
    belongs_to :service, AscensionApi.Service
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:server_id, :service_id])
    |> validate_required([:server_id, :service_id])
  end
end