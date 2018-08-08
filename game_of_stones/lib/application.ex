defmodule GameOfStones.Application do
  use Application

  def start(_type, _args) do
    # processes to supervise

    children = [
      GameOfStones.Storage,
      GameOfStones.Server
    ]

    opts = [ strategy: :one_for_one, name: GameOfStones.Supervisor ]

    Supervisor.start_link children, opts
  end
end
