defmodule VitaliWeb.WatcherLive do
  # alias Vitali.Accounts
  # alias Vitali.Accounts.User
  alias Vitali.{Board, Library}

  import VitaliWeb.CoreComponents

  use VitaliWeb, :live_view

  def render(assigns) do
    ~H"""
    <h1 class="text-4xl text-center">Watcher</h1>
    <div class="flex items-center justify-center">
      <svg width="400" height="400" xmlns="http://www.w3.org/2000/svg">
        <%= for x <- 0..Board.width(), y <- 0..Board.height() do %>
          <% cell = @board[{x, y}] %>
          <.life_cell x={x} y={y} live={cell}/>
        <% end %>
      </svg>
    </div>
    """
  end

  def mount(%{"id" => id}, _session, socket) do
    if connected?(socket), do: Library.subscribe(id)

    board = Library.to_board(id)
    game = Library.get_game!(id)
    {:ok, assign(socket, board: board, game: game)}
  end

  # handle info processes the "next" message from send(self(), "next")
  def handle_info({:next, board}, socket) do
    socket = assign(socket, board: board)
    {:noreply, socket}
  end
end
