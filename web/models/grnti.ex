defmodule AtvApi.Grnti do
  use AtvApi.Web, :model

  schema "grnti" do
    field :title, :string
    field :has_children, :boolean, default: false

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:id, :title, :has_children])
    |> validate_required([:id, :title, :has_children])
  end
end
