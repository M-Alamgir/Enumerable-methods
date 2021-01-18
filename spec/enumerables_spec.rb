require_relative '../methods.rb'

describe Enumerable do
  let(:arr) {[1, 2, 3]}
  let(:h) {{ one: 1, two: 2, three: 3, four: 4 }}
  let(:range) {(1..3)}
  describe '#my_each' do
    it 'returns the array itself' do
      expect(arr.my_each {|num| num}).to eql(arr)
    end
    it 'returns the hash itself' do
      expect(h.my_each {|key, value| key}).to eql(h)
    end
    it 'returns the range itself' do
      expect(range.my_each {|num| num}).to eql(range)
    end
  end

  describe '#my_each_with_index' do
    it 'returns the array itself' do
      expect(arr.my_each_with_index {|num, i| num}).to eql(arr)
    end
    it 'returns the hash itself' do
      expect(h.my_each_with_index {|key, value, i| key}).to eql(h)
    end
    it 'returns the range itself' do
      expect(range.my_each_with_index {|num, i| num}).to eql(range)
    end
  end

  describe 'my_map' do
    it 'iterates through an array and returns the modified values' do
      expect(arr.my_map {|num| num + 1}).to eql([2, 3, 4])
    end
    it 'iterates through a range and returns the modified values' do
      expect(range.my_map {|num| num + 1}).to eql([2, 3, 4])
    end
  end

  describe 'my_all?' do
    it 'return true if all the elements are truthy' do
      expect(arr.my_all?).to eql(true)
    end
    it 'return false if one of the elements is falsy' do
      expect([1, 2, false].my_all?).to eql(false)
    end
    it 'return true if all the elements are of the given Class' do
      expect(arr.my_all?(Numeric)).to eql(true)
    end
    it 'return true if all the elements containe the given RegEx' do
      expect(%w[hey hello hi].my_all?(/h/)).to eql(true)
    end
    it 'return true if all the elements are the equall to the given argument' do
      expect([1, 1, 1, 1].my_all?(1)).to eql(true)
    end
    it 'return true if all the elements comply with the given block' do
      expect(arr.my_all?{|num| num > 0}).to eql(true)
    end
  end
end