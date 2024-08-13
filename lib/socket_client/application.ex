defmodule SocketClient.Application do
  use Application

  def start(_type, _args) do
    children = [
      # {SocketClient.EchoClient, ["WebSockex is Great"]}
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
