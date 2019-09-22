import Ecto.Query, only: [from: 2]

defmodule CupWeb.GameController do
  use CupWeb, :controller
  alias Cup.Repo
  alias Cup.Game
  alias Cup.Stage

  def new_game(conn, parameters) do

    params = Map.take(parameters, ["rule", "balls_remaining", "teams"])
      |> Map.put("stage", Repo.get!(Stage, String.to_integer(parameters["stage_id"])))

    game = to_struct(Game, params)

    inserted = Repo.transaction(fn ->
      # game = %Game{
      #   balls_remaining: (if balls_remaining, do: balls_remaining, else: nil),
      #   rule: (if rule, do: rule, else: nil),
      #   ended: false,
      #   stage: Repo.one(from s in Stage, where: s.id == ^stage_id)
      # }

      {:ok, new_game} = Repo.insert game

      params["teams"] |> Enum.map(fn t ->
        Enum.map(t["players"], fn pl ->
          %Cup.GamePlayer{
            team: t["name"],
            game_id: new_game.id,
            player_id: pl
          } |> Repo.insert
        end)
      end)

      Repo.preload(new_game, [:stage, :players])
    end)

    case inserted do
      {:ok, inserted} -> json conn, CupWeb.Game.from_schema(inserted)
      {:error, error} ->
        conn
        |> put_status(:bad_request)
        |> json(%{code: 400, message: error})
    end

  end

  def patch(conn, params) do

    changes = Map.take(params, ["balls_remaining", "ended", "rule", "winner_team"])
    |> Enum.map(fn({key, value}) -> {String.to_existing_atom(key), value} end)

    case {params["ended"], params["winner_team"]} do
      {true, nil} ->
        conn
        |> put_status(:bad_request)
        |> json(%{code: 400, message: "winner team must be provided"})
      _ ->
        changeset = Repo.get!(Game, params["game_id"])
        |> Repo.preload([:stage, :players])
        |> Ecto.Changeset.change(changes)

        case Repo.update changeset do
          {:ok, game} -> json conn, CupWeb.Game.from_schema(game)
          {:error, _changeset} -> conn |> send_resp(414, "")
      end
    end

  end

  defp to_struct(kind, attrs) do
    struct = struct(kind)
    Enum.reduce Map.to_list(struct), struct, fn {k, _}, acc ->
      case Map.fetch(attrs, Atom.to_string(k)) do
        {:ok, v} -> %{acc | k => v}
        :error -> acc
      end
    end
  end


end

