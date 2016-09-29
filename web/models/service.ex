defmodule AscensionApi.Service do
  use AscensionApi.Web, :model

  schema "services" do
    field :name, :string
    field :status, AscensionApi.Service.Status
    field :is_deleted, :boolean, default: false

    timestamps()

    many_to_many :servers, AscensionApi.Server, join_through: AscensionApi.ServerService
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :status, :is_deleted])
    |> validate_required([:name, :status, :is_deleted])
  end
end
