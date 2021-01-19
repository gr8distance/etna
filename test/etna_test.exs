defmodule EtnaTest do
  use ExUnit.Case

  doctest Etna

  describe "List" do
    test "compact return list without nil" do
      assert Etna.compact([1, nil, 3]) == [1, 3]
    end

    test "include? return true when value includes in lists" do
      assert Etna.include?([1, 2, 3], 2) == true
      assert Etna.include?([1, 2, 3], 4) == false
    end

    test "exclude? return true when value excludes in lists" do
      assert Etna.exclude?([1, 2, 3], 4) == true
      assert Etna.exclude?([1, 2, 3], 2) == false
    end

    test "sum/1 return sum of lists" do
      assert Etna.sum([1, 2, 3]) == 6
      assert Etna.sum(["hello", "world", "!!"]) == "helloworld!!"
      assert Etna.sum([[1,2,3], [4,5,6]]) == 21
      assert Etna.sum([{1, 2, 3}]) == {:error, "invalid types"}
    end

    test "sum/2 returns the sum of lists using functions" do
      args = [%{age: 25}, %{age: 30}]
      assert Etna.sum(args, fn a -> a.age end) == 55
    end

    test "index_by returns a Map with the specified value as the key" do
      pantani = %{name: "pantani", age: 28}
      nibali = %{name: "nibali", age: 30}
      assert Etna.index_by([pantani, nibali], fn rider -> rider.age end) == %{28 => pantani, 30 => nibali}
    end

    test "many? return true when list size > 0" do
      assert Etna.many?([1]) == true
      assert Etna.many?([1, 3]) == true
      assert Etna.many?([1, 3, 4]) == true
      assert Etna.many?([]) == false
    end

    test "without returns a list excluding the values ​​of the arguments" do
      assert Etna.without([1, 2, 3, 4, 5], 2) == [1, 3, 4, 5]
      assert Etna.without([1, 2, 3, 4, 5], [1, 4]) == [2, 3, 5]
      assert Etna.without(["apple", "orange", "banana"], "banana") == ["apple", "orange"]
      assert Etna.without(["apple", "orange", "banana"], ["banana", "orange"]) == ["apple"]
    end

    test "pluck returns list based on the specified key" do
      list = [%{name: "pantani", age: 28}, %{name: "nibali", age: 30}]
      assert Etna.pluck(list, :name) == ["pantani", "nibali"]
      assert Etna.pluck(list, [:name, :age]) == [["pantani", 28], ["nibali", 30]]
    end

    test "to returns the range from the beginning of the array to where the passed index points." do
      assert Etna.to([0, 1, 2, 3, 4, 5], 2) == [0, 1, 2]
    end

    test "from returns the elements of the array from where the index points to the end" do
      assert Etna.from([0, 1, 2, 3, 4, 5, 6, 7, 8], 3) == [4, 5, 6, 7, 8]
    end

    test "wrap returns the list as is" do
      assert Etna.wrap([1, 2]) == [1, 2]
      assert Etna.wrap([]) == []
    end

    test "blank? returns true when list empty" do
      assert Etna.blank?([]) == true
      assert Etna.blank?([1, 2]) == false
      assert Etna.blank?([nil]) == false
    end

    test "present? return true when list not empty" do
      assert Etna.present?([]) == false
      assert Etna.present?([1, 2]) == true
      assert Etna.present?([nil]) == true
    end

    test "except returns error" do
      assert Etna.except([], :some_key) == {:error, Etna.List}
    end

    test "stringify_keys returns error" do
      assert Etna.stringify_keys([]) == {:error, Etna.List}
    end

    test "symbolize_keys returns error" do
      assert Etna.symbolize_keys([]) == {:error, Etna.List}
    end
  end

  describe "Map" do
    test "compact returns %{} when map is nil or value is nil" do
      assert Etna.compact(%{a: nil}) == %{}
      assert Etna.compact(%{b: nil, c: 10}) == %{c: 10}
      assert Etna.compact(%{}) == %{}
    end

    test "include? returns true when key has same value" do
      assert Etna.include?(%{a: 10}, :a) == true
      assert Etna.include?(%{"a" => 10}, "a") == true
      assert Etna.include?(%{a: 10}, "a") == false
      assert Etna.include?(%{a: 10}, :b) == false
      assert Etna.include?(%{}, :A) == false
    end

    test "exclud? returns true when key has not same value" do
      assert Etna.exclude?(%{a: 10}, :a) == false
      assert Etna.exclude?(%{"a" => 10}, "a") == false
      assert Etna.exclude?(%{a: 10}, "a") == true
      assert Etna.exclude?(%{a: 10}, :b) == true
      assert Etna.exclude?(%{}, :A) == true
    end

    test "sum/1 returns culculated values" do
      assert Etna.sum(%{a: 10, b: 20}) == 30
      assert Etna.sum(%{a: "hello", b: "world"}) == "helloworld"
      assert Etna.sum(%{a: [1, 2], b: [3, 4]}) == 10
    end

    test "sum/2 returns error" do
      assert Etna.sum(%{a: 10}, fn -> nil end) == {:error, Etna.Map}
    end

    test "index_by returns a Map with the specified value as the key" do
      map = %{name: "pantani", age: 20, job: :rider}
      assert Etna.index_by(map, fn {k, _} -> k end) == %{name: {:name, "pantani"}, age: {:age, 20}, job: {:job, :rider}}
    end

    test "many? returns true when it has key with values" do
      assert Etna.many?(%{}) == false
      assert Etna.many?(%{key: 10}) == true
      assert Etna.many?(%{"key" => "value"}) == true
    end

    test "present? is an alias for many?" do
      assert Etna.present?(%{}) == false
      assert Etna.present?(%{key: 10}) == true
      assert Etna.present?(%{"key" => "value"}) == true
    end

    test "without alias Map.delete or Map.drop" do
      map = %{name: "pantani", age: 28, job: :rider}
      assert Etna.without(map, :name) == %{age: 28, job: :rider}
      assert Etna.without(map, :age) == %{name: "pantani", job: :rider}
      assert Etna.without(map, :not_specified) == map
      assert Etna.without(map, [:name, :age]) == %{job: :rider}
    end

    test "pluck returns error" do
      assert Etna.pluck(%{key: "value"}, :key) == {:error, Etna.Map}
    end

    test "to returns error" do
      assert Etna.to(%{key: "value"}, 2) == {:error, Etna.Map}
    end

    test "from returns error" do
      assert Etna.from(%{key: "value"}, 1) == {:error, Etna.Map}
    end

    test "except alias Map.delete" do
      map = %{name: "pantani", age: 28, job: :rider}
      assert Etna.except(map, :name) == %{age: 28, job: :rider}
      assert Etna.except(map, :age) == %{name: "pantani", job: :rider}
      assert Etna.except(map, :not_specified) == map
    end

    test "stringify_keys returns stringified map" do
      assert Etna.stringify_keys(%{name: "pantani", age: 28}) == %{"name" => "pantani", "age" => 28}
      assert Etna.stringify_keys(%{"name" => "pantani", "age" => 28}) == %{"name" => "pantani", "age" => 28}
    end

    test "symbolize_keys returns stringified map" do
      assert Etna.symbolize_keys(%{"name" => "pantani", "age" => 28}) == %{name: "pantani", age: 28}
      assert Etna.symbolize_keys(%{name: "pantani", age: 28}) == %{name: "pantani", age: 28}
    end

    test "blank? returns true when %{}" do
      assert Etna.blank?(%{}) == true
      assert Etna.blank?(%{key: 10}) == false
      assert Etna.blank?(%{"key" => "value"}) == false
    end

    test "wrap returns [map]" do
      assert Etna.wrap(%{}) == [%{}]
      assert Etna.wrap(%{name: "pantani", age: 28}) == [%{name: "pantani", age: 28}]
    end
  end
end
