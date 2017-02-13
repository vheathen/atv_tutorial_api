defmodule AtvApi.Repo.Migrations.CreateGrnti do
  use Ecto.Migration

  def change do
    create table(:grnti, primary_key: false) do
      add :id, :integer, null: false, primary_key: true
      add :name, :text

      timestamps()
    end

  end
end
