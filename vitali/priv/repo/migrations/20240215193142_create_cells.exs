defmodule Vitali.Repo.Migrations.CreateCells do
  use Ecto.Migration

  def change do
    create table(:cells) do
      add(:x, :integer)
      add(:y, :integer)
      add(:is_live, :boolean, default: false, null: false)
      add(:game_id, references(:games, on_delete: :delete_all), null: false)

      timestamps()
    end

    create(index(:cells, [:game_id]))
  end
end
