# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     HexMoves.Repo.insert!(%HexMoves.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
user = HexMoves.Repo.get_by!(HexMoves.Auth.User, email: "test@example.com")

HexMoves.Repo.insert_all(HexMoves.Game.Models.Game, [
  %{
    name: "Ra#1",
    sid: :ra,
    min_seats: 2,
    max_seats: 5,
    status: :in_progress,
    inserted_at: DateTime.truncate(DateTime.utc_now(), :second),
    updated_at: DateTime.truncate(DateTime.utc_now(), :second)
  },
  %{
    name: "Brass#1",
    sid: :brass,
    min_seats: 2,
    max_seats: 4,
    status: :in_progress,
    inserted_at: DateTime.truncate(DateTime.utc_now(), :second),
    updated_at: DateTime.truncate(DateTime.utc_now(), :second)
  },
  %{
    name: "War of the Ring#1",
    sid: :wotr,
    min_seats: 2,
    max_seats: 4,
    status: :in_progress,
    inserted_at: DateTime.truncate(DateTime.utc_now(), :second),
    updated_at: DateTime.truncate(DateTime.utc_now(), :second)
  },
  %{
    name: "Ra#2",
    sid: :ra,
    min_seats: 2,
    max_seats: 5,
    status: :waiting_for_players,
    inserted_at: DateTime.truncate(DateTime.utc_now(), :second),
    updated_at: DateTime.truncate(DateTime.utc_now(), :second)
  },
  %{
    name: "Ra#3",
    sid: :ra,
    min_seats: 2,
    max_seats: 5,
    status: :completed,
    inserted_at: DateTime.truncate(DateTime.utc_now(), :second),
    updated_at: DateTime.truncate(DateTime.utc_now(), :second)
  }
])

games = HexMoves.Repo.all(HexMoves.Game.Models.Game)

Enum.each(games, fn game ->
  HexMoves.Repo.insert_all(HexMoves.Game.Models.Seat, [
    %{
      game_id: game.id,
      user_id: user.id,
      status: Enum.random([:taken, :invited]),
      inserted_at: DateTime.truncate(DateTime.utc_now(), :second),
      updated_at: DateTime.truncate(DateTime.utc_now(), :second)
    }
  ])
end)
