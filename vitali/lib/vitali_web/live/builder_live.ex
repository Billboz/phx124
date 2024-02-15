defmodule VitaliWeb.BuilderLive do
  # alias Vitali.Accounts
  # alias Vitali.Accounts.User

  use VitaliWeb, :live_view

  def render(assigns) do
    ~H"""
    <h1 class="text-4xl text-center">Builder</h1>
    <svg width="400" height="200" xmlns="http://www.w3.org/2000/svg">
      <rect width="200" height="100" x="100" y="50" rx="20" ry="20" fill="blue" />
    </svg>
    """
  end
end
