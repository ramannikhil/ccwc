defmodule CcwcTest do
  use ExUnit.Case, async: false

  test "check the lines" do
    result = CustomCli.main(["-l", "/Users/ramannikhil/desktop/cc/test.txt"])

    assert result == 7145
  end

  test "check the words" do
    result = CustomCli.main(["-w", "/Users/ramannikhil/desktop/cc/test.txt"])

    assert result == 58164
  end

  test "check the characters" do
    result = CustomCli.main(["-c", "/Users/ramannikhil/desktop/cc/test.txt"])

    assert result == 342_190
  end

  test "check the bytes" do
    result = CustomCli.main(["-m", "/Users/ramannikhil/desktop/cc/test.txt"])

    assert result == 339_292
  end

  test "check the result if the command is not given" do
    result = CustomCli.main(["/Users/ramannikhil/desktop/cc/test.txt"])

    assert result == 339_292
  end

  test "throws error if the parmas are invalid" do
    result = CustomCli.main([])
    assert result == {:error, :invalid_params}
  end
end
