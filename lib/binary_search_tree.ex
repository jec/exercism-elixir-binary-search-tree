defmodule BinarySearchTree do
  @type bst_node :: %{data: any, left: bst_node | nil, right: bst_node | nil}

  defstruct [:data, left: nil, right: nil]

  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  @spec new(any) :: bst_node
  def new(data) do
    %BinarySearchTree{data: data}
  end

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  @spec insert(bst_node, any) :: bst_node
  def insert(tree = %BinarySearchTree{left: nil}, data) when data <= tree.data do
    %BinarySearchTree{tree | left: %BinarySearchTree{data: data}}
  end
  def insert(tree, data) when data <= tree.data do
    %BinarySearchTree{tree | left: insert(tree.left, data)}
  end
  def insert(tree = %BinarySearchTree{right: nil}, data) when data > tree.data do
    %BinarySearchTree{tree | right: %BinarySearchTree{data: data}}
  end
  def insert(tree, data) when data > tree.data do
    %BinarySearchTree{tree | right: insert(tree.right, data)}
  end

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  @spec in_order(bst_node) :: [any]
  def in_order(tree = %BinarySearchTree{left: nil, right: nil}) do
    [tree.data]
  end
  def in_order(tree = %BinarySearchTree{left: nil}) do
    [tree.data | in_order(tree.right)]
  end
  def in_order(tree = %BinarySearchTree{right: nil}) do
    in_order(tree.left) ++ [tree.data]
  end
  def in_order(tree) do
    in_order(tree.left) ++ [tree.data | in_order(tree.right)]
  end
end

defimpl Inspect, for: BinarySearchTree do
  import Inspect.Algebra

  def inspect(tree, opts) do
    concat(["{", to_doc(tree.left, opts), " <= ", to_doc(tree.data, opts), " => ", to_doc(tree.right, opts), "}"])
  end
end
