defmodule AnkiMultitran.Router do
  use Plug.Router

  alias AnkiMultitran.Action

  if Mix.env == :dev do
    use Plug.Debugger
  end

  plug Plug.Logger
  plug Plug.Parsers, parsers: [:json], pass: ["*/*"], json_decoder: Poison
  plug :match
  plug :dispatch

  get "/check/:word" do
    Action.check conn, word
  end

  post "/add" do
    Action.add conn
  end

  match _ do
    send_resp conn, 404, "404"
  end
end
