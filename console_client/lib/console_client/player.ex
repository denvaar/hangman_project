defmodule ConsoleClient.Player do
  alias ConsoleClient.{Mover, State, Summary, Prompter}

  def play(%State{game_service: game_service, tally: %{game_status: :won}}) do
    IO.puts("#{Enum.join(game_service.letters)}")
    exit_with_message("You win!")
  end

  def play(%State{tally: %{game_status: :lost}}) do
    exit_with_message("You lost...")
  end

  def play(%State{tally: %{game_status: :already_used}} = state) do
    continue_with_message(state, "You've already tried that letter.")
  end

  def play(%State{tally: %{game_status: :good_guess}} = state) do
    continue_with_message(state, "You got one!")
  end

  def play(%State{tally: %{game_status: :bad_guess}} = state) do
    continue_with_message(state, "That's not in the word...")
  end

  def play(state), do: continue(state)

  def continue(state) do
    state
    |> Summary.display()
    |> Prompter.accept_move()
    |> Mover.make_move()
    |> play()
  end

  defp exit_with_message(msg) do
    IO.puts(msg)
    exit(:normal)
  end

  defp continue_with_message(state, msg) do
    IO.puts(msg)
    continue(state)
  end
end
