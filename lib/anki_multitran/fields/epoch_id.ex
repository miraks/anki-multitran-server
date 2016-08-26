defmodule AnkiMultitran.EpochId do
  @behaviour Ecto.Type

  def type do
    :integer
  end

  def cast(integer) when is_integer(integer) do
    {:ok, integer}
  end
  def cast(_) do
    :error
  end

  def load(integer) when is_integer(integer) do
    {:ok, integer}
  end
  def load(_) do
    :error
  end

  def dump(integer) when is_integer(integer) do
    {:ok, integer}
  end
  def dump(_) do
    :error
  end

  def generate do
    DateTime.to_unix(DateTime.utc_now) * 1000
  end

  def autogenerate do
    generate
  end
end
