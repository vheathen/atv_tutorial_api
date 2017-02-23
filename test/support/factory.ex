defmodule AtvApi.Factory do
  use ExMachina.Ecto, repo: AtvApi.Repo

  import AtvApi.FactoryFosList, only: [fos_list: 0]
  import AtvApi.FactoryGrntiList, only: [grnti_list: 0]

  def fos_factory do
    %AtvApi.Fos{
      id: "0",
      title: "Some science-technology name",
    }
  end

  def grnti_factory do
    %AtvApi.Grnti{
      id: 0,
      title: "Some grnti chapter name",
      has_children: false,
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

  def get_descendants(:grnti, -1) do
    grnti_list()
    |> Enum.filter(fn(%{id: id}) ->
         rem(id, 10000) == 0
       end)
  end
  def get_descendants(:grnti, parent_id) when rem(parent_id, 10000) == 0 do
    grnti_list()
    |> Enum.filter(fn(%{id: id}) ->
         rem(id, 100) == 0 and
         id > parent_id and
         id < parent_id + 10000
       end)
  end
  def get_descendants(:grnti, parent_id) when rem(parent_id, 100) == 0 do
    grnti_list()
    |> Enum.filter(fn(%{id: id}) ->
         id > parent_id and
         id < parent_id + 100
       end)
  end

  defp get_list(:fos) do
    fos_list()
  end
  defp get_list(:grnti) do
    grnti_list()
  end
  defp get_list(_) do
    []
  end

end
