defmodule GameSet do
  defstruct red: 0, green: 0, blue: 0
end

defmodule Two do
  @max_red 12
  @max_green 13
  @max_blue 14

  def run(task) do
    input = File.read!("./lib/two.txt") |> String.split("\n", trim: true)

    games = input |> Enum.map(&parse_game/1)

    case task do
      :one -> solve_one(games)
      :two -> solve_two(games)
    end
  end

  defp solve_one(games) do
    games
    |> Enum.filter(fn {_id, sets} ->
      Enum.all?(sets, fn
        %{red: red, green: green, blue: blue}
        when red <= @max_red and green <= @max_green and blue <= @max_blue ->
          true

        _ ->
          false
      end)
    end)
    |> Enum.map(fn {id, _} -> id end)
    |> Enum.sum()
  end

  defp solve_two(games) do
    games
    |> Enum.map(fn {id, sets} ->
      {id,
       struct!(GameSet, %{
         red: Enum.reduce(sets, 0, fn set, acc -> max(acc, set.red) end),
         green: Enum.reduce(sets, 0, fn set, acc -> max(acc, set.green) end),
         blue: Enum.reduce(sets, 0, fn set, acc -> max(acc, set.blue) end)
       })}
    end)
    |> Enum.map(fn {id, set} -> {id, set.red * set.blue * set.green} end)
    |> Enum.map(fn {_, power} -> power end)
    |> Enum.sum()
  end

  defp parse_game("Game " <> id) do
    {id, sets} = Integer.parse(id)

    {id,
     sets
     |> String.replace(":", "")
     |> String.trim()
     |> String.split(";")
     |> Enum.map(&parse_set/1)
     |> Enum.map(&struct!(GameSet, &1))}
  end

  defp parse_set(set) do
    set
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.map(&parse_tuple/1)
  end

  defp parse_tuple(t) do
    case Integer.parse(t) do
      {num, " green"} ->
        {:green, num}

      {num, " blue"} ->
        {:blue, num}

      {num, " red"} ->
        {:red, num}
    end
  end
end
