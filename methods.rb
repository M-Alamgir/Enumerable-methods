module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?
    i = 0
    length.times do
      yield(self[i])
      i += 1
    end
    self
  end

  def my_map(proc = nil)
    return to_enum(:my_map) unless block_given? || !proc.nil?
    temp = []
    i = 0
    if proc.nil?
      length.times do
        temp.push(yield(self[i]))
        i += 1
      end
    else
      length.times do
        temp.push(proc.call(self[i]))
        i += 1
      end
    end
    temp
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?
    i = 0
    length.times do
      yield(self[i], i)
      i += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?
    temp = []
    i = 0
    length.times do
      temp.push(self[i]) if yield(self[i])
      i += 1
    end
    temp
  end

  def my_all?(arg = nil)
    i = 0
    if block_given?
      length.times do
        return false unless yield(self[i])

        i += 1
      end
      true
    else
      length.times do
        return false unless self[i]

        i += 1
      end
      true
    end
  end

  def my_any?
    i = 0
    if block_given?
      length.times do
        return true if yield(self[i])

        i += 1
      end
      false
    else
      length.times do
        return true if self[i]

        i += 1
      end
      false
    end
  end

  def my_none?
    i = 0
    if block_given?
      length.times do
        return false if yield(self[i])

        i += 1
      end
      true
    else
      length.times do
        return false if self[i]

        i += 1
      end
      true
    end
  end

  def my_count(arg = nil)
    i = 0
    count = 0
    if block_given?
      length.times do
        count += 1 if yield(self[i])
        i += 1
      end
      return count
    else
      unless arg.nil?
        length.times do
          count += 1 if self[i] == arg
          i += 1
        end
        return count
      end
      length
    end
  end

  def my_inject(arg = nil)
    raise LocalJumpError unless block_given?
    accumulator = arg
    if arg.nil?
      accumulator = self[0]
      i = 1
      (length - 1).times do
        accumulator = yield(accumulator, self[i])
        i += 1
      end
    else
      i = 0
      length.times do
        accumulator = yield(accumulator, self[i])
        i += 1
      end
    end
    accumulator
  end
end

def multiply_els(arr)
  arr.my_inject { |multi, num| multi * num }
end

a = [2, 4, 6, 7, 8, 10, 10]
map_proc = proc { |num| num + 1 }
p a.my_map(map_proc)