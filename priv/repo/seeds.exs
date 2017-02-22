# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     AtvApi.Repo.insert!(%AtvApi.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
require Logger
alias AtvApi.Repo
import Ecto.Query

### OECD FOS dictionary ###
alias AtvApi.Fos

unless Repo.one!(from f in Fos, select: count(f.id)) > 0 do

  multi = File.read!("priv/repo/oecd_fos.txt")
          |> String.split("\n")
          |> Enum.reject(fn(row) -> byte_size(row) < 1 end)
          |> Enum.sort
          |> Enum.dedup
          |> Enum.reduce(Ecto.Multi.new, fn(row, multi) ->

                [id, title] = row
                               |> String.trim
                               |> String.split(";")

                changeset = Fos.changeset(%Fos{}, %{id: id, title: title})

                Ecto.Multi.insert(multi, id, changeset)

             end)

  Repo.transaction(multi)

  Logger.info "OECD FOS load complete"

end
### OECD FOS dictionary ###

### Grnti dictionary ###

alias AtvApi.Grnti

unless Repo.one!(from g in Grnti, select: count(g.id)) > 0 do

  multi = File.read!("priv/repo/grnti.txt")
           |> String.split("\n")
           |> Enum.reject(fn(row) -> byte_size(row) < 2 end)
           |> Enum.reduce(%{}, fn(row, acc) ->
  
                {id, parent_id, title} =
                  case <<String.trim(row)::binary>> do
                    <<a::binary-size(2), ".",
                      b::binary-size(2), ".",
                      c::binary-size(2), " ",
                      title::binary>> ->
                                  { String.to_integer("#{a}#{b}#{c}"), String.to_integer("#{a}#{b}00"), title }
  
                    <<a::binary-size(2), ".",
                      b::binary-size(2), " ",
                      title::binary>> ->
                                  { String.to_integer("#{a}#{b}00"), String.to_integer("#{a}0000"), title }
  
                    <<a::binary-size(2), " ",
                      title::binary>> ->
                                  { String.to_integer("#{a}0000"), -1, title }
                  end
  
                parent =
                  case Map.get(acc, parent_id) do
                    nil          -> {"", true}
                    {p_title, _} -> {p_title, true}
                  end
  
                current =
                  case Map.get(acc, id) do
                    nil               -> {title, false}
                    {_, has_children} -> {title, has_children}
                  end
  
                acc
                |> Map.put(id, current)
                |> Map.put(parent_id, parent)
              end)
  
           |> Enum.reduce(Ecto.Multi.new, fn({id, {title, has_children}}, multi) ->
                if id > -1 do
                  changeset = Grnti.changeset(%Grnti{}, %{id: id, title: String.trim(title), has_children: has_children})
                  Ecto.Multi.insert(multi, "#{id}", changeset)
                else
                  multi
                end
              end)

  Repo.transaction(multi)

  Logger.info "GRNTI load complete"
end

### Grnti dictionary ###
