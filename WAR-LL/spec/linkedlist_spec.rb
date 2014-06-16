require 'rubygems'
require 'rspec'
require 'pry-debugger'
require_relative '../linked_list.rb'

describe "Linked_List" do
  it "exists" do
    expect(Linked_List).to be_a(Class)
  end

  describe '#initialize' do
    it 'instantiates a linked list with a nil first_node and last_node' do
      list1 = Linked_List.new
      expect(list1.first_node).to eq(nil)
      expect(list1.last_node).to eq(nil)
      expect(list1.count).to eq(0)
    end
  end

  describe '#add_last' do
    before do
      @list1 = Linked_List.new
    end
    it 'adds a new node to an empty list' do
      expect(@list1.count).to eq(0)

      expect(@list1.add_last(1)).to eq(true)

      expect(@list1.last_node.value).to eq(1)
      expect(@list1.count).to eq(1)
    end
    it 'adds a new node to the end of a list with other nodes' do
      @list1.add_last(1)
      @list1.add_last(2)

      expect(@list1.count).to eq(2)
      expect(@list1.first_node.value).to eq(1)
      expect(@list1.last_node.value). to eq(2)
    end
  end

  describe '#remove_first' do
    before do
      @list1 = Linked_List.new
    end
    it "checks whether there is a first_node to remove" do
      expect(@list1.remove_first).to eq(nil)
    end

    it "removes the first_node from the list" do
      @list1.add_last(1)
      @list1.add_last(2)
      expect(@list1.count).to eq(2)

      @list1.remove_first
      expect(@list1.count).to eq(1)

      expect(@list1.first_node.value).to eq(2)
    end
  end

end

describe "Linked_List::Node" do
  it "exists" do
    expect(Linked_List::Node).to be_a(Class)
  end

  describe '#initialize' do
    before do
      @node1 = Linked_List::Node.new(1,nil)
    end
    it 'initializes a node with a value and a pointer to next_node' do
      expect(@node1.value).to eq(1)
      expect(@node1.next_node).to eq(nil)
    end
    it 'can point to the next_node' do
      node2 = Linked_List::Node.new(2, nil)

      @node1.next_node = node2

      expect(@node1.next_node).to eq(node2)
    end
  end
end
