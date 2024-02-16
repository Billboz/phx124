defmodule Vitali.Library do
  @moduledoc """
  The Library context.
  """

  import Ecto.Query, warn: false
  alias Vitali.Repo

  alias Vitali.Library.{Cell, Game}

  @doc """
  Returns the list of games.

  ## Examples

      iex> list_games()
      [%Game{}, ...]

  """
  def list_games do
    Repo.all(Game)
  end

  @doc """
  Gets a single game.

  Raises `Ecto.NoResultsError` if the Game does not exist.

  ## Examples

      iex> get_game!(123)
      %Game{}

      iex> get_game!(456)
      ** (Ecto.NoResultsError)

  """
  def get_game!(id), do: Repo.get!(Game, id) |> Repo.preload(:cells) |> Repo.preload(:user)

  @doc """
  Creates a game.

  ## Examples

      iex> create_game(%{field: value})
      {:ok, %Game{}}

      iex> create_game(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_game(attrs \\ %{}) do
    return_value =
      %Game{}
      |> Game.changeset(attrs)
      |> Repo.insert()

    {:ok, game} = return_value
    init_cells(game)

    # game
    # |> populate_game_with_cells()

    # # best line of code in the whole project
    {:ok, get_game!(game.id)}
  end

  def init_cells(game) do
    now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

    entries = 
      for x <- 0..10, y <- 0..10 do
        (%{x: x, y: y, game_id: game.id, inserted_at: now, updated_at: now})
      end

    Repo.insert_all(Cell, entries)

    game
  end

  def save_cells(game, board) do
    delete_cells(game)
    now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

    entries = 
      for {{x, y}, alive} <- board do
        (%{x: x, y: y, game_id: game.id, is_live: alive, inserted_at: now, updated_at: now})
      end

    Repo.insert_all(Cell, entries)

    game
  end

  def delete_cells(game) do
    from(c in Cell, where: c.game_id == ^game.id)
    |> Repo.delete_all()
  end

  def new_cell(%{x: _x, y: _y, game_id: _game} = attrs) do
    %Vitali.Library.Cell{} |> Vitali.Library.Cell.changeset(attrs) |> Repo.insert()
  end

  def get_cell_state(%{x: x, y: y, game_id: game_id}) do
    Vitali.Repo.get_by(Vitali.Library.Cell, x: x, y: y, game_id: game_id).is_live
  end

  def get_cell_by(%{x: x, y: y, game_id: game_id}) do
    Vitali.Repo.get_by(Vitali.Library.Cell, x: x, y: y, game_id: game_id)
  end

  @doc """
  Updates a game.

  ## Examples

      iex> update_game(game, %{field: new_value})
      {:ok, %Game{}}

      iex> update_game(game, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_game(%Game{} = game, attrs) do
    game
    |> Game.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a game.

  ## Examples

      iex> delete_game(game)
      {:ok, %Game{}}

      iex> delete_game(game)
      {:error, %Ecto.Changeset{}}

  """
  def delete_game(%Game{} = game) do
    Repo.delete(game)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking game changes.

  ## Examples

      iex> change_game(game)
      %Ecto.Changeset{data: %Game{}}

  """
  def change_game(%Game{} = game, attrs \\ %{}) do
    Game.changeset(game, attrs)
  end
end
