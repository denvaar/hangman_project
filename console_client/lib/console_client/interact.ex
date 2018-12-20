defmodule ConsoleClient.Interact do
  alias ConsoleClient.{State, Player}

  @hangman_server :hangloose@localhost

  def start() do
    new_game()
    |> initialize_state()
    |> Player.play()
  end

  defp new_game() do
    Node.connect(@hangman_server)
    :rpc.call(@hangman_server, Hangman, :new_game, [])
  end

  defp initialize_state(game) do
    %State{
      game_service: game,
      tally:        Hangman.tally(game),
    }
  end
end
