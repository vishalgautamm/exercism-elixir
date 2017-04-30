defmodule SecretHandshake do
  use Bitwise
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(handshake), do: do_commands(<<handshake &&& 0b11111::size(5)>>)
  defp do_commands(
    <<reverse::size(1)>> <>
    <<jump::size(1)>> <>
    <<close::size(1)>> <>
    <<double_blink::size(1)>> <>
    <<wink::size(1)>>
  ) do
    shake = [
      {wink, "wink"},
      {double_blink, "double blink"},
      {close, "close your eyes"},
      {jump, "jump"},
    ]
    |> Enum.filter(fn {n, _} -> n == 1 end)
    |> Enum.map(fn {_, i} -> i end)

    cond do
      reverse == 1 -> Enum.reverse(shake)
      true -> shake
    end
  end

end

