defmodule ConsoleClient do
  defdelegate start(), to: ConsoleClient.Interact
end
