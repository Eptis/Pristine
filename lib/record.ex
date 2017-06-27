defmodule Pristine.Record do
  use GenServer

  # Callbacks
  def handle_call(:pop, _from, [h | t]) do
    {:reply, h, t}
  end

  def init({key, record}) do
    # Register itself
    Registry.register(Pristine.Registry, key, record)
    Process.send_after(self(), :kill, 2000000)

    {:ok, record}
  end

  def handle_info(:kill, state) do
    IO.inspect self()
    IO.inspect "is terminating"
    {:stop, :expired, state}
  end
end
