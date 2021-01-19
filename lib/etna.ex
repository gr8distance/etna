defprotocol Etna do
  @moduledoc """

  Etna is a utility library inspired by RubyGem's ActiveSupport.
  It provides a convenient function protocol often used in Rails.
  """

  @doc """
  #### When list

  ```elixir
  iex(1)> Etna.compact([1, 2, nil, 4, 5])
  [1, 2, 4, 5]
  ```

  #### When map

  ```elixir
  iex(1)> Etna.compact(%{a: 10, b: nil})
  %{a: 10}
  ```

  """
  def compact(enum)

  @doc """

  #### when list

  ```elixir
  iex(2)> Etna.include?([1,2,3], 1)
  true

  iex(3)> Etna.include?([1,2,3], 4)
  false
  ```

  #### when map

  ```elixir
  iex(2)> Etna.include?(%{a: 10}, :a)
  true
  iex(3)> Etna.include?(%{a: 10}, :b)
  false
  ```

  """
  def include?(enum, val)

  @doc """

  #### when list

  ```elixir
  iex(4)> Etna.exclude?([1,2,3], 4)
  true

  iex(5)> Etna.exclude?([1,2,3], 3)
  false
  ```

  #### when map

  ```elixir
  iex(4)> Etna.exclude?(%{a: 10}, :a)
  false
  iex(5)> Etna.exclude?(%{a: 10}, :b)
  true
  ```
  """
  def exclude?(enum, val)

  @doc """

  #### when list
  ```elixir
  iex(9)> Etna.sum([10, 20, 30])
  60
  iex(10)> Etna.sum(["a", "b", "c"])
  "abc"
  iex(11)> Etna.sum([[1,2,3], [4,5,6]])
  21
  ```

  #### when map

  ```elixir
  iex(6)> Etna.sum(%{a: 10, b: 20})
  30
  iex(7)> Etna.sum(%{a: "hello", b: "world"})
  "helloworld"
  iex(8)> Etna.sum(%{a: [1, 2], b: [3, 4]})
  10
  ```
  """

  def sum(enum)

  @doc """

  #### when list
  ```elixir
  iex(9)> Etna.sum([%{age: 20}, %{age: 30}], fn m -> m.age end)
  50
  ```

  #### when map

  ```elixir
  iex(9)> Etna.sum(%{a: 10}, fn -> nil end)
  {:error, Etna.Map}
  ```

  """
  def sum(enum, f)

  @doc """

  #### when list

  ```elixir
  iex(4)> Etna.index_by([%{age: 28, name: "pantani"}, %{age: 30, name: "nibali"}], fn rider -> rider.age end)
  %{28 => %{age: 28, name: "pantani"}, 30 => %{age: 30, name: "nibali"}}
  ```

  #### when map

  ```elixir
  iex(10)> Etna.index_by(%{name: "pantani", age: 20, job: :rider}, fn {k, _} -> k end)
  %{age: {:age, 20}, job: {:job, :rider}, name: {:name, "pantani"}}
  ```

  """
  def index_by(enum, f)

  @doc """

  #### when list
  ```elixir
  iex(5)> Etna.many?([1])
  true

  iex(6)> Etna.many?([])
  false

  iex(7)> Etna.many?([1, 3])
  true
  ```

  #### when map

  ```elixir
  iex(11)> Etna.many?(%{})
  false
  iex(12)> Etna.many?(%{key: 10})
  true
  ```
  """
  def many?(enum)

  @doc """

  #### when list
  ```elixir
  iex(8)> Etna.without([1, 2, 3, 4, 5], 2)
  [1, 3, 4, 5]

  iex(9)> Etna.without([1, 2, 3, 4, 5], [1, 4])
  [2, 3, 5]

  iex(10)> Etna.without(["apple", "orange", "banana"], "banana")
  ["apple", "orange"]

  iex(11)> Etna.without(["apple", "orange", "banana"], ["banana", "orange"])
  ["apple"]
  ```

  #### when map

  ```elixir
  iex(13)> Etna.without(%{name: "pantani", age: 28, job: :rider}, :name)
  %{age: 28, job: :rider}
  ```
  """
  def without(enum, list)

  @doc """

  #### when list

  ```elixir
  iex(12)> Etna.pluck([%{name: "pantani", age: 28}, %{name: "nibali", age: 30}], :name)
  ["pantani", "nibali"]
  ```

  #### when map

  ```elixir
  iex(14)> Etna.pluck(%{key: "value"}, :key)
  {:error, Etna.Map}
  ```
  """
  def pluck(enum, list)

  @doc """

  #### when list

  ```elixir
  iex(13)> Etna.to([0, 1, 2, 3, 4, 5], 2)
  [0, 1, 2]
  ```

  #### when map

  ```elixir
  iex(15)> Etna.to(%{key: "value"}, 2)
  {:error, Etna.Map}
  ```
  """
  def to(list, index)

  @doc """

  #### when list
  ```elixir
  iex(14)>  Etna.from([0, 1, 2, 3, 4, 5, 6, 7, 8], 3)
  [4, 5, 6, 7, 8]
  ```

  #### when map

  ```elixir
  iex(16)> Etna.from(%{key: "value"}, 1)
  {:error, Etna.Map}
  ```
  """
  def from(list, index)

  @doc """

  #### when list
  ```elixir
  iex(15)> Etna.except([], :some_key)
  {:error, Etna.List}
  ```

  #### when map

  ```elixir
  iex(17)>  Etna.except(%{name: "pantani", age: 28, job: :rider}, :name)
  %{age: 28, job: :rider}
  ```
  """
  def except(map, key)

  @doc """

  #### when list
  ```elixir
  iex(16)> Etna.stringify_keys([])
  {:error, Etna.List}
  ```

  #### when map

  ```elixir
  iex(18)> Etna.stringify_keys(%{name: "pantani", age: 28})
  %{"age" => 28, "name" => "pantani"}
  ```
  """
  def stringify_keys(map)

  @doc """

  #### when list
  ```elixir
  iex(17)> Etna.symbolize_keys([])
  {:error, Etna.List}
  ```

  #### when map

  ```elixir
  iex(19)>  Etna.symbolize_keys(%{"name" => "pantani", "age" => 28})
  %{age: 28, name: "pantani"}
  ```
  """
  def symbolize_keys(map)

  @doc """

  #### when list
  ```elixir
  iex(18)>  Etna.blank?([])
  true

  iex(20)> Etna.blank?([1, 2])
  false

  iex(21)>  Etna.blank?([nil])
  false
  ```

  #### when map

  ```elixir
  iex(20)>  Etna.blank?(%{})
  true
  iex(21)>  Etna.blank?(%{key: 10})
  false
  ```
  """
  def blank?(val)

  @doc """

  #### when list
  ```elixir
  iex(22)> Etna.present?([])
  false
  iex(23)> Etna.present?([1, 2])
  true
  ```

  #### when map

  ```elixir
  iex(22)>  Etna.present?(%{})
  false
  iex(23)> Etna.present?(%{key: 10})
  true
  ```
  """
  def present?(val)

  @doc """

  #### when list
  ```elixir
  iex(24)> Etna.wrap([1, 2])
  [1, 2]
  iex(25)> Etna.wrap([])
  []
  ```

  #### when map

  ```elixir
  iex(24)> Etna.wrap(%{})
  [%{}]
  iex(25)>  Etna.wrap(%{name: "pantani", age: 28})
  [%{age: 28, name: "pantani"}]
  ```
  """
  def wrap(val)
end
