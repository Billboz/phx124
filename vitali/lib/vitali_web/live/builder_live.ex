defmodule VitaliWeb.BuilderLive do
  # alias Vitali.Accounts
  # alias Vitali.Accounts.User
  alias Vitali.{Board, Library}

  import VitaliWeb.CoreComponents

  use VitaliWeb, :live_view

  def render(assigns) do
    ~H"""
    <h1 class="text-4xl text-center">Builder</h1>
    <div class="flex items-center justify-center">
      <svg width="400" height="400" xmlns="http://www.w3.org/2000/svg">
        <%= for x <- 0..Board.width(), y <- 0..Board.height() do %>
          <% cell = @board[{x, y}] %>
          <.life_cell x={x} y={y} live={cell}/>
        <% end %>
      </svg>
    </div>
    <.button
      phx-click="run"
      class="w-full mt-3"
    >
      Run
    </.button>
    <.button
      phx-click="save"
      phx-disable-with="saving..."
      class="w-full mt-3"
    >
      Save
    </.button>
    <.button
      phx-click="next"
      class="w-full mt-2"
    >
      Next
    </.button>
    <.button
      phx-click="random"
      class="w-full mt-2"
    >
      Random
    </.button>
    """
  end

  def mount(%{"id" => id}, _session, socket) do
    board = Library.to_board(id)
    game = Library.get_game!(id)
    {:ok, assign(socket, board: board, game: game)}
  end

  # handle info processes the "next" message from send(self(), "next")
  def handle_info("next", socket) do
    # sends a message to itself to handle the next message (every 250 ms)
    Process.send_after(self(), "next", 250)
    {:noreply, next(socket)}
  end

  # triggers the send message that to handle info
  def handle_event("run", _attrs, socket) do
    send(self(), "next")
    {:noreply, socket}
  end

  # triggers only ONE next generation
  def handle_event("next", _attrs, socket) do
    {:noreply, next(socket)}
  end

  def handle_event("toggle", %{"x" => x, "y" => y}, socket) do
    x = String.to_integer(x)
    y = String.to_integer(y)
    board = Board.toggle(socket.assigns.board, {x, y})
    {:noreply, assign(socket, board: board)}
  end

  def handle_event("save", _attrs, socket) do
    game = socket.assigns.game
    Library.save_cells(game, socket.assigns.board)
    {:noreply, socket}
  end

  def handle_event("random", _attrs, socket) do
    board = Board.new()
    {:noreply, assign(socket, board: board)}
  end

  defp next(socket) do
    board = Board.next(socket.assigns.board)
    assign(socket, board: board)
  end
end
