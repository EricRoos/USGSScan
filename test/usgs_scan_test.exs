defmodule USGSScanTest do
  use ExUnit.Case
  doctest USGSScan

  test "gets correct url" do
    start_time = "2014-01-01"
    end_time = "2017-01-02"
    radius = 50
    latitude = 32.822517
    longitude = -96.776169

    {:ok, url} = USGSScan.get_url(start_time, end_time, radius, latitude, longitude)
    expected = "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=2014-01-01&endtime=2017-01-02&latitude=32.822517&longitude=-96.776169&maxradiuskm=50"
    assert url == expected
  end

  test "fetches data successfully" do
    start_time = "2014-01-01"
    end_time = "2017-01-02"
    radius = 50
    latitude = 32.822517
    longitude = -96.776169

    {status, _} = USGSScan.fetch(start_time, end_time, radius, latitude, longitude)
    assert status == :ok
  end

  test "fetches feature data successfully" do
    start_time = "2014-01-01"
    end_time = "2017-01-02"
    radius = 50
    latitude = 32.822517
    longitude = -96.776169
    USGSScan.fetch_earthquakes(start_time, end_time, radius, latitude, longitude)
  end

  test "fetches data unsuccessfully" do
    start_time = "2014-01-01"
    end_time = "2017-01-02"
    radius = 500000000000
    latitude = 32.822517
    longitude = -96.776169

    {status, _} = USGSScan.fetch(start_time, end_time, radius, latitude, longitude)
    assert status == :error
  end

  test "fetches features unsuccessfully" do
    start_time = "2014-01-01"
    end_time = "2017-01-02"
    radius = 500000000000
    latitude = 32.822517
    longitude = -96.776169

    {status, _ } = USGSScan.fetch_earthquakes(start_time, end_time, radius, latitude, longitude)
    assert status == :error
  end

end
