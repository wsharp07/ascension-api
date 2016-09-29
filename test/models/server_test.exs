defmodule AscensionApi.ServerTest do
  use AscensionApi.ModelCase

  alias AscensionApi.Server

  @valid_attrs %{ip_address: "10.10.10.10", name: "some content", is_deleted: false}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Server.changeset(%Server{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Server.changeset(%Server{}, @invalid_attrs)
    refute changeset.valid?
  end
end
