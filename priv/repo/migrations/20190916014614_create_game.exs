defmodule Cup.Repo.Migrations.CreateGame do
  use Ecto.Migration

  def change do
    create table(:game) do
      add :rule, :string
      add :type, :string
      add :ended, :boolean, default: false, null: false
      add :balls_remaining, :integer
      add :stage_id, references(:stage, on_delete: :nothing)

      timestamps()
    end

    create index(:game, [:stage_id])
  end
end
