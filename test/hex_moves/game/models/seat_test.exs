defmodule HexMoves.Game.Models.SeatTest do
  use HexMoves.DataCase

  alias HexMoves.Game.Models.Seat

  test "changeset/2 with valid data" do
    game = %HexMoves.Game.Models.Game{id: 1}
    user = %HexMoves.Auth.User{id: 1}

    valid_attrs = %{
      status: :available,
      game_id: game.id,
      user_id: user.id
    }

    changeset = Seat.changeset(valid_attrs)
    assert changeset.valid?
  end
end
