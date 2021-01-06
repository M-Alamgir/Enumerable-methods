module Enumerable
  def my_each
    i = 0
    (self.length).times do
      yield(self[i])
      i += 1
      end
    self
  end
  
  def my_map(proc = nil)
    temp = []
    if(proc == nil)
      i = 0
      length.times do
        temp.push(yield(self[i]))
        i += 1
      end
    else
      i = 0
      length.times do
        temp.push(proc.call(self[i]))
        i += 1
      end
    end
    temp
  end
  
  def my_each_with_index
    i = 0
    length.times do
      yield(self[i], i)
      i += 1
    end
    self
  end
  
  def my_select
    temp = []
    i = 0
    length.times do
      if (yield(self[i]))
        temp.push(self[i])
      end
      i += 1
    end
    temp
  end
  
  def my_all?
    i = 0
    length.times do
      return false unless (yield(self[i]))
      i += 1
    end
    true
  end
  
  def my_any?
    i = 0
    length.times do
      return true if (yield(self[i]))
      i += 1
    end
    false
  end
  
  def my_none?
    i = 0
    length.times do
      return false if (yield(self[i]))
      i += 1
    end
    true
  end
  
  def my_count(arg = nil)
    if arg != nil
      i = 0
      count = 0
      length.times do
        count += 1 if self[i] == arg
        i += 1
      end
      return count
    end
    length
  end
  
  def my_inject(arg = nil)
    accumulator = arg
    if arg == nil
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
p a.count
map_proc = proc { |num| num + 1 }
p a.my_map(map_proc)
