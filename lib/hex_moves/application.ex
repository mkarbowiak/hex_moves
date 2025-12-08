defmodule HexMoves.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      HexMovesWeb.Telemetry,
      HexMoves.Repo,
      {DNSCluster, query: Application.get_env(:hex_moves, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: HexMoves.PubSub},
      # Start a worker by calling: HexMoves.Worker.start_link(arg)
      # {HexMoves.Worker, arg},
      # Start to serve requests, typically the last entry
      HexMovesWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HexMoves.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HexMovesWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
