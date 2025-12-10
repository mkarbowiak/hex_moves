defmodule HexMoves.Factory do
  @moduledoc """
  A simple factory module for creating test data.
  """
  alias HexMoves.Repo

  def build(:game) do
    %HexMoves.Game.Models.Game{
      name: "Test Game #{System.unique_integer()}",
      sid: :ra,
      min_seats: 2,
      max_seats: 5,
      status: :waiting_for_players
    }
  end

  @doc """
  Builds a struct for the given factory name with optional attributes.

  Examples:

      iex> HexMoves.Factory.build(:game)
      %HexMoves.Game.Models.Game{id: nil, ...}

      iex> HexMoves.Factory.build(:game, %{name: "Custom Game"})
      %HexMoves.Game.Models.Game{id: nil, name: "Custom Game", ...}
  """
  def build(factory_name, attributes) do
    factory_name |> build() |> struct!(attributes)
  end

  @doc """
  Inserts a struct for the given factory name with optional attributes into the database.

  Examples:

      iex> HexMoves.Factory.insert!(:game)
      %HexMoves.Game.Models.Game{id: 1, ...}

      iex> HexMoves.Factory.insert!(:game, %{name: "Custom Game"})
      %HexMoves.Game.Models.Game{id: 1, name: "Custom Game", ...}
  """
  def insert!(factory_name, attributes \\ []) do
    factory_name |> build(attributes) |> Repo.insert!()
  end
end
