defimpl Etna, for: List do
  require IEx

  def compact(list), do: list |> Enum.reject(& &1 == nil)

  def include?(list, val), do: list |> Enum.any?(& &1 == val)

  def exclude?(list, val), do: !include?(list, val)

  def sum(list, f) do
    list
    |> Enum.map(f)
    |> Enum.sum
  end

  def index_by(list, f) do
    list
    |> Enum.map(fn map -> { f.(map), map} end)
    |> Enum.into(%{})
  end

  def many?([]), do: false
  def many?([_|_]), do: true

  def without(list, val) when is_list(val) do
    list
    |> Enum.reject(fn elm -> include?(val, elm) end)
  end
  def without(list, val), do: list |> Enum.reject(fn elm -> val == elm end)

  def pluck(list, val) when is_list(val) do
    list
    |> Enum.map(fn map ->
      val
      |> Enum.map(fn v ->
        Map.get(map, v)
      end)
    end)
  end
  def pluck(list, val), do: list |> Enum.map(fn map -> Map.get(map, val) end)

  def to(list, index), do: list |> Enum.slice(0, index + 1)
  def from(list, index) do
    l = list |> length
    list |> Enum.slice(index + 1, l - index)
  end

  def wrap(val), do: val

  def blank?([]), do: true
  def blank?(_), do: false

  def present?(list), do: !blank?(list)

  def except(_, _), do: {:error, __MODULE__}
  def stringify_keys(_), do: {:error, __MODULE__}
  def symbolize_keys(_), do: {:error, __MODULE__}
end
