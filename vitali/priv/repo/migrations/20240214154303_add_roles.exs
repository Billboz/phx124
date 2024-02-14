defmodule Vitali.Repo.Migrations.AddRoles do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :roles, {:array, :string}, default: [], null: false
    end
  end
end
