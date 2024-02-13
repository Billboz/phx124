defmodule Vitali.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      VitaliWeb.Telemetry,
      # Start the Ecto repository
      Vitali.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Vitali.PubSub},
      # Start Finch
      {Finch, name: Vitali.Finch},
      # Start the Endpoint (http/https)
      VitaliWeb.Endpoint
      # Start a worker by calling: Vitali.Worker.start_link(arg)
      # {Vitali.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Vitali.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    VitaliWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
