defmodule VitaliWeb.AdminLive do
  alias Vitali.Accounts
  # alias Vitali.Accounts.User

  use VitaliWeb, :live_view

  def render(assigns) do
    ~H"""
    <h1 class="text-4xl text-center">Admin</h1>
    <p class="text-center">total users: <%= @users |> Enum.count() %></p>
    <div style="margin-top: 20px;">
      <table class="mx-auto">
        <tr>
          <th class="px-4 py-2">Email</th>
          <th class="px-4 py-2">Roles</th>
          <th class="px-4 py-2">Actions</th>
        </tr>
        <%= for user <- @users do %>
          <tr class={if rem(Enum.find_index(@users, &(&1 == user)), 2) == 0, do: "bg-gray-100"}>
            <td class="px-4 py-2"><%= user.email %></td>
            <td class="px-4 py-2"><%= user.roles |> Enum.join(", ") %></td>
            <td class="px-4 py-2">
              <button
                phx-click="grant"
                phx-value-id={user.id}
                class="mr-2 bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded"
              >
                Grant
              </button>
              <button
                phx-click="revoke"
                phx-value-id={user.id}
                class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded"
              >
                Revoke
              </button>
            </td>
          </tr>
        <% end %>
      </table>
    </div>
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
