defmodule Devbot do
  use Application

  def start(_type, _args) do
    Devbot.BotSuperVisor.start_link()
  end
end
