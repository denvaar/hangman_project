defmodule ConsoleClient.Summary do
  def display(%{tally: tally} = state) do
    IO.puts([
      "\n",
      "Word so far: #{Enum.join(tally.letters, " ")}\n",
      "Guesses remaining: #{tally.turns_left}\n",
      "Used words: #{Enum.join(tally.used_letters, ", ")}\n\n",
    ])
    state
  end
end
