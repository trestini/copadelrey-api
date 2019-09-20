defmodule Cup.GamePlayer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "game_players" do
    field :team, :string
    belongs_to :game, Cup.Game
    belongs_to :player, Cup.Player

    timestamps()
  end

  @doc false
  def changeset(game_player, attrs) do
    game_player
    |> cast(attrs, [:team])
    |> validate_required([:team])
  end
end
