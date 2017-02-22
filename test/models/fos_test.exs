defmodule AtvApi.FosTest do
  use AtvApi.ModelCase

  alias AtvApi.Fos

  @valid_attrs %{title: "Humanities, multidisciplinary", id: "0605BQ"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Fos.changeset(%Fos{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Fos.changeset(%Fos{}, @invalid_attrs)
    refute changeset.valid?
  end
end
