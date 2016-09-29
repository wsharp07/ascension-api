defmodule AscensionApi.ServiceTest do
  use AscensionApi.ModelCase

  alias AscensionApi.Service

  @valid_attrs %{is_deleted: false, name: "some content", status: :unknown}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Service.changeset(%Service{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Service.changeset(%Service{}, @invalid_attrs)
    refute changeset.valid?
  end
end
