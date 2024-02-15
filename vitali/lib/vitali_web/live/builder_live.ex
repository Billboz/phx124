defmodule VitaliWeb.BuilderLive do
  # alias Vitali.Accounts
  # alias Vitali.Accounts.User
  import VitaliWeb.CoreComponents

  use VitaliWeb, :live_view

  def render(assigns) do
    ~H"""
    <h1 class="text-4xl text-center">Builder</h1>
    <svg width="400" height="400" xmlns="http://www.w3.org/2000/svg">
      <%= for x <- 0..40, y <- 0..40 do %>
        <.life_cell x={x} y={y} live={Enum.random([true, false])}/>
      <% end %>
    </svg>
    """
  end
end
