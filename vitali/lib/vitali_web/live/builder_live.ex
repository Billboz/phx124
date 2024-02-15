defmodule VitaliWeb.BuilderLive do
  # alias Vitali.Accounts
  # alias Vitali.Accounts.User
  alias Vitali.Library
  import VitaliWeb.CoreComponents

  use VitaliWeb, :live_view

  def render(assigns) do
    ~H"""
    <h1 class="text-4xl text-center">Builder</h1>
    <svg width="400" height="400" xmlns="http://www.w3.org/2000/svg">
    <% game = @game %>
    <% cells = @game.cells %>

      <%= for x <- 0..10, y <- 0..10 do %>
      <% cell = Library.get_cell_by(%{x: x, y: y, game_id: @game.id}) %>
        <% is_live = cell.is_live %>

          <.life_cell x={x} y={y} live={is_live}/>
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
    {:ok, game} = Vitali.Library.create_game(%{name: "test1", user_id: 1})
    {:ok, assign(socket, game: game)}
  end

  def handle_event("toggle", %{"live" => false, "id" => id} = attrs, socket) do
    IO.inspect(attrs, label: "attrs - dead")
    {:noreply, socket}
  end

  def handle_event("toggle", %{live: true, id: id} = attrs, socket) do
    IO.inspect(attrs, label: "attrs - live")
    {:noreply, socket}
  end
end
