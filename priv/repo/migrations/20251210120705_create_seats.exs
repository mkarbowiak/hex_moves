defmodule HexMoves.Repo.Migrations.CreateSeats do
  use Ecto.Migration

  def change do
    create table(:seats) do
      add :status, :string, null: false, default: "open"

      add :game_id, references(:games, on_delete: :delete_all), null: false
      add :user_id, references(:users, on_delete: :nilify_all)

      timestamps()
    end

    create index(:seats, [:game_id])
    create index(:seats, [:user_id])
    create unique_index(:seats, [:game_id, :user_id])
  end
end
