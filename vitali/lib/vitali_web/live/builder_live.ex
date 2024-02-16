defmodule VitaliWeb.BuilderLive do
  # alias Vitali.Accounts
  # alias Vitali.Accounts.User
  alias Vitali.Board

  import VitaliWeb.CoreComponents

  use VitaliWeb, :live_view

  def render(assigns) do
    ~H"""
    <h1 class="text-4xl text-center">Builder</h1>
    <svg width="400" height="400" xmlns="http://www.w3.org/2000/svg">
      <%= for x <- 0..10, y <- 0..10 do %>
      <% cell = @board[{x, y}] %>

          <.life_cell x={x} y={y} live={cell}/>
      <% end %>
    </svg>


    """
  end

  # def render(assigns) do
  #   ~H"""
  #   <.button phx-click="inc">+</.button>
  #   &nbsp;<b><%= @counter.count %></b>&nbsp;
  #   <.button phx-click="dec">-</.button>
  #   """
  # end

  def mount(_params, _session, socket) do
    board = Board.new(10, 10)
    {:ok, game} = Vitali.Library.create_game(%{name: "test1", user_id: 1})
    {:ok, assign(socket, game: game, board: board)}
  end

  def handle_event("toggle", %{"x" => x, "y" => y}, socket) do
    x = String.to_integer(x)
    y = String.to_integer(y)
    board = Board.toggle(socket.assigns.board, {x, y})
    {:noreply, assign(socket, board: board)}
  end
end
