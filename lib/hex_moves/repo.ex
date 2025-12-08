defmodule HexMoves.Repo do
  use Ecto.Repo,
    otp_app: :hex_moves,
    adapter: Ecto.Adapters.Postgres
end
