defmodule HexMovesWeb.GameLive.Show do
  require Logger
  use HexMovesWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <div class="mx-auto max-w-5xl space-y-4">
        <h1>Games In Progress</h1>
      </div>
    </Layouts.app>
    """
  end
end
