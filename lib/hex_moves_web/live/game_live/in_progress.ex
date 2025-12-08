defmodule HexMovesWeb.GameLive.InProgress do
  use HexMovesWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <div class="mx-auto max-w-5xl space-y-4">
        <div class="grid grid-cols-3 gap-4">
          <%= for game <- @games_in_progress do %>
            <div class="card bg-base-100 card-sm shadow-sm">
              <div class="card-body">
                <h2 class="card-title">{game.name}</h2>
                <p>
                  Some game description or details can go here.
                </p>
                <div class="justify-end card-actions">
                  <%= if Enum.any?(game.seats, &(&1.user_id == @current_scope.user.id)) do %>
                    <button class="btn btn-primary btn-sm">Play</button>
                  <% else %>
                    <button class="btn btn-secondary btn-sm">Join</button>
                  <% end %>
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
    games_in_progress = HexMoves.Game.Queries.Game.in_progress(user)

    socket =
      socket
      |> assign(:games_in_progress, games_in_progress)

    {:ok, socket}
  end
end
