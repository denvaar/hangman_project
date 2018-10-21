defmodule HangmanTest do
  use ExUnit.Case
  doctest Hangman

  test "new_game returns initial state of game" do
    assert %Hangman.Game{turns_left: 7, game_status: :init, letters: _list} = Hangman.new_game()
  end
end
