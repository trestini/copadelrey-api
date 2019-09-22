import Ecto.Query, only: [from: 2]

defmodule CupWeb.PlayerController do
  use CupWeb, :controller
  alias Cup.Repo
  alias Cup.Player

  @spec save(Plug.Conn.t(), %{is_active: Boolean.t, name: String.t}) :: Plug.Conn.t()
  def save(conn, %{"is_active" => is_active, "name" => name}) do
    {:ok, _} = Repo.insert %Player{name: name, is_active: is_active}
    conn |> send_resp(201, "")
  end

  @spec remove(Plug.Conn.t(), %{id: Number.t}) :: Plug.Conn.t()
  def remove(conn, %{"id" => id}) do
    Repo.get!(Player, id)
    |> Repo.delete
    json conn, %{}
  end

  @spec list(Plug.Conn.t(), %{like: String.t}) :: Plug.Conn.t()
  def list(conn, %{"like" => filter}) do
    json conn, list_all()
      |> Enum.filter(fn pl ->
        String.contains?(String.downcase(pl.name), String.downcase(filter))
      end)
  end

  def list(conn, %{}) do
    json conn, list_all()
  end

  defp list_all do
    Repo.all(from p in Player, where: p.is_active == true)
      |> Enum.map(&CupWeb.Player.from_schema/1)
  end

end
