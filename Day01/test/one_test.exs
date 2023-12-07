defmodule OneTest do
  use ExUnit.Case
  doctest One

  test ":one" do
    assert One.solve_one("3kj5lkd1\n1aabb2\n") == 43
  end

  test ":two" do
    assert One.digit_from_row_two("1twolnine") == 19
    assert One.digit_from_row_two("twolnine") == 29
    assert One.digit_from_row_two("gxonefivejnvqbgnrjxv87gnlqqfdm") == 17
    assert One.digit_from_row_two("eightwothree") == 83
    assert One.digit_from_row_two("1six7396484") == 14

    s =
      "two1nine\neightwothree\nabcone2threexyz\nxtwone3four\n4nineeightseven2\nzoneight234\n7pqrstsixteen\n"

    assert One.solve_two(s) == 281
  end
end
