defmodule Cup.Repo.Migrations.CreateStage do
  use Ecto.Migration

  def change do
    create table(:stage) do
      add :name, :string
      add :is_active, :boolean, default: false, null: false

      timestamps()
    end

  end
end
