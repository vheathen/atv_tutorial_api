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

### Grnti dictionary ###

alias AtvApi.Grnti

unless Repo.one!(from g in Grnti, select: count(g.id)) > 0 do

  { multi, _ } = File.read!("priv/repo/grnti.txt")
                 |> String.split("\n")
                 |> Enum.reject(fn(row) -> byte_size(row) < 1 end)
                 |> Enum.reduce({Ecto.Multi.new, []}, fn(row, {multi, ids}) ->

                      # Удалим ненужные символы из начала и окончания строки
                      row = String.trim(row)

                      # Распарсим строку с помощью регулярного выражения и получим
                      # id в виде строки от "00" до "99.99.99"
                      [_, id, name] = Regex.run(~r/([\d.]{2,8})\s+(.*)/ui, row)

                      # Уберём точки
                      id = String.replace id, ".", ""

                      # См. описание в тексте
                      int_id = String.to_integer(id) *
                        case id do
                          <<_::16>> -> 10000
                          <<_::32>> -> 100
                                  _ -> 1
                        end

                      # Так как в исходном файле пристутсвуют дубликаты, проверим
                      # и если такой id уже был - выдаём предупреждение и возвращаем
                      # предыдущую версию кортежа-аккумулятора
                      if int_id in ids do
                        Logger.warn "Duplicate: #{row}"
                        { multi, ids }

                      # Если id новый, то добавляем к Ecto.Multi новую операцию, а
                      # к списку id - текущий id.
                      # Напомню, что любая функция в Elixir возвращает результат
                      # последней операции, в нашем случае - кортеж из двух элементов
                      else
                        changeset = Grnti.changeset(%Grnti{}, %{id: int_id, name: name})
                        { Ecto.Multi.insert(multi, id, changeset), ids ++ [int_id] }
                      end

                   end)

  Repo.transaction(multi)

  Logger.info "GRNTI load complete"
end

### Grnti dictionary ###
