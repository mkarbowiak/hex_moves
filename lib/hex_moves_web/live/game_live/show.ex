defmodule HexMovesWeb.GameLive.Show do
  require Logger
  use HexMovesWeb, :live_view

  alias HexMoves.Game.Queries.Game

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    id = String.to_integer(id)

    game = Game.get!(socket.assigns.current_scope.user, id)

    {:ok, assign(socket, :game, game)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <div class="mx-auto max-w-5xl space-y-4">
        <h1>Games In Progress</h1>
        <p>Game name: {@game.name}</p>
      </div>
    </Layouts.app>
    """
  end
end
