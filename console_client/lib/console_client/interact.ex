defmodule ConsoleClient.Interact do
  alias ConsoleClient.{State, Player}

  def start() do
    Hangman.new_game()
    |> initialize_state()
    |> Player.play()
  end

  defp initialize_state(game) do
    %State{
      game_service: game,
      tally:        Hangman.tally(game),
    }
  end
end
