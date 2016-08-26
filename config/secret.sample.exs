use Mix.Config

config :anki_multitran,
  port: 3000,
  deck_id: 1,
  template_id: 0,
  model_id: 1000000000000

config :anki_multitran, AnkiMultitran.Repo,
  adapter: Sqlite.Ecto,
  database: Path.expand("~/path/to/anki/collection.anki2")
