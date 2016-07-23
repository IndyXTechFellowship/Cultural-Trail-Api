defmodule CulturalTrailApi.UserTest do
  use CulturalTrailApi.ModelCase

  alias CulturalTrailApi.User

  @valid_attrs %{email: "some content", password: "somePassword"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
