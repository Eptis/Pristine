defmodule Pristine do
  @moduledoc """
  Documentation for Pristine.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Pristine.hello
      :world

  """
  def store(key, record) do
    # Register itself
    {:ok, _pid} = GenServer.start(Pristine.Record, {key, record})
  end

  def fetch(key) do
    # Register itself
    [{_pid, state}] = Registry.lookup(Pristine.Registry, key)
    state
  end

  def remove(key) do
    [{pid, _state}] = Registry.lookup(Pristine.Registry, key)
    send(pid, :kill)
  end

end
