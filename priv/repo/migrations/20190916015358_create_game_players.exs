defmodule Cup.Repo.Migrations.CreateGamePlayers do
  use Ecto.Migration

  def change do
    create table(:game_players) do
      add :team, :string
      add :game_id, references(:game, on_delete: :nothing)
      add :player_id, references(:player, on_delete: :nothing)

      timestamps()
    end

    create index(:game_players, [:game_id])
    create index(:game_players, [:player_id])
  end
end
