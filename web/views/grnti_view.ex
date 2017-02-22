defmodule AtvApi.GrntiView do
  use AtvApi.Web, :view

  def render("index.json", %{grnti: grnti}) do
    %{data: render_many(grnti, AtvApi.GrntiView, "grnti.json")}
  end

  def render("grnti.json", %{grnti: grnti}) do
    %{id: grnti.id,
      title: grnti.title,
      has_children: grnti.has_children}
  end
end
