defmodule HexMovesWeb.GameLive.InProgress do
  use HexMovesWeb, :live_view

  on_mount {HexMovesWeb.UserAuth, :require_sudo_mode}

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <div class="mx-auto max-w-5xl space-y-4">
        <div class="grid grid-cols-3 gap-4">
          <div class="card bg-base-100 card-sm shadow-sm">
            <div class="card-body">
              <h2 class="card-title">Xsmall Card</h2>
              <p>
                A card component has a figure, a body part, and inside body there are title and actions parts
              </p>
              <div class="justify-end card-actions">
                <button class="btn btn-primary">Buy Now</button>
              </div>
            </div>
          </div>

          <div class="card bg-base-100 card-sm shadow-sm">
            <div class="card-body">
              <h2 class="card-title">Small Card</h2>
              <p>
                A card component has a figure, a body part, and inside body there are title and actions parts
              </p>
              <div class="justify-end card-actions">
                <button class="btn btn-primary">Buy Now</button>
              </div>
            </div>
          </div>

          <div class="card bg-base-100 card-sm shadow-sm">
            <div class="card-body">
              <h2 class="card-title">Small Card</h2>
              <p>
                A card component has a figure, a body part, and inside body there are title and actions parts
              </p>
              <div class="justify-end card-actions">
                <button class="btn btn-primary">Buy Now</button>
              </div>
            </div>
          </div>

          <div class="card bg-base-100 card-sm shadow-sm">
            <div class="card-body">
              <h2 class="card-title">Small Card</h2>
              <p>
                A card component has a figure, a body part, and inside body there are title and actions parts
              </p>
              <div class="justify-end card-actions">
                <button class="btn btn-primary">Buy Now</button>
              </div>
            </div>
          </div>

          <div class="card bg-base-100 card-sm shadow-sm">
            <div class="card-body">
              <h2 class="card-title">Small Card</h2>
              <p>
                A card component has a figure, a body part, and inside body there are title and actions parts
              </p>
              <div class="justify-end card-actions">
                <button class="btn btn-primary">Buy Now</button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </Layouts.app>
    """
  end
end
