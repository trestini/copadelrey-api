defmodule CupWeb.Game do
  @derive Jason.Encoder
  defstruct [:id, :date, :stage, :players, :balls_remaining, :rule, :ended, :winner_team, :teams]

  @spec from_schema(Cup.Game.t) :: CupWeb.Game.t
  def from_schema(game) do
    %CupWeb.Game{
      id: game.id,
      date: game.inserted_at,
      stage: game.stage |> CupWeb.Stage.from_schema,
      players: game.players |> Enum.map(&CupWeb.Player.from_schema(&1)),
      balls_remaining: game.balls_remaining,
      rule: game.rule,
      ended: game.ended,
      winner_team: game.winner_team
    }
  end
end
