defmodule AtvApi.GrntiController do
  use AtvApi.Web, :controller

  alias AtvApi.Grnti

  def show(conn, %{"id" => parent_id}) do
    case Integer.parse(parent_id) do
      :error   -> show(conn, :error)
      {int, _} -> show(conn, int)
    end
  end

  def show(conn, parent_id)
      when is_integer(parent_id)
           and parent_id > -2
           and parent_id < 1000000
           and (
               rem(parent_id, 100) == 0 or parent_id == -1
               )
  do
    grnti = parent_id
            |> Grnti.descendants()
            |> Repo.all()
    render(conn, "index.json", grnti: grnti)
  end

  def show(conn, _parent_id) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(422, ~S({"error":{"message":"Unprocessable Entity"}}))
  end

end
