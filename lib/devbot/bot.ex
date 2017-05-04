defmodule Devbot.Bot do
  use Nostrum.Consumer
  use Timex
  alias Nostrum.Api

  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def handle_event({:READY, _, ws_state}, state) do
    {:ok, Map.put(state, :start_time, Duration.now)}
  end

  def handle_event({:MESSAGE_CREATE, {msg}, ws_state}, state) do
    case msg.content do
      "!ping" ->
        uptime = Duration.diff(Duration.now, state.start_time) |> Duration.to_clock
        Api.create_message(msg.channel_id, "I've been alive for #{elem(uptime, 0)} hours, #{elem(uptime, 1)} minutes, #{elem(uptime, 2)} seconds.")
      _ ->
        :ignore
    end

    {:ok, state}
  end

  def handle_event(event, state) do
    IO.inspect state
    {:ok, state}
  end
end
