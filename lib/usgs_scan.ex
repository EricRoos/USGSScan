defmodule USGSScan do
  @moduledoc """
  Documentation for USGSScan.
  """

  @doc """
  Hello world.

  ## Examples

      iex> USGSScan.hello
      :world

  """
  def hello do
    :world
  end

  def get_url(start_time, end_time, radius, latitude, longitude) do
    base_url = "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson"
    base_url = base_url <> "&starttime=#{start_time}"
    base_url = base_url <> "&endtime=#{end_time}"
    base_url = base_url <> "&latitude=#{latitude}"
    base_url = base_url <> "&longitude=#{longitude}"
    base_url <> "&maxradiuskm=#{radius}"
  end

  def fetch(start_time, end_time, radius, latitude, longitude) do
    url = get_url(start_time, end_time, radius, latitude, longitude)
    response = HTTPotion.get(url)
    Poison.decode(response.body)
  end

  def fetch_features(start_time, end_time, radius, latitude, longitude) do
    case fetch(start_time, end_time, radius, latitude, longitude) do
      {:ok, data} ->
        map_features(data["features"])
      _ ->
        []
    end
  end

  defp map_features(features) do
    Enum.map features, fn feature ->
      properties = feature["properties"]
      title = properties["title"]
      time = DateTime.to_string(DateTime.from_unix!(div(properties["time"], 1000)))
      %{title: title, time: time}
    end
  end
end
