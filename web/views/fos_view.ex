defmodule AtvApi.FosView do
  use AtvApi.Web, :view

  def render("index.json", %{fos: fos}) do
    %{data: render_many(fos, AtvApi.FosView, "fos.json")}
  end

  def render("show.json", %{fos: fos}) do
    %{data: render_one(fos, AtvApi.FosView, "fos.json")}
  end

  def render("fos.json", %{fos: fos}) do
    %{id: fos.id,
      title: fos.title}
  end
end
