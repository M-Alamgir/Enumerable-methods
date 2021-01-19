require_relative '../methods.rb'

describe Enumerable do
  let(:arr) {[1, 2, 3]}
  let(:h) {{ one: 1, two: 2, three: 3, four: 4 }}
  let(:range) {(1..3)}
  describe '#my_each' do
    it 'returns the array itself' do
      expect(arr.my_each { |num| num }).to eql(arr)
    end
    it 'returns the hash itself' do
      expect(h.my_each { |key, _value| key }).to eql(h)
    end
    it 'returns the range itself' do
      expect(range.my_each { |num| num }).to eql(range)
    end
    it 'returns an enumerator if no block given' do
      expect(arr.my_each.is_a?(Enumerator)).to eql(true)
    end
  end

  describe '#my_each_with_index' do
    it 'returns the array itself' do
      expect(arr.my_each_with_index { |num, _i| num }).to eql(arr)
    end
    it 'returns the hash itself' do
      expect(h.my_each_with_index { |key, _value, _i| key }).to eql(h)
    end
    it 'returns the range itself' do
      expect(range.my_each_with_index { |num, _i| num }).to eql(range)
    end
    it 'returns an enumerator if no block given' do
      expect(arr.my_each_with_index.is_a?(Enumerator)).to eql(true)
    end
  end

  describe '#my_map' do
    it 'iterates through an array and returns the modified values' do
      expect(arr.my_map { |num| num + 1 }).to eql([2, 3, 4])
    end
    it 'iterates through a range and returns the modified values' do
      expect(range.my_map { |num| num + 1 }).to eql([2, 3, 4])
    end
    it 'returns an enumerator if no block given' do
      expect(arr.my_map.is_a?(Enumerator)).to eql(true)
    end
  end

  describe '#my_all?' do
    it 'return true if all the elements are truthy' do
      expect(arr.my_all?).to eql(true)
    end
    it 'return false if one of the elements is falsy' do
      expect([1, 2, false].my_all?).to eql(false)
    end
    it 'return true if all the elements are of the given Class' do
      expect(arr.my_all?(Numeric)).to eql(true)
    end
    it 'return true if all the elements contains the given RegEx' do
      expect(%w[hey hello hi].my_all?(/h/)).to eql(true)
    end
    it 'return true if all the elements are equal to the given argument' do
      expect([1, 1, 1, 1].my_all?(1)).to eql(true)
    end
    it 'return true if all the elements comply with the given block' do
      expect(arr.my_all?{ |num| num > 0 }).to eql(true)
    end
  end

  describe '#my_any?' do
    it 'return true if one of the elements are truthy' do
      expect(arr.my_any?).to eql(true)
    end
    it 'return false if all the elements is falsy' do
      expect([false, nil, false].my_any?).to eql(false)
    end
    it 'return true if one of the elements are of the given Class' do
      expect(arr.my_any?(Numeric)).to eql(true)
    end
    it 'return true if one of the elements contains the given RegEx' do
      expect(%w[hey belo hi].my_any?(/h/)).to eql(true)
    end
    it 'return true if one of the elements are equal to the given argument' do
      expect([1, 6, 2, 8].my_any?(1)).to eql(true)
    end
    it 'return true if ome of the elements comply with the given block' do
      expect(arr.my_any?{ |num| num > 0 }).to eql(true)
    end
  end

  describe '#my_none?' do
    it 'return true if all elements are falsy' do
      expect(arr.my_none?).not_to eql(true)
    end
    it 'return false if all elements is truthy' do
      expect([2, 'love', true].my_none?).to eql(false)
    end
    it 'return true if none of the elements are of the given Class' do
      expect(arr.my_none?(String)).to eql(true)
    end
    it 'return true if none of the elements contains the given RegEx' do
      expect(%w[key belo bi].my_none?(/h/)).to eql(true)
    end
    it 'return true if none of the elements are equal to the given argument' do
      expect([5, 6, 2, 8].my_none?(1)).to eql(true)
    end
    it 'return true if none of the elements comply with the given block' do
      expect(arr.my_none?{ |num| num > 4 }).to eql(true)
    end
  end

  describe '#my_select' do
    it 'returns an array with the elements(Integers) that are true to the block given' do
      expect(arr.my_select{ |num| num < 3 }).to eql([1, 2])
    end
    it 'returns an array with the elements(Strings) that are true to the block given' do
      expect(%w[p a t r i c k].my_select{ |num| num =~ /[sdlfua]/ }).to eql(['a'])
    end
    it 'returns an empty array if the elements are false to the block given' do
      expect(arr.my_select{ |num| num > 4 }).to eql([])
    end
    it 'returns an enumerator if no block given' do
      expect(arr.my_select.is_a?(Enumerator)).to eql(true)
    end
  end

  describe '#my_count' do
    it 'counts the elements of an array if no block is given' do
      expect(arr.my_count).to eql(3)
    end
    it 'counts the elements that are true to the block' do
      expect(arr.my_count{ |num| num > 1 }).to eql(2)
    end
    it 'returns 0 if no elements are true to the block' do
      expect(arr.my_count{ |num| num > 4 }).to eql(0)
    end
    it 'counts the elements that are equal to the parameter given' do
      expect([1, 1, 2, 3, 5, 7, 1].my_count(1)).to eql(3)
    end
  end

  describe '#my_inject' do
    it 'returns the result of the mathematical operation passed to the argument as a symbol' do
      expect((5..10).my_inject(:+)).to eql(45)
    end
    it 'returns the result of the mathematical operation passed to the argument as a symbol' do
      expect(arr.my_inject(:*)).to eql(6)
    end
    it 'returns the result of the mathematical operation passed to the argument as a symbol using an accumulator' do
      expect((5..10).my_inject(10, :+)).to eql(55)
    end
    it 'returns the result of the mathematical operation passed as a block' do
      expect((1..5).my_inject{ |acc, num| acc + num }).to eql(15)
    end
    it 'returns the result of the mathematical operation passed as a block while using an accumulator' do
      expect((1..5).my_inject(10){ |acc, num| acc + num }).to eql(25)
    end
    it 'returns the longest string' do
      expect(%w[cat mouse elephant dog].my_inject{ |acc, word| acc.length > word.length ? acc : word }).to eql('elephant')
    end
    it 'raises a LoaclJump error if no block or symbol is given' do
      expect{ arr.my_inject }.to raise_error(LocalJumpError)
    end
  end
end
