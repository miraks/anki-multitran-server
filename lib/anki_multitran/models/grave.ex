defmodule AnkiMultitran.Grave do
  use Ecto.Model

  @primary_field false

  schema "graves" do
    field :usn, :integer, default: -1
    field :oid, :integer
    field :type, :integer, default: 1
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, ~w(oid), ~w())
  end
end
