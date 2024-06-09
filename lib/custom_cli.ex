defmodule CustomCli do
  require Logger

  def main(args) do
    {get_command, file_path} =
      case Enum.count(args) do
        2 -> {List.first(args), List.last(args)}
        1 -> {nil, List.first(args)}
        _ -> {nil, nil}
      end

    with true <- !is_nil(file_path) do
      case get_command do
        "-w" ->
          get_word_count(file_path)

        "-c" ->
          get_binary_count(file_path)

        "-l" ->
          get_lines_count(file_path)

        "-m" ->
          get_characters_count(file_path)

        nil ->
          get_all_items(file_path)
      end
    else
      false ->
        Logger.error("Invalid params")
        {:error, :invalid_params}
    end
  end

  defp get_binary_count(file_path) do
    {:ok, stats} = File.stat(file_path)

    Map.get(stats, :size)
    |> IO.inspect(label: "Binary count")
  end

  defp get_word_count(file_path) do
    {:ok, file} = File.read(file_path)

    file
    |> String.split(~r/\s+/)
    |> Enum.filter(fn x -> String.length(x) != 0 end)
    |> Enum.count()
    |> IO.inspect(label: "Words count")
  end

  defp get_lines_count(file_path) do
    file_path
    |> File.stream!()
    |> Enum.count()
    |> IO.inspect(label: "Lines count")
  end

  defp get_characters_count(file_path) do
    {:ok, file} = File.read(file_path)

    file
    |> String.codepoints()
    |> Enum.count()
    |> IO.inspect(label: "Characters count")
  end

  defp get_all_items(file_path) do
    get_lines_count(file_path)
    get_binary_count(file_path)
    get_word_count(file_path)
    get_characters_count(file_path)
  end
end
