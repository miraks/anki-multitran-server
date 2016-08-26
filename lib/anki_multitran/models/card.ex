defmodule AnkiMultitran.Card do
  use Ecto.Model

  alias AnkiMultitran.{EpochId, Note}

  @primary_key {:id, EpochId, autogenerate: true}

  schema "cards" do
    field :did, :integer, default: Application.get_env(:anki_multitran, :deck_id)
    field :ord, :integer, default: Application.get_env(:anki_multitran, :template_id)
    field :mod, :integer
    field :usn, :integer, default: -1
    field :type, :integer, default: 0
    field :queue, :integer, default: 0
    field :due, :integer
    field :ivl, :integer, default: 0
    field :factor, :integer, default: 0
    field :reps, :integer, default: 0
    field :lapses, :integer, default: 0
    field :left, :integer, default: 0
    field :odue, :integer, default: 0
    field :odid, :integer, default: 0
    field :flags, :integer, default: 0
    field :data, :string, default: ""
    belongs_to :note, Note, foreign_key: :nid
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, ~w(nid), ~w())
    |> set_mod
    |> set_due
  end

  defp set_mod(changeset) do
    mod = DateTime.utc_now |> DateTime.to_unix
    put_change changeset, :mod, mod
  end

  defp set_due(changeset) do
    case get_change(changeset, :due) do
      nil ->
        due = :rand.uniform(900) + 100
        put_change changeset, :due, due
      _ -> changeset
    end
  end
end
