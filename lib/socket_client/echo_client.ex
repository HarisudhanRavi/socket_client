defmodule SocketClient.EchoClient do
  use WebSockex
  @url "ws://localhost:4000/socket/websocket"

  def start_link(state) do
    WebSockex.start_link(@url, __MODULE__, state)
  end

  def handle_frame({type, msg}, state) do
    IO.puts "Received Message - Type: #{inspect type} -- Message: #{inspect msg}"
    {:ok, state}
  end

  def handle_cast({:send, {type, msg} = frame}, state) do
    IO.puts "Sending #{type} frame with payload: #{msg}"
    {:reply, frame, state}
  end

  def send_message(client, msg) do
    WebSockex.send_frame(client, msg)
  end
end
