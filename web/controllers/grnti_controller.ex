defmodule AtvApi.GrntiController do
  use AtvApi.Web, :controller

  alias AtvApi.Grnti
  import Ecto.Query

  def show(conn, %{"id" => parent_id}) do
    grnti = parent_id
            |> Grnti.descendants()
            |> Repo.all()
    render(conn, "index.json", grnti: grnti)
  end

end
