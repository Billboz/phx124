defmodule Vitali.Counter do
  defstruct count: 0

  def new() do
    %__MODULE__{}
  end

  def inc(counter) do
    %{counter | count: counter.count + 1}
  end

  def dec(counter) do
    %{counter | count: counter.count - 1}
  end

  def show(counter) do
    counter.count
  end
end
