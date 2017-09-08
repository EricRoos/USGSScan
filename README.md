# USGSScan

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `usgs_scan` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:usgs_scan, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/usgs_scan](https://hexdocs.pm/usgs_scan).

Example

```
iex(1)> start_time = "2014-01-01"
"2014-01-01"
iex(2)>end_time = "2017-01-02"
"2017-01-02"
iex(3)> radius = 50
50
iex(4)>latitude = 32.822517
32.822517
iex(5)>longitude = -96.776169
-96.776169
iex(6)> USGSScan.fetch_features(start_time, end_time, radius, latitude, longitude)
[%{time: "2016-09-22 12:37:00Z", title: "M 2.4 - 5km NE of Irving, Texas"},
 %{time: "2016-01-31 06:06:21Z", title: "M 2.1 - 2km W of Irving, Texas"},
 %{time: "2015-12-17 04:24:08Z", title: "M 2.1 - 4km NNW of Irving, Texas"},
 %{time: "2015-12-07 00:27:24Z", title: "M 2.8 - 2km E of Irving, Texas"},
 %{time: "2015-12-06 00:44:08Z", title: "M 2.1 - 6km SSW of Farmers Branch, Texas"},
 %{time: "2015-12-04 14:22:58Z", title: "M 2.1 - 6km NNE of Irving, Texas"}]
```
