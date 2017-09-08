defmodule ApiParamsValidator do
  def validate_date(date_str) do
    regex = ~r/\d{4}-\d{2}-\d{2}/
    date_str =~ regex
  end

  def validate_latitude(latitude) do
    validate_float_range(latitude, -90.0, 90.0)
  end

  def validate_longitude(longitude) do
    validate_float_range(longitude, -180.0, 180.0)
  end

  def validate_radius(radius) do 
    # from https://earthquake.usgs.gov/fdsnws/event/1/
    max_radius = 20001.6
    validate_range(radius,0, max_radius)
  end

  defp validate_float_range(val, start_val, end_val) do
    is_float(val) && validate_range(val, start_val, end_val)
  end

  defp validate_range(val, start_val, end_val) do
    val <= end_val && val >= start_val
  end
end
