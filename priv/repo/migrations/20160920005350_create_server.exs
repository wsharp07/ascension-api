defmodule AscensionApi.Repo.Migrations.CreateServer do
  use Ecto.Migration

  def change do
    create table(:servers) do
      add :name, :string
      add :ip_address, :string, size: 15
      add :is_deleted, :boolean, default: false, null: false

      timestamps()
    end
  end
end
