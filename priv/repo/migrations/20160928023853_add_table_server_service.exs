defmodule AscensionApi.Repo.Migrations.AddTableServerService do
  use Ecto.Migration

  def change do
    create table(:server_service, primary_key: false) do
      add :server_id, references(:servers)
      add :service_id, references(:services)
    end
  end
end
