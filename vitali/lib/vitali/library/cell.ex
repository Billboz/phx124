defmodule Vitali.Library.Cell do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cells" do
    field(:y, :integer)
    field(:x, :integer)
    field(:is_live, :boolean, default: false)
    # field(:game_id, :id)

    belongs_to(:game, Vitali.Library.Game)

    timestamps()
  end

  @doc false
  def changeset(cell, attrs) do
    cell
    |> cast(attrs, [:x, :y, :game_id])
    |> validate_required([:x, :y, :game_id])
  end
end
