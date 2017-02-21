defmodule AtvApi.FactoryFos do
  use ExMachina.Ecto, repo: AtvApi.Repo

  import AtvApi.FactoryFosList, only: [fos_list: 0]

  def fos_factory do
    %AtvApi.Fos{
      id: "0",
      title: "Some science-technology name",
    }
  end

end
