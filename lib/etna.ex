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
  """

  def sum(enum)

  @doc """

  #### when list
  ```elixir
  iex(9)> Etna.sum([%{age: 20}, %{age: 30}], fn m -> m.age end)
  50
  ```
  """
  def sum(enum, f)

  @doc """

  ```elixir
  #### when list

  iex(4)> Etna.index_by([%{age: 28, name: "pantani"}, %{age: 30, name: "nibali"}], fn rider -> rider.age end)
  %{28 => %{age: 28, name: "pantani"}, 30 => %{age: 30, name: "nibali"}}
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
  """
  def without(enum, list)

  @doc """


  #### when list
  ```elixir
  iex(12)> Etna.pluck([%{name: "pantani", age: 28}, %{name: "nibali", age: 30}], :name)
  ["pantani", "nibali"]
  ````
  """
  def pluck(enum, list)

  @doc """


  #### when list
  ```elixir
  iex(13)> Etna.to([0, 1, 2, 3, 4, 5], 2)
  [0, 1, 2]
  ```
  """
  def to(list, index)

  @doc """


  #### when list
  ```elixir
  iex(14)>  Etna.from([0, 1, 2, 3, 4, 5, 6, 7, 8], 3)
  [4, 5, 6, 7, 8]
  ```
  """
  def from(list, index)

  @doc """


  #### when list
  ```elixir
  iex(15)> Etna.except([], :some_key)
  {:error, Etna.List}
  ```
  """
  def except(map, key)

  @doc """


  #### when list
  ```elixir
  iex(16)> Etna.stringify_keys([])
  {:error, Etna.List}
  ```
  """
  def stringify_keys(map)

  @doc """


  #### when list
  ```elixir
  iex(17)> Etna.symbolize_keys([])
  {:error, Etna.List}
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
  """
  def wrap(val)
end
