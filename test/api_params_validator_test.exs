defmodule ApiParamsValiatorTest do
  use ExUnit.Case
  doctest ApiParamsValidator

  test "validate valid longitude" do
    assert ApiParamsValidator.validate_longitude(50.0) == true
  end

  test "validate valid longitude low bound" do
    assert ApiParamsValidator.validate_longitude(-180.0) == true
  end

  test "validate valid longitude upper bound" do
    assert ApiParamsValidator.validate_longitude(180.0) == true
  end

  test "validate invalid longitude" do
    assert ApiParamsValidator.validate_longitude(-250.0) == false
  end

  test "validate invalid longitude because int" do
    assert ApiParamsValidator.validate_longitude(50) == false
  end

  test "validate valid latitude" do
    assert ApiParamsValidator.validate_latitude(50.0) == true
  end

  test "validate valid latitude low bound" do
    assert ApiParamsValidator.validate_latitude(-90.0) == true
  end

  test "validate valid latitude upper bound" do
    assert ApiParamsValidator.validate_latitude(90.0) == true
  end

  test "validate invalid latitude" do
    assert ApiParamsValidator.validate_latitude(-250.0) == false
  end

  test "validate invalid latitude because int" do
    assert ApiParamsValidator.validate_latitude(50) == false
  end
end
