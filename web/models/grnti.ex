defmodule AtvApi.Grnti do
  use AtvApi.Web, :model

  schema "grnti" do
    field :name, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:id, :name])
    |> validate_required([:id, :name])
  end
end
