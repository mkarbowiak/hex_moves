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
    user
    |> visible()
    |> Repo.all()
    |> Repo.preload(:seats)
  end

  defp visible(query \\ Game, %User{id: user_id}) do
    query
    |> from(as: :games)
    |> join(:left, [games: g], s in assoc(g, :seats), as: :seats)
    |> where([seats: s], s.user_id == ^user_id and s.status in [:taken, :invited])
  end
end
