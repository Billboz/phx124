defmodule Vitali.LibraryTest do
  use Vitali.DataCase

  alias Vitali.Library

  describe "games" do
    alias Vitali.Library.Game

    import Vitali.LibraryFixtures

    @invalid_attrs %{name: nil}

    test "list_games/0 returns all games" do
      game = game_fixture()
      assert Library.list_games() == [game]
    end

    test "get_game!/1 returns the game with given id" do
      game = game_fixture()
      assert Library.get_game!(game.id) == game
    end

    test "create_game/1 with valid data creates a game" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Game{} = game} = Library.create_game(valid_attrs)
      assert game.name == "some name"
    end

    test "create_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Library.create_game(@invalid_attrs)
    end

    test "update_game/2 with valid data updates the game" do
      game = game_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Game{} = game} = Library.update_game(game, update_attrs)
      assert game.name == "some updated name"
    end

    test "update_game/2 with invalid data returns error changeset" do
      game = game_fixture()
      assert {:error, %Ecto.Changeset{}} = Library.update_game(game, @invalid_attrs)
      assert game == Library.get_game!(game.id)
    end

    test "delete_game/1 deletes the game" do
      game = game_fixture()
      assert {:ok, %Game{}} = Library.delete_game(game)
      assert_raise Ecto.NoResultsError, fn -> Library.get_game!(game.id) end
    end

    test "change_game/1 returns a game changeset" do
      game = game_fixture()
      assert %Ecto.Changeset{} = Library.change_game(game)
    end
  end
end
