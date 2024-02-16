defmodule Vitali.Library.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field(:name, :string)
    # field(:user_id, :id)
    has_many(:cells, Vitali.Library.Cell)
    belongs_to(:user, Vitali.Accounts.User)

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:name, :user_id])
    |> validate_required([:name, :user_id])
  end
end
