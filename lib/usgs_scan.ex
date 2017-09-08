defmodule USGSScan do

  def get_url(start_time, end_time, radius, latitude, longitude) do
    is_valid = validate_params(start_time, end_time, radius, latitude, longitude)
    if is_valid do
      base_url = "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson"
      base_url = base_url <> "&starttime=#{start_time}"
      base_url = base_url <> "&endtime=#{end_time}"
      base_url = base_url <> "&latitude=#{latitude}"
      base_url = base_url <> "&longitude=#{longitude}"
      {:ok, base_url <> "&maxradiuskm=#{radius}"}
    else
      {:error, "Invalid parameters for search"}
    end
  end

  def fetch(start_time, end_time, radius, latitude, longitude) do
    case get_url(start_time, end_time, radius, latitude, longitude) do
      {:ok, url} ->
        response = HTTPotion.get(url)
        Poison.decode(response.body)
      {:error, message} ->
        {:error, message}
    end
  end

  def fetch_earthquakes(start_time, end_time, radius, latitude, longitude) do
    case fetch(start_time, end_time, radius, latitude, longitude) do
      {:ok, data} ->
        {:ok, map_features(data["features"])}
      {:error, msg} ->
        {:error, msg}
      _ ->
        []
    end
  end

  defp map_features(features) do
    Enum.map features, fn feature ->
      properties = feature["properties"]
      coordinates = feature["geometry"]["coordinates"]
      title = properties["title"]
      latitude = Enum.at(coordinates, 0)
      longitude = Enum.at(coordinates, 1)
      time = DateTime.to_string(DateTime.from_unix!(div(properties["time"], 1000)))
      %{title: title, time: time, latitude: latitude, longitude: longitude}
    end
  end

  defp validate_params(start_time, end_time, radius, latitude, longitude) do
    conditions = [
      ApiParamsValidator.validate_date(start_time),
      ApiParamsValidator.validate_date(end_time),
      ApiParamsValidator.validate_latitude(latitude),
      ApiParamsValidator.validate_longitude(longitude),
      ApiParamsValidator.validate_radius(radius)
    ]

    Enum.reduce(conditions, fn a,b -> a && b end)
  end
end
