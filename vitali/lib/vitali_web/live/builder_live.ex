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
        <%= for x <- 0..39, y <- 0..39 do %>
          <% cell = @board[{x, y}] %>
          <.life_cell x={x} y={y} live={cell}/>
        <% end %>
      </svg>
    </div>
    <.button
      phx-click="save"
      phx-disable-with="saving..."
      class="w-full mt-3"
    >
      Save
    </.button>
    """
  end

  def mount(%{"id" => id}, _session, socket) do
    board = Library.to_board(id)
    game = Library.get_game!(id)
    {:ok, assign(socket, board: board, game: game)}
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
end
