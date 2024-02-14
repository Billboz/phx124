defmodule VitaliWeb.AdminLive do
  alias Vitali.Accounts
  # alias Vitali.Accounts.User

  use VitaliWeb, :live_view

  def render(assigns) do
    ~H"""
    <h1>Admin</h1>
    total users: <%= @users |> Enum.count() %>
    <table>
      <tr>
        <th>Email</th>
        <th>Roles</th>
        <th>Actions</th>
      </tr>
      <%= for user <- @users do %>
        <tr>
          <td><%= user.email %></td>
          <td><%= user.roles |> Enum.join(", ") %></td>
          <td>
            <button phx-click="grant" phx-value-id={user.id}>Grant</button>
            <button phx-click="revoke" phx-value-id={user.id}>Revoke</button>
          </td>
        </tr>
      <% end %>
    </table>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, users: Accounts.list_users())}
  end

  def handle_event("grant", %{"id" => id}, socket) do
    {id_int, _text} = Integer.parse(id)
    Accounts.grant_admin(id_int)
    {:noreply, assign(socket, users: Accounts.list_users())}
  end

  def handle_event("revoke", %{"id" => id}, socket) do
    {id_int, _text} = Integer.parse(id)
    Accounts.revoke_admin(id_int)
    {:noreply, assign(socket, users: Accounts.list_users())}
  end
end
