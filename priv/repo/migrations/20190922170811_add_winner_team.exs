defmodule Cup.Repo.Migrations.AddWinnerTeam do
  use Ecto.Migration

  def change do
    alter table "game" do
      add :winner_team, :string
    end
  end
end
