defmodule ElixirFeedParser.Parsers.Helper do
  alias ElixirFeedParser.XmlNode

  def element(node, selector) do
    node |> XmlNode.find(selector) |> XmlNode.text
  end

  def element(node, selector, [attr: attr]) do
    node |> XmlNode.find(selector) |> XmlNode.attr(attr)
  end

  def elements(node, selector) do
    node |> XmlNode.map_children(selector, fn(e) -> XmlNode.text(e) end)
  end

  def elements(node, selector, [attr: attr]) do
    node |> XmlNode.map_children(selector, fn(e) -> XmlNode.attr(e, attr) end)
  end

  def to_date_time(date_time_string), do: to_date_time(date_time_string, "RFC_1123")
  def to_date_time(nil, _), do: nil
  def to_date_time(date_time_string, format) do
    case format do
      "ISO_8601" -> 
        {:ok, date_time, _} = DateTime.from_iso8601(date_time_string |> String.trim)
        date_time
      "RFC_1123" -> 
        {:ok, date_time} = Timex.parse(date_time_string |> String.trim, "{RFC1123}")
        date_time
    end
  end
end
