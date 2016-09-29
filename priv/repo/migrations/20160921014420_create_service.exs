defmodule AscensionApi.Repo.Migrations.CreateService do
  use Ecto.Migration

  def change do
    create table(:services) do
      add :name, :string
      add :status, :string
      add :is_deleted, :boolean, default: false, null: false

      timestamps()
    end
    create index(:services, [:name, :is_deleted], unique: true)
  end
end
