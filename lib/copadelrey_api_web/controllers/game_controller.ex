defmodule CupWeb.GameController do
  use CupWeb, :controller
  alias Cup.Repo
  alias Cup.Game

  def index(conn, _params) do
    games = Repo.all(Game)
      |> Repo.preload([:stage, :players])
      |> Stream.map(&CupWeb.Game.from_schema(&1))
      |> Enum.to_list()
    json conn, games
  end
end
