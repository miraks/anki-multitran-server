defmodule AnkiMultitran.Action do
  import Plug.Conn
  import Ecto.Query

  alias AnkiMultitran.{Repo, Note, Card}

  def check(conn, word) do
    word = word |> URI.decode_www_form |> String.downcase
    query = from n in Note, where: fragment("lower(?)", n.sfld) == ^word, limit: 1
    note = Repo.one query
    json = Poison.encode! %{present: !!note}
    send_resp conn, 200, json
  end

  def add(conn) do
    %{"front" => front, "back" => back, "sentence" => sentence} = conn.params

    flds = Enum.join [front, sentence, back], <<31>>
    note = Note.changeset(%Note{}, %{flds: flds}) |> Repo.insert!
    Card.changeset(%Card{}, %{nid: note.id}) |> Repo.insert!

    json = Poison.encode! %{success: true}
    send_resp conn, 200, json
  end
end
