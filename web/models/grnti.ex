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

  def descendants(parent_id) when is_binary(parent_id) do
    parent_id
    |> String.to_integer
    |> descendants
  end
  def descendants(parent_id) when parent_id == -1 do
    from g in AtvApi.Grnti,
    where: fragment("mod(?, ?)", g.id, 10000) == 0
  end
end
