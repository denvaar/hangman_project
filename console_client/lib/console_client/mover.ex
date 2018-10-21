defmodule ConsoleClient.Mover do
  alias ConsoleClient.State

  def make_move(state) do
    {game_service, tally} = Hangman.make_move(state.game_service, state.guess)
    %State{state | game_service: game_service, tally: tally}
  end
end
