defmodule VitaliWeb.CounterLive do
  alias Vitali.Counter

  use VitaliWeb, :live_view

  def render(assigns) do
    ~H"""
    <.button phx-click="inc">+</.button>
    &nbsp;<b><%= @counter.count %></b>&nbsp;
    <.button phx-click="dec">-</.button>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, counter: Counter.new())}
  end

  def handle_event("inc", _, socket) do
    new_counter = Counter.inc(socket.assigns.counter)
    {:noreply, assign(socket, counter: new_counter)}
  end

  def handle_event("dec", _, socket) do
    new_counter = Counter.dec(socket.assigns.counter)
    {:noreply, assign(socket, counter: new_counter)}
  end
end
