defimpl Etna, for: Map do
  def compact(map) do
    map
    |> Enum.reject(fn {_, v} -> v == nil end)
    |> Enum.into(%{})
  end

  def include?(map, key) do
    map
    |> Enum.any?(fn {k, _} -> k == key end)
  end

  def exclude?(map, key), do: !include?(map, key)

  def sum(map) do
    map
    |> Map.values
    |> List.flatten
    |> Etna.sum
  end
  def sum(_map, _), do: {:error, __MODULE__}

  def index_by(map, f) do
    map
    |> Map.to_list
    |> Etna.index_by(f)
  end

  def many?(map) when map_size(map) == 0, do: false
  def many?(_map), do: true

  def without(map, keys) when is_list(keys), do: Map.drop(map, keys)
  def without(map, key), do: Map.delete(map, key)

  def pluck(_map, _list), do: {:error, __MODULE__}

  def to(_map, _index), do: {:error, __MODULE__}
  def from(_map, _index), do: {:error, __MODULE__}

  def except(map, key), do: without(map, key)

  def stringify_keys(map) do
    Map.new(map, fn {key, value} -> {stringify(key), value} end)
  end

  def symbolize_keys(map) do
    Map.new(map, fn {key, value} -> {symbolize(key), value} end)
  end

  def blank?(map) when map_size(map) == 0, do: true
  def blank?(_map), do: false

  def present?(map), do: many?(map)
  def wrap(map), do: [map]

  defp symbolize(key) when is_bitstring(key), do: String.to_atom(key)
  defp symbolize(key), do: key
  defp stringify(key) when is_atom(key), do: Atom.to_string(key)
  defp stringify(key), do: key
end
