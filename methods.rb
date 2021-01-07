module Enumerable
  def my_each
    a = *self
    return to_enum(:my_each) unless block_given?
    i = 0
    a.length.times do
      yield(a[i])
      i += 1
    end
    self
  end

  def my_map(proc = nil)
    a = *self
    return to_enum(:my_map) unless block_given? || !proc.nil?
    temp = []
    i = 0
    if proc.nil?
      a.length.times do
        temp.push(yield(a[i]))
        i += 1
      end
    else
      a.length.times do
        temp.push(proc.call(a[i]))
        i += 1
      end
    end
    temp
  end

  def my_each_with_index
    a = *self
    return to_enum(:my_each_with_index) unless block_given?
    i = 0
    a.length.times do
      yield(a[i], i)
      i += 1
    end
    self
  end

  def my_select
    a = *self
    return to_enum(:my_select) unless block_given?
    temp = []
    i = 0
    a.length.times do
      temp.push(a[i]) if yield(a[i])
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
    a = *self
    i = 0
    count = 0
    if block_given?
      a.length.times do
        count += 1 if yield(a[i])
        i += 1
      end
      return count
    else
      unless arg.nil?
        a.length.times do
          count += 1 if a[i] == arg
          i += 1
        end
        return count
      end
      a.length
    end
  end

  def my_inject(*arg)
    a = *self
    if arg.size == 0
      raise LocalJumpError unless block_given?
      accumulator = a[0]
      i = 1
      (a.length - 1).times do
        accumulator = yield(accumulator, a[i])
        i += 1
      end
    elsif arg.size == 1
      if arg[0].is_a? Symbol
        pr = arg[0].to_proc
        accumulator = a[0]
        i = 1
        (a.length - 1).times do
          accumulator = pr.call(accumulator, a[i])
          i += 1
        end
      else
        raise LocalJumpError unless block_given?
        accumulator = arg[0]
        i = 0
        a.length.times do
          accumulator = yield(accumulator, a[i])
          i += 1
        end
      end
    elsif arg.size == 2
      accumulator = arg[0]
      pr = arg[1].to_proc
      i = 0
      a.length.times do
        accumulator = pr.call(accumulator, a[i])
        i += 1
      end
    end
    accumulator
  end
end

def multiply_els(arr)
  arr.my_inject { |multi, num| multi * num }
end

arr = [1, 2, 3, 4, 5]
