defmodule AnkiMultitran.Note do
  use Ecto.Model

  alias AnkiMultitran.{EpochId, Card}

  @primary_key {:id, EpochId, autogenerate: true}

  schema "notes" do
    field :guid, :string
    field :mid, :integer, default: Application.get_env(:anki_multitran, :model_id)
    field :mod, :integer
    field :usn, :integer, default: -1
    field :tags, :string, default: ""
    field :flds, :string
    field :sfld, :string
    field :csum, :integer
    field :flags, :integer, default: 0
    field :data, :string, default: ""
    has_one :card, Card
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, ~w(flds), ~w())
    |> set_guid
    |> set_mod
    |> set_sfld
    |> set_csum
  end

  defp set_guid(changeset) do
    case get_change(changeset, :guid) do
      nil ->
        guid = 1..10 |> Enum.map(fn _ -> <<:rand.uniform(95) + 32>> end) |> Enum.join
        put_change changeset, :guid, guid
      _ -> changeset
    end
  end

  defp set_mod(changeset) do
    mod = DateTime.utc_now |> DateTime.to_unix
    put_change changeset, :mod, mod
  end

  defp set_sfld(changeset) do
    case get_change(changeset, :flds) do
      flds when is_binary(flds) ->
        [sfld | _] = String.split flds, <<31>>
        put_change changeset, :sfld, sfld
      _ -> changeset
    end
  end

  defp set_csum(changeset) do
    case get_change(changeset, :sfld) do
      sfld when is_binary(sfld) ->
        csum = :crypto.hash(:sha, sfld)
        |> Base.encode16
        |> String.slice(0..7)
        |> String.to_integer(16)
        put_change changeset, :csum, csum
      _ -> changeset
    end
  end
end
