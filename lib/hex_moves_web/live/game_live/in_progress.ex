defmodule HexMovesWeb.GameLive.InProgress do
  require Logger
  use HexMovesWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <div class="mx-auto max-w-5xl space-y-4">
        <div class="grid grid-cols-3 gap-4">
          <%= for game <- @games do %>
            <div class="card bg-base-100 card-sm shadow-sm">
              <div class="card-body">
                <h2 class="card-title link link-primary">
                  <.link href={~p"/games/#{game.id}"}>
                    {game.name}
                  </.link>
                </h2>
                <%!-- <p>
                  Some game description or details can go here.
                </p> --%>
                <div class="justify-end card-actions">
                  <.game_button game={game} user={@current_scope.user} />
                </div>
              </div>
            </div>
          <% end %>
        </div>
      </div>
    </Layouts.app>
    """
  end

  def game_button(assigns) do
    user_seat = Enum.find(assigns.game.seats, &(&1.user_id == assigns.user.id))

    if user_seat && user_seat.status == :taken do
      ~H"""
      <button class="btn btn-primary btn-sm">
        <.link href={~p"/games/#{@game.id}"}>
          Play
        </.link>
      </button>
      """
    else
      ~H"""
      <button
        class="btn btn-secondary btn-sm"
        phx-click="join_game"
        phx-value-game-id={@game.id}
      >
        Join
      </button>
      """
    end
  end

  @impl true
  def mount(_params, _session, socket) do
    user = socket.assigns.current_scope.user
    games = HexMoves.Game.Queries.Game.all_for_user(user)

    socket =
      socket
      |> assign(:games, games)

    {:ok, socket}
  end

  @impl true
  def handle_event("join_game", %{"game-id" => game_id}, socket) do
    socket.assigns.games
    |> Enum.find(&(&1.id == String.to_integer(game_id)))
    |> Map.fetch!(:seats)
    |> Enum.find(&(&1.user_id == socket.assigns.current_scope.user.id))
    |> HexMoves.Game.Models.Seat.update_status_changeset(:taken)
    |> HexMoves.Repo.update!()

    games = HexMoves.Game.Queries.Game.all_for_user(socket.assigns.current_scope.user)

    {:noreply, assign(socket, games: games)}
  end
end
