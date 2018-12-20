defmodule Hangman.Game do

  defstruct(
    turns_left:   7,
    game_status:  :init,
    letters:      [],
    used:         MapSet.new()
  )

  def new_game() do
    Dictionary.random_word()
    |> new_game()
  end

  def new_game(word) do
    %Hangman.Game{
      letters: String.codepoints(word)
    }
  end

  def make_move(%{game_status: status} = game_state, _guess) when status in [:won, :lost] do
    return_with_tally(game_state)
  end

  def make_move(game_state, guess) do
    game_state
    |> accept_move(guess, MapSet.member?(game_state.used, guess))
    |> return_with_tally()
  end

  def tally(game_state) do
    %{ game_status:  game_state.game_status,
       turns_left:   game_state.turns_left,
       used_letters: MapSet.to_list(game_state.used),
       letters:      reveal_guessed(game_state.letters, game_state.used) }
  end

  defp return_with_tally(game_state), do: { game_state, tally(game_state) }

  defp accept_move(game_state, _guess, _already_guessed = true) do
    Map.put(game_state, :game_status, :already_used)
  end

  defp accept_move(game_state, guess, _already_guessed) do
    game_state = Map.put(game_state, :used, MapSet.put(game_state.used, guess))

    good_move = Enum.member?(game_state.letters, guess)
    score_guess(game_state, good_move)
  end

  defp score_guess(game_state, _good_guess = true) do
    new_status = MapSet.new(game_state.letters)
      |> MapSet.subset?(game_state.used)
      |> maybe_won()

    Map.put(game_state, :game_status, new_status)
  end

  defp score_guess(%{turns_left: 1} = game_state, _good_guess) do
    Map.put(game_state, :game_status, :lost)
  end

  defp score_guess(%{turns_left: turns_left} = game_state, _good_guess) do
    %{game_state | game_status: :bad_guess,
      turns_left: turns_left - 1}
  end

  defp reveal_guessed(letters, guessed) do
    letters
    |> Enum.map(fn (letter) -> reveal_letter(letter, MapSet.member?(guessed, letter)) end)
  end

  defp reveal_letter(letter, _in_word = true), do: letter
  defp reveal_letter(_letter, _in_word), do: "_"

  defp maybe_won(true), do: :won
  defp maybe_won(_status), do: :good_guess
end
