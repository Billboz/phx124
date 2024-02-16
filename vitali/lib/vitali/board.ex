defmodule Vitali.Board do
  def width, do: 39
  def height, do: 39

  def new do
    for x <- 0..width(), y <- 0..height(), into: %{}, do: {{x, y}, Enum.random([true, false])}
  end

  def new(cells) do
    for %{x: x, y: y, is_live: is_live} <- cells, into: %{}, do: {{x, y}, is_live}
  end

  def toggle(board, point) do
    old_value = Map.get(board, point)
    Map.put(board, point, !old_value)
  end

  def next(board) do
    for {{x, y}, _} <- board, into: %{}, do: {{x, y}, next_cell(board, {x, y})}
  end

  defp neighbor_count(board, {x, y}) do
    Enum.count([
      # line below self
      Map.get(board, {x - 1, y - 1}, false),
      Map.get(board, {x, y - 1}, false),
      Map.get(board, {x + 1, y - 1}, false),

      # line (without self)
      Map.get(board, {x - 1, y}, false),
      Map.get(board, {x + 1, y}, false),

      # line above self
      Map.get(board, {x - 1, y + 1}, false),
      Map.get(board, {x, y + 1}, false),
      Map.get(board, {x + 1, y + 1}, false)
    ], fn x -> x == true end)
  end

  defp next_cell(board, {x, y}) do
    alive = Map.get(board, {x, y})
    count = neighbor_count(board, {x, y})

    cond do
      count == 2 -> alive
      count == 3 -> true
      count < 2 -> false
      count > 3 -> false
    end
  end
end
