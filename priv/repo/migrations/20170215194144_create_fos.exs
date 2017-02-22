defmodule AtvApi.Repo.Migrations.CreateFos do
  use Ecto.Migration

  def change do
    create table(:fos, primary_key: false) do
      add :id, :string, null: false, primary_key: true
      add :title, :text

      timestamps()
    end

  end
end
