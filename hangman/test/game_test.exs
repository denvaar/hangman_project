defmodule GameTest do
  use ExUnit.Case

  alias Hangman.Game

  test "state isn't changed for :lost or :won game" do
    for state <- [:won, :lost] do
      game = Game.new_game()
      game = Map.put(game, :game_status, state)

      assert {^game, _tally} = Game.make_move(game, "z")
    end
  end

  test "first occurrance of letter is not already used" do
    game = Game.new_game()
    { game, _tally } = Game.make_move(game, "Q")

    assert game.game_status != :already_used
  end

  test "second occurrance of letter is already used" do
    game = Game.new_game()
    { game, _tally } = Game.make_move(game, "Q")

    assert game.game_status != :already_used
    { game, _tally } = Game.make_move(game, "Q")
    assert game.game_status == :already_used
  end

  test "good guess recognized" do
    game = Game.new_game("rabbit")
    { game, _tally } = Game.make_move(game, "b")

    assert game.game_status == :good_guess
    assert game.turns_left == 7
  end

  test "game is won when entire word is guessed" do
    game = Game.new_game("dad")
    { game, _tally } = Game.make_move(game, "d")
    assert game.game_status == :good_guess
    assert game.turns_left == 7
    { game, _tally } = Game.make_move(game, "a")
    assert game.game_status == :won
    assert game.turns_left == 7
  end

  test "bad guess when letter not in word" do
    game = Game.new_game("dad")
    { game, _tally } = Game.make_move(game, "z")

    assert game.game_status == :bad_guess
    assert game.turns_left == 6
  end

  test "game lost when turns left runs out" do
    game = Game.new_game("dad")
    { game, _tally } = Game.make_move(game, "z")
    { game, _tally } = Game.make_move(game, "p")
    { game, _tally } = Game.make_move(game, "j")
    { game, _tally } = Game.make_move(game, "o")
    { game, _tally } = Game.make_move(game, "q")
    { game, _tally } = Game.make_move(game, "t")
    { game, _tally } = Game.make_move(game, "h")

    assert game.game_status == :lost
  end
end
