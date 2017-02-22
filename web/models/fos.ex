defmodule AtvApi.Fos do
  use AtvApi.Web, :model

  @primary_key {:id, :string, autogenerate: false}

  schema "fos" do
    field :title, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:id, :title])
    |> validate_required([:id, :title])
  end
end
