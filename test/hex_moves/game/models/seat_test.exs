defmodule HexMoves.Game.Models.SeatTest do
  import HexMoves.AuthFixtures, only: [user_fixture: 0]

  use HexMoves.DataCase

  alias HexMoves.Game.Models.Seat

  alias HexMoves.Repo

  test "changeset/2 with valid data" do
    game = insert!(:game)
    user = user_fixture()

    valid_attrs = %{
      status: :open,
      game_id: game.id,
      user_id: user.id
    }

    changeset = Seat.changeset(valid_attrs)
    assert changeset.valid?

    assert Repo.insert(changeset)
  end
end
