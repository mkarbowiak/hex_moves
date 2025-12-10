defmodule HexMoves.Game.Models.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :name, :string
    field :sid, Ecto.Enum, values: [:ra, :brass, :wotr]
    field :min_seats, :integer
    field :max_seats, :integer
    field :private, :boolean, default: false

    field :status, Ecto.Enum,
      values: [:waiting_for_players, :in_progress, :finished],
      default: :waiting_for_players

    has_many :seats, HexMoves.Game.Models.Seat

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(game \\ %__MODULE__{}, attrs) do
    game
    |> cast(attrs, [:name, :sid, :min_seats, :max_seats, :status, :private])
    |> validate_required([:name, :sid, :min_seats, :max_seats, :status, :private])
    |> validate_number(:min_seats, greater_than: 0)
    |> validate_number(:max_seats, greater_than: 0)
    |> validate_seats_order()
  end

  def update_status_changeset(game, status) do
    game
    |> change()
    |> put_change(:status, status)
  end

  defp validate_seats_order(changeset) do
    min_seats = get_field(changeset, :min_seats)
    max_seats = get_field(changeset, :max_seats)

    if min_seats && max_seats && min_seats >= max_seats do
      add_error(changeset, :max_seats, "must be greater than min_seats")
    else
      changeset
    end
  end
end
