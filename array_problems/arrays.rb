require 'rubygems'
require 'pry-debugger'

module ArrayUtil
  def self.max(array)
    if array.length == 0
      max = nil
    elsif array.length == 1
      max = array[0]
    else
      max = array[0]
      array.each_with_index do |element, index|
        if index < array.length-1
          if max < array[index+1]
            max = array[index+1]
          end
        end
      end
    end
    return max
  end

  def self.middle_element(array)

    if array.length == 0
      return nil
    elsif array.length == 1
      return array[0]
    elsif array.length % 2 != 0
      array[array.length/2] #calculates the number in the middle, returns the rounded down number which subsequently equals the index
    elsif array.length % 2 == 0
      index = array.length/2
      ((array[index] + array[index - 1]).to_f)/2
    end
  end

  def self.sum_arrays(array1, array2)
    array1.map.with_index do |element, index|
      element + array2[index]
    end
  end
end
