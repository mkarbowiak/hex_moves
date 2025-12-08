defmodule HexMoves.Game.Models.Seat do
  use Ecto.Schema
  import Ecto.Changeset

  schema "seats" do
    field :status, Ecto.Enum, values: [:available, :invited, :occupied], default: :available

    belongs_to :game, HexMoves.Game.Models.Game
    belongs_to :user, HexMoves.Auth.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(seat \\ %__MODULE__{}, attrs) do
    seat
    |> cast(attrs, [:status, :game_id, :user_id])
    |> validate_required([:status, :game_id])
  end
end
