defmodule HexMoves.Game.Models.GameTest do
  use HexMoves.DataCase

  alias HexMoves.Game.Models.Game

  alias HexMoves.Repo

  test "changeset/2 with valid data" do
    valid_attrs = %{
      name: "Ra",
      sid: :ra,
      min_seats: 2,
      max_seats: 5
    }

    changeset = Game.changeset(valid_attrs)
    assert changeset.valid?

    assert Repo.insert(changeset)
  end

  test "changeset/2 with invalid seats" do
    invalid_attrs = %{
      name: "Ra",
      sid: :ra,
      min_seats: 5,
      max_seats: 2
    }

    changeset = Game.changeset(invalid_attrs)
    refute changeset.valid?

    assert errors_on(changeset) == %{
             max_seats: ["must be greater than min_seats"]
           }
  end
end
