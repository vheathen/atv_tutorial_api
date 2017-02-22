defmodule AtvApi.Repo.Migrations.CreateGrnti do
  use Ecto.Migration

  def change do
    create table(:grnti, primary_key: false) do
      add :id, :integer, null: false, primary_key: true
      add :title, :text
      add :has_children, :boolean, default: false, null: false

      timestamps()
    end

  end
end
