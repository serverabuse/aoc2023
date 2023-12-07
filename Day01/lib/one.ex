defmodule One do
  @digits_map %{
    "1" => 1,
    "2" => 2,
    "3" => 3,
    "4" => 4,
    "5" => 5,
    "6" => 6,
    "7" => 7,
    "8" => 8,
    "9" => 9,
    "one" => 1,
    "two" => 2,
    "three" => 3,
    "four" => 4,
    "five" => 5,
    "six" => 6,
    "seven" => 7,
    "eight" => 8,
    "nine" => 9
  }

  def run(task, path \\ "./lib/one.txt") do
    case task do
      :one -> solve_one(File.read!(path))
      :two -> solve_two(File.read!(path))
      _ -> "unmatched case"
    end
  end

  def solve_one(content) do
    String.split(content, "\n", trim: true)
    |> Enum.map(fn x -> digit_from_row(x) end)
    |> Enum.sum()
  end

  defp digit_from_row(row) do
    str =
      row
      |> String.graphemes()
      |> Enum.filter(fn x -> is_int(x) end)
      |> Enum.join()

    {val, _} = Integer.parse("#{String.at(str, 0)}#{String.at(str, -1)}")
    val
  end

  defp is_int(x) do
    case Integer.parse(x) do
      :error ->
        false

      _ ->
        true
    end
  end

  def solve_two(content) do
    String.split(content, "\n", trim: true)
    |> Enum.map(fn x -> digit_from_row_two(x) end)
    |> Enum.sum()
  end

  def digit_from_row_two(word) do
    digits =
      @digits_map
      |> Enum.map(fn {k, _} ->
        %{val: k, idx: get_indexes(word, k)}
      end)
      |> Enum.filter(&(&1[:idx] != []))

    first =
      digits |> Enum.map(fn v -> %{val: v.val, idx: Enum.min(v.idx)} end) |> Enum.min_by(& &1.idx)

    second =
      digits |> Enum.map(fn v -> %{val: v.val, idx: Enum.max(v.idx)} end) |> Enum.max_by(& &1.idx)

    {val, _} = Integer.parse("#{@digits_map[first.val]}#{@digits_map[second.val]}")
    val
  end

  defp get_indexes(str, substr) do
    :binary.matches(str, substr)
    |> Enum.map(fn {k, _v} -> String.to_integer(to_string(k)) end)
  end
end
