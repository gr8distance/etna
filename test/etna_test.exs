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
end
