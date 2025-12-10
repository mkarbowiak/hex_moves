defmodule HexMoves.Game.Models.Seat do
  use Ecto.Schema
  import Ecto.Changeset

  schema "seats" do
    field :status, Ecto.Enum, values: [:open, :invited, :taken], default: :open

    belongs_to :game, HexMoves.Game.Models.Game
    belongs_to :user, HexMoves.Auth.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(seat \\ %__MODULE__{}, game, user, attrs) do
    seat
    |> cast(attrs, [:status])
    |> validate_required([:status])
    |> put_assoc(:game, game)
    |> put_assoc(:user, user)
  end

  def update_status_changeset(seat, status) do
    seat
    |> change()
    |> put_change(:status, status)
  end
end
