defmodule SocketClient.EchoClient do
  alias SocketClient.SocketConnection
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def send_message(payload) do
    GenServer.cast(__MODULE__, {:send, payload})
  end

  def init(state) do
    {:ok, pid} = SocketClient.SocketConnection.start_link(state)
    {:ok, %{pid: pid}, {:continue, :join}}
  end

  def handle_continue(:join, %{pid: pid} = state) do
    join_msg =
    %{
      topic: "room:1",
      event: "phx_join",
      payload: %{},
      ref: 1
    }
    |> Jason.encode!()

    SocketConnection.send_message(pid, join_msg)
    {:noreply, state}
  end

  def handle_cast({:send, payload}, %{pid: pid} = state) do
    msg = Jason.encode!(payload)
    SocketConnection.send_message(pid, msg)
    {:noreply, state}
  end
end
