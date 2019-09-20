defmodule Cup.Player do
  use Ecto.Schema
  import Ecto.Changeset

  schema "player" do
    field :is_active, :boolean, default: false
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, [:name, :is_active])
    |> validate_required([:name, :is_active])
  end
end
