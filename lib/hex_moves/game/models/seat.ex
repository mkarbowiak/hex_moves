defmodule HexMoves.Game.Models.Seat do
  use Ecto.Schema
  import Ecto.Changeset

  schema "seats" do
    field :status, Ecto.Enum, values: [:invited, :joined], default: :invited
    field :owner, :boolean, default: false

    belongs_to :game, HexMoves.Game.Models.Game
    belongs_to :user, HexMoves.Auth.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(seat \\ %__MODULE__{}, game, user, attrs) do
    seat
    |> cast(attrs, [:status, :owner])
    |> validate_required([:status, :owner])
    |> put_assoc(:game, game)
    |> put_assoc(:user, user)
  end

  def update_status_changeset(seat, status) do
    seat
    |> change()
    |> put_change(:status, status)
  end
end
