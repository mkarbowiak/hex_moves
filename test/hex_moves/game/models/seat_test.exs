defmodule HexMoves.Game.Models.SeatTest do
  import HexMoves.AuthFixtures, only: [user_fixture: 0]

  use HexMoves.DataCase

  alias HexMoves.Game.Models.Seat

  alias HexMoves.Repo

  test "changeset/2 with valid data" do
    game = insert!(:game)
    user = user_fixture()

    valid_attrs = %{
      status: :invited
    }

    changeset = Seat.changeset(game, user, valid_attrs)
    assert changeset.valid?

    assert Repo.insert(changeset)
  end
end
