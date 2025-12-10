defmodule HexMoves.Game.Queries.Game do
  @moduledoc """
  This module holds queries related to the Game model.
  """

  import Ecto.Query

  alias HexMoves.Game.Models.Game
  alias HexMoves.Auth.User

  alias HexMoves.Repo

  @doc """
  Returns the list of games in progress for a given user.

  ## Examples

      iex> in_progress(user)
      [%Game{}, ...]

  """
  def all_for_user(%HexMoves.Auth.User{} = user) do
    # [
    #   %HexMoves.Game.Models.Game{
    #     id: 1,
    #     name: "Ra#1",
    #     sid: :ra,
    #     min_seats: 2,
    #     max_seats: 5,
    #     status: :in_progress,
    #     seats: [
    #       %HexMoves.Game.Models.Seat{
    #         id: 1,
    #         game_id: 1,
    #         user_id: 1
    #       }
    #     ]
    #   },
    #   %HexMoves.Game.Models.Game{
    #     id: 2,
    #     name: "Ra#2",
    #     sid: :ra,
    #     min_seats: 2,
    #     max_seats: 5,
    #     status: :in_progress,
    #     seats: []
    #   }
    # ]

    user
    |> visible()
    |> Repo.all()
    |> Repo.preload(:seats)
  end

  defp visible(query \\ Game, %User{id: user_id}) do
    query
    |> from(as: :games)
    |> where([games: g], g.user_id == ^user_id)
  end
end
