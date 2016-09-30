defmodule AscensionApi.Repo.Migrations.AddTableServerService do
  use Ecto.Migration

  def change do
    create table(:units) do
      add :server_id, references(:servers)
      add :service_id, references(:services)
    end
  end
end
