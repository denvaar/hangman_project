defmodule ConsoleClient.Prompter do
  alias ConsoleClient.State

  def accept_move(%State{} = state) do
    input = IO.gets("Guess a letter: ")
    validate_input(input, state)
  end

  defp validate_input({:error, reason}, _state) do
    IO.puts("Game ended: #{reason}")
    exit(:normal)
  end

  defp validate_input(:eof, _state) do
    exit(:normal)
  end

  defp validate_input(input, state) do
    input
    |> String.trim()
    |> input_matches?(~r/\A[a-z]\z/)
    |> maybe_accept_input(state)
  end

  defp input_matches?(input, regex) do
    if String.match?(input, regex) do
      {true, input}
    else
      {false, input}
    end
  end

  defp maybe_accept_input({false, _input}, state) do
    IO.puts("Guess must be a single lowercase letter")
    accept_move(state)
  end

  defp maybe_accept_input({_true, input}, state) do
    Map.put(state, :guess, input)
  end
end
