defmodule AtvApi.GrntiTest do
  use AtvApi.ModelCase

  alias AtvApi.Grnti

  @valid_attrs %{title: "some content", has_children: true, id: 100001}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Grnti.changeset(%Grnti{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Grnti.changeset(%Grnti{}, @invalid_attrs)
    refute changeset.valid?
  end
end
