defmodule AscensionApi.Server do
  use AscensionApi.Web, :model

  schema "servers" do
    field :name, :string
    field :ip_address, :string
    field :is_deleted, :boolean, default: false
    
    timestamps()

    many_to_many :services, AscensionApi.Service, join_through: AscensionApi.ServerService
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :ip_address])
    |> validate_required([:name, :ip_address])
  end
end
