defmodule AtvApi.Router do
  use AtvApi.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", AtvApi do
    pipe_through :api

    get "/fos", FosController, :index
  end
end
