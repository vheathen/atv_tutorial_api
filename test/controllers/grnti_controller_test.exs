defmodule AtvApi.GrntiControllerTest do
  use AtvApi.ConnCase

  import AtvApi.Factory

  setup %{conn: conn} do
    insert_all(:grnti)
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "shows chosen root level subtree", %{conn: conn} do
    id = -1

    grnti_subtree = get_descendants(:grnti, id)

    conn = get conn, grnti_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == grnti_subtree |> Poison.encode! |> Poison.decode!
  end

end