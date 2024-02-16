defmodule Vitali.Board do
  def new(h, w) do
    for x <- 0..w, y <- 0..h, into: %{}, do: {{x, y}, Enum.random([true, false])}
  end

  def toggle(board, point) do
    old_value = Map.get(board, point)
    Map.put(board, point, !old_value)
  end
end
