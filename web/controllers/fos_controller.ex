defmodule AtvApi.FosController do
  use AtvApi.Web, :controller

  alias AtvApi.Fos
  import Ecto.Query

  def index(conn, _params) do
    fos = Repo.all(from f in Fos, order_by: f.id)
    render(conn, "index.json", fos: fos)
  end

end
