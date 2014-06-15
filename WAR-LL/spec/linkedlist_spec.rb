#write tests - figure out git
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
      expect(Linked_List.first_node).to eq(nil)
      expect(Linked_List.last_node).to eq(nil)
    end
  end

  describe '#add_last' do
    it 'adds a new node to the end of the list' do
      list1 = Linked_List.new
      Linked_List.add_last(1)
      expect(Linked_List.last_node).to eq(nil)

    end

    it "adds a new node to the end of the list when theres no other node" do
      list1 = Linked_List.new

    end
  end

  describe '#remove_first' do
    it "checks whether there is a first_node to remove" do
      list1 = Linked_List.new

    end

    it "removes the first_node from the list" do
      list1 = Linked_List.new

    end
  end
  describe '#swap' do
    it "swaps the first_node with the next_node" do
      list1 = Linked_List.new

    end
  end
end

describe "Linked_List::Node" do
  it "exists" do
    expect(Linked_List::Node).to be_a(Class)
  end

  describe '#initialize' do
    it 'initializes a node with a value and a pointer to next_node' do
      node1 = Linked_List::Node.new(1,nil)
      expect(node1.value).to eq(1)
      expect(node1.value).to eq(nil)
    end
  end
end
