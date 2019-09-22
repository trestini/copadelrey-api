defmodule Cup.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "game" do
    field :balls_remaining, :integer
    field :ended, :boolean, default: false
    field :rule, :string
    field :type, :string
    field :winner_team, :string
    belongs_to :stage, Cup.Stage
    many_to_many :players, Cup.Player, join_through: Cup.GamePlayer

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:rule, :type, :ended, :balls_remaining])
    |> validate_required([:rule, :type, :ended, :balls_remaining])
  end
end
