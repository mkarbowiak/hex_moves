defmodule HexMoves.FactoryTest do
  use ExUnit.Case

  alias HexMoves.Factory
  alias HexMoves.Game.Models.Game

  describe "Factory.build/1" do
    test "builds a game with default attributes" do
      game = Factory.build(:game)

      assert %Game{} = game
      assert game.sid == :ra
      assert game.min_seats == 2
      assert game.max_seats == 5
      assert game.status == :waiting_for_players
      assert is_binary(game.name)
    end

    test "builds a game with custom attributes" do
      game = Factory.build(:game, %{name: "Custom Game", min_seats: 3})

      assert game.name == "Custom Game"
      assert game.min_seats == 3
      assert game.max_seats == 5
    end

    test "builds a game with keyword list attributes" do
      game = Factory.build(:game, name: "Keyword Game", max_seats: 10)

      assert game.name == "Keyword Game"
      assert game.max_seats == 10
    end
  end
end
