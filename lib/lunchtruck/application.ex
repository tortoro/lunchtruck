defmodule Lunchtruck.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LunchtruckWeb.Telemetry,
      Lunchtruck.Repo,
      {DNSCluster, query: Application.get_env(:lunchtruck, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Lunchtruck.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Lunchtruck.Finch},
      # Start a worker by calling: Lunchtruck.Worker.start_link(arg)
      # {Lunchtruck.Worker, arg},
      # Start to serve requests, typically the last entry
      LunchtruckWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Lunchtruck.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LunchtruckWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
