defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> String.graphemes
    |> Enum.map(&(rotate_char(&1, shift)))
    |> Enum.join
  end

  defp rotate_char(<< c >>, shift) when c in ?A..?Z do
    << rem((c - ?A + shift), 26) + ?A >>
  end
  defp rotate_char(<< c >>, shift) when c in ?a..?z do
    << rem((c - ?a + shift), 26) + ?a >>
  end
  defp rotate_char(char, _), do: char
end

