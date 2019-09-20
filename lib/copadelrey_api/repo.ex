defmodule Cup.Repo do
  use Ecto.Repo,
    otp_app: :copadelrey_api,
    adapter: Ecto.Adapters.Postgres
end
