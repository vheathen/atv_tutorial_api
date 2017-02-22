defmodule AtvApi.FosControllerTest do
  use AtvApi.ConnCase

  import AtvApi.Factory
  import AtvApi.FactoryFosList, only: [fos_list: 0]

  setup %{conn: conn} do

    insert_all(:fos)

    fos = fos_list()
          |> Enum.sort
          |> Poison.encode!
          |> Poison.decode!

    {:ok, conn: put_req_header(conn, "accept", "application/json"), fos: fos}
  end

  test "lists all entries on index", %{conn: conn, fos: fos} do
    conn = get conn, fos_path(conn, :index)
    assert json_response(conn, 200)["data"] == fos
  end

end
