defmodule ConsoleClient.Mover do
  alias ConsoleClient.State

  def make_move(state) do
    tally = Hangman.make_move(state.game_service, state.guess)
    %State{state | tally: tally}
  end
end
