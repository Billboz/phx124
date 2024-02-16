defmodule Vitali.LibraryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Vitali.Library` context.
  """

  @doc """
  Generate a game.
  """
  def game_fixture(attrs \\ %{}) do
    {:ok, game} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Vitali.Library.create_game()

    game
  end
end
