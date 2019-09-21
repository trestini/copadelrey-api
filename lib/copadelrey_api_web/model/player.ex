defmodule CupWeb.Player do
  @derive Jason.Encoder
  defstruct [:id, :name, :is_active]

  @spec from_schema(Cup.Player.t) :: CupWeb.Player.t
  def from_schema(player) do
    %CupWeb.Player{
      id: player.id,
      name: player.name,
      is_active: player.is_active
    }
  end
end
