defmodule Cup.Repo.Migrations.CreatePlayer do
  use Ecto.Migration

  def change do
    create table(:player) do
      add :name, :string
      add :is_active, :boolean, default: false, null: false

      timestamps()
    end

  end
end
