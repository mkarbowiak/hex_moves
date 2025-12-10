defmodule HexMoves.Factory.Behaviour do
  @callback build() :: struct()
  @callback build(attributes :: map() | keyword()) :: struct()
end
