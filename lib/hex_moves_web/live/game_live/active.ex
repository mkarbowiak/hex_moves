defmodule HexMovesWeb.GameLive.Active do
  require Logger
  use HexMovesWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <h1 class="text-4xl font-semibold leading-8">Your games</h1>
      <hr class="my-6" />
      <div class="mx-auto max-w-5xl space-y-4">
        <h1 class="text-2xl font-semibold leading-8">Waiting for players</h1>
        <.link class="link link-primary" href={~p"/games/new"}>New game</.link>
        <div class="grid grid-cols-3 gap-4">
          <%= for game <- @waiting_for_players do %>
            <div class="card bg-base-100 card-sm shadow-sm">
              <div class="card-body">
                <h2 class="card-title">
                  <.link class="link link-primary" href={~p"/games/#{game.id}"}>
                    {game.name}
                  </.link>
                </h2>
                <div class="justify-end card-actions">
                  <.game_button game={game} user={@current_scope.user} />
                </div>
              </div>
            </div>
          <% end %>
        </div>

        <hr class="my-6" />
        <h1 class="text-2xl font-semibold leading-8">In Progress</h1>
        <div class="grid grid-cols-3 gap-4">
          <%= for game <- @in_progress do %>
            <div class="card bg-base-100 card-sm shadow-sm">
              <div class="card-body">
                <h2 class="card-title link link-primary">
                  <.link href={~p"/games/#{game.id}"}>{game.name}</.link>
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

  @impl true
  def mount(_params, _session, socket) do
    user = socket.assigns.current_scope.user
    waiting_for_players = HexMoves.Game.Queries.Game.by_status(user, :waiting_for_players)
    in_progress = HexMoves.Game.Queries.Game.by_status(user, :in_progress)

    socket =
      socket
      |> assign(:waiting_for_players, waiting_for_players)
      |> assign(:in_progress, in_progress)

    {:ok, socket}
  end

  @impl true
  def handle_event("join_game", %{"game-id" => game_id}, socket) do
    socket.assigns.games
    |> Enum.find(&(&1.id == String.to_integer(game_id)))
    |> Map.fetch!(:seats)
    |> Enum.find(&(&1.user_id == socket.assigns.current_scope.user.id))
    |> HexMoves.Game.Models.Seat.update_status_changeset(:joined)
    |> HexMoves.Repo.update!()

    waiting_for_players =
      HexMoves.Game.Queries.Game.by_status(
        socket.assigns.current_scope.user,
        :waiting_for_players
      )

    in_progress =
      HexMoves.Game.Queries.Game.by_status(socket.assigns.current_scope.user, :in_progress)

    socket =
      socket
      |> assign(:waiting_for_players, waiting_for_players)
      |> assign(:in_progress, in_progress)

    {:ok, socket}
  end

  defp game_button(assigns) do
    user_seat = Enum.find(assigns.game.seats, &(&1.user_id == assigns.user.id))

    cond do
      assigns.game.status == :finished ->
        ~H"""
        <button class="btn btn-disabled btn-sm">
          Finished
        </button>
        """

      user_seat.status == :invited ->
        ~H"""
        <button
          class="btn btn-secondary btn-sm"
          phx-click="join_game"
          phx-value-game-id={@game.id}
        >
          Join
        </button>
        """

      user_seat.status == :joined ->
        ~H"""
        <button class="btn btn-primary btn-sm">
          <.link href={~p"/games/#{@game.id}"}>
            Play
          </.link>
        </button>
        """
    end
  end
end
