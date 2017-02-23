defmodule AtvApi.GrntiControllerTest do
  use AtvApi.ConnCase

  import AtvApi.Factory

  setup %{conn: conn, id: id} do
    insert_all(:grnti)

    conn = conn
           |> put_req_header("accept", "application/json")
           |> get(grnti_path(conn, :show, id))

    {:ok, conn: conn}
  end

  describe "Controller must return descendants of" do

    setup %{id: id} do
      descendants = :grnti
                     |> get_descendants(id)
                     |> Poison.encode!
                     |> Poison.decode!
  
      {:ok, descendants: descendants}
    end
  
    @tag id: -1
    test "the root level", %{conn: conn, descendants: descendants} do
      assert json_response(conn, 200)["data"] == descendants
    end
  
    @tag id: 000000
    test "the chapter with id: 000000", %{conn: conn, descendants: descendants} do
      assert json_response(conn, 200)["data"] == descendants
    end
  
    @tag id: 020000
    test "the chapter with id: 020000", %{conn: conn, descendants: descendants} do
      assert json_response(conn, 200)["data"] == descendants
    end
  
    @tag id: 030000
    test "the chapter with id: 030000", %{conn: conn, descendants: descendants} do
      assert json_response(conn, 200)["data"] == descendants
    end
  
    @tag id: 000900
    test "the chapter with id: 000900", %{conn: conn, descendants: descendants} do
      assert json_response(conn, 200)["data"] == descendants
    end
  
    @tag id: 021500
    test "the chapter with id: 021500", %{conn: conn, descendants: descendants} do
      assert json_response(conn, 200)["data"] == descendants
    end
  
    @tag id: 032300
    test "the chapter with id: 032300", %{conn: conn, descendants: descendants} do
      assert json_response(conn, 200)["data"] == descendants
    end
  end

  describe "Request must be declined with status code 422 and appropriate JSON error message in case of" do
  
    setup do
      
      {:ok, result: %{"message" => "Unprocessable Entity"}}
    end
  
    @tag id: "somestring"
    test "id as a non-digit symbol string", %{conn: conn, result: result} do
      assert json_response(conn, 422)["error"] == result
    end

    @tag id: -2
    test "id is less than -1 and equal -2", %{conn: conn, result: result} do
      assert json_response(conn, 422)["error"] == result
    end

    @tag id: -100
    test "id is less than -1 and equal -100", %{conn: conn, result: result} do
        assert json_response(conn, 422)["error"] == result
      end

    @tag id: 1000000
    test "id is greater than 999999 and equal 1000000", %{conn: conn, result: result} do
                  assert json_response(conn, 422)["error"] == result
                end

    @tag id: 90000000
    test "id is greater than 999999 and equal 90000000", %{conn: conn, result: result} do
      assert json_response(conn, 422)["error"] == result
    end


    @tag id: 030955
    test "id is a third level section code and equal 030955", %{conn: conn, result: result} do
      assert json_response(conn, 422)["error"] == result
    end

    @tag id: 020129
    test "id is a third level section code and equal 020129", %{conn: conn, result: result} do
      assert json_response(conn, 422)["error"] == result
    end
  end

end