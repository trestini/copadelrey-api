defmodule CupWeb.Stage do
  @derive Jason.Encoder
  defstruct [:id, :name]

  @spec from_schema(Cup.Stage.t) :: CupWeb.Stage.t
  def from_schema(stage) do
    %CupWeb.Stage{
      id: stage.id,
      name: stage.name
    }
  end
end
