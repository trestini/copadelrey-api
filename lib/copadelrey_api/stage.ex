defmodule Cup.Stage do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stage" do
    field :is_active, :boolean, default: false
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(stage, attrs) do
    stage
    |> cast(attrs, [:name, :is_active])
    |> validate_required([:name, :is_active])
  end
end
