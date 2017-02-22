defmodule AtvApi.Factory do
  use ExMachina.Ecto, repo: AtvApi.Repo

  import AtvApi.FactoryFosList, only: [fos_list: 0]

  def fos_factory do
    %AtvApi.Fos{
      id: "0",
      title: "Some science-technology name",
    }
  end

  def build_all(factory_name, insert? \\ false) do
    get_list(factory_name)
    |> Enum.map(fn(rec) ->
          case insert? do
            true  -> insert(factory_name, rec)
            false -> build(factory_name, rec)
          end
       end)
  end

  def insert_all(factory_name) do
    build_all(factory_name, true)
  end

  defp get_list(:fos) do
    fos_list()
  end
  defp get_list(_) do
    []
  end

end
