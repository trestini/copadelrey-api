import Ecto.Query, only: [from: 2]

defmodule CupWeb.GameController do
  use CupWeb, :controller
  alias Cup.Repo
  alias Cup.Game
  alias Cup.Stage

  def new_game(conn, %{
    "stage_id" => stage_id,
    "balls_remaining" => balls_remaining,
    "rule" => rule,
    "ended" => ended,
    "teams" => teams
  }) do

    Repo.transaction(fn ->
      game = %Game{
        balls_remaining: balls_remaining,
        rule: rule,
        ended: ended,
        stage: Repo.one(from s in Stage, where: s.id == ^stage_id)
      }

      {:ok, new_game} = Repo.insert game

      teams |> Enum.map(fn t ->
        Enum.map(t["players"], fn pl ->
          %Cup.GamePlayer{
            team: t["name"],
            game_id: new_game.id,
            player_id: pl
          } |> Repo.insert
        end)
      end)
    end)

    conn |> send_resp(201, "")
  end
end
