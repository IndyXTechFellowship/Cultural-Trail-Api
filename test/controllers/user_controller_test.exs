defmodule CulturalTrailApi.UserControllerTest do
  use CulturalTrailApi.ConnCase

  alias CulturalTrailApi.User

  @valid_attrs %{email: "someone@example.com", password: "validPassword", name: "username"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "Create an Account", %{conn: conn} do
    conn = post conn, registration_path(conn, :create), user: @valid_attrs
    conn |> doc
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(User, email: @valid_attrs.email)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, registration_path(conn, :create), user: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "Users should have unique emails", %{conn: conn} do
    post conn, registration_path(conn, :create), user: @valid_attrs
    conn = post conn, registration_path(conn, :create), user: @valid_attrs
    errors = json_response(conn, 422)["errors"]
    assert errors != %{}
    assert Map.has_key?(errors, "email")
    assert Map.get(errors, "email") == ["has already been taken"]
  end
end
