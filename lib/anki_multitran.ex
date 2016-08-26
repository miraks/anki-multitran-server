defmodule AnkiMultitran do
  use Application

  alias AnkiMultitran.Router

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      Plug.Adapters.Cowboy.child_spec(:http, Router, [], port: Application.get_env(:anki_multitran, :port)),
      supervisor(AnkiMultitran.Repo, [])
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
