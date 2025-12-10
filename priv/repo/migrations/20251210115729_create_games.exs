defmodule HexMoves.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :name, :string, null: false
      add :sid, :string, null: false
      add :min_seats, :integer, null: false
      add :max_seats, :integer, null: false
      add :status, :string, null: false, default: "waiting_for_players"
      add :private, :boolean, null: false, default: false

      timestamps()
    end

    create index(:games, [:sid])
    create unique_index(:games, [:name])
  end
end
