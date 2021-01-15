defprotocol Etna do
  def compact(enum)
  def include?(enum, val)
  def exclude?(enum, val)
  def sum(enum, f)
  def index_by(enum, f)
  def many?(enum)
  def without(enum, list)
  def pluck(enum, list)

  def to(list, index)
  def from(list, index)

  def except(map, key)
  def stringify_keys(map)
  def symbolize_keys(map)

  def blank?(val)
  def present?(val)
  def wrap(val)
end
