defmodule DemoWeb.UserLive.IndexAutoScroll do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <form phx-change="filter">
      <input
        type="text"
        placeholder="Filter..."
        name="filter"
      >
    </form>
    <table>
      <tbody id="users"
             phx-update="replace"
             phx-hook="InfiniteScroll"
             data-page="<%= @page %>">
        <%= for user <- @users do %>
          <tr class="user-row" id="user-<%= user.id %>">
            <td><%= user.username %></td>
            <td><%= user.email %></td>
          </tr>
        <% end %>
      </tbody>
    </table>
    """
  end

  def mount(_session, socket) do
    {:ok,
     socket
     |> assign(page: 1, per_page: 10)
     |> fetch(), temporary_assigns: [users: []]}
  end

  defp fetch(%{assigns: %{page: page, per_page: per}} = socket) do
    assign(socket, users: Demo.Accounts.list_users(page, per))
  end

  def handle_event("load-more", _, %{assigns: assigns} = socket) do
    {:noreply, socket |> assign(page: assigns.page + 1) |> fetch()}
  end

  defp filter(%{assigns: %{per_page: per, filter: filter}} = socket) do
    assign(socket, users: users = Demo.Accounts.list_users(1, per, filter))

  end

  def handle_event("filter", %{"filter" => value}, %{assigns: assigns} = socket) do
    {:noreply, socket |> assign(page: 1, filter: value) |> filter()}
  end
end
