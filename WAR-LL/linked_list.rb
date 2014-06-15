class Linked_List

  def initialize
    @first_node = nil
    @last_node = nil
  end

  def add_last(value) #card value
      node = Node.new(value,nil)
      if @last_node = nil
        @last_node = node
        @first_node = node
      else
        @last_node.next_node = node
        @last_node = node
      end
      true
    end

    def remove_first
      if @first_node = nil
        nil
      else
        old_first_node = @first_node
        @first_node = @first_node.next_node
        old_first_node
      end
    end

    def swap #take one node and move behind another node (or in front - one or the other)
      #think about how index relates to a linked list
    end

  class Node
    attr_accessor :value, :next_node

    def initialize(value, next_node)
      @value = value
      @next_node = next_node
    end
  end

end
