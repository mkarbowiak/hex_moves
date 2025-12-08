defmodule HexMoves.Game.Queries.Game do
  @moduledoc """
  This module holds queries related to the Game model.
  """

  @doc """
  Returns the list of games in progress for a given user.

  ## Examples

      iex> in_progress(user)
      [%Game{}, ...]

  """
  def in_progress(%HexMoves.Auth.User{id: _user_id}) do
    [
      %HexMoves.Game.Models.Game{
        id: 1,
        name: "Ra#1",
        sid: :ra,
        min_seats: 2,
        max_seats: 5,
        status: :in_progress,
        seats: [
          %HexMoves.Game.Models.Seat{
            id: 1,
            game_id: 1,
            user_id: 1
          }
        ]
      },
      %HexMoves.Game.Models.Game{
        id: 2,
        name: "Ra#2",
        sid: :ra,
        min_seats: 2,
        max_seats: 5,
        status: :in_progress,
        seats: []
      }
    ]

    # Game
    # |> where([g], g.status == ^:in_progress)
    # |> join(:inner, [g], ug in "users_games", on: ug.game_id == g.id)
    # |> where([g, ug], ug.user_id == ^user_id)
    # |> Repo.all()
  end
end
