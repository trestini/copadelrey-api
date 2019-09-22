defmodule CupWeb.Router do
  use CupWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CupWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/v1", CupWeb do
    pipe_through :api

    post    "/game/:stage_id", GameController, :new_game
    patch   "/game/:game_id", GameController, :patch

    post    "/player", PlayerController, :save
    delete  "/player", PlayerController, :remove
    get     "/player", PlayerController, :list
  end
end
