defmodule CupWeb.GamePlayer do
  @derive Jason.Encoder
  defstruct [:id, :team, :player]

  @spec from_schema(Cup.GamePlayer.t) :: CupWeb.GamePlayer.t
  def from_schema(game_player) do
    %CupWeb.GamePlayer{
      id: game_player.id,
      team: game_player.team,
      player: game_player.player_id
    }
  end
end
