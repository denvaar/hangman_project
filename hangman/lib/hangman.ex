defmodule Hangman do
  alias Hangman.Game

  defdelegate new_game(), to: Game
  defdelegate tally(game_state), to: Game

  def make_move(game_state, guess) do
    game_state = Game.make_move(game_state, guess)

    { game_state, Game.tally(game_state) }
  end
end
