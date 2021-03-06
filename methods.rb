# rubocop:disable Metrics/ModuleLength
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

  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
  # rubocop:disable Metrics/MethodLength

  def my_all?(*arg)
    a = *self
    i = 0
    return puts "given #{arg.size}, expected 0..1" if arg.size > 1

    if arg[0].is_a? Class
      a.length.times do
        return false unless a[i].is_a?(arg[0])

        i += 1
      end
    elsif arg[0].is_a? Regexp
      a.length.times do
        return false unless a[i] =~ arg[0]

        i += 1
      end
    elsif arg.size == 1
      a.length.times do
        return false unless a[i] == arg[0]

        i += 1
      end
    elsif block_given?
      a.length.times do
        return false unless yield(a[i])

        i += 1
      end
    else
      a.length.times do
        return false unless a[i]

        i += 1
      end
    end
    true
  end

  def my_any?(*arg)
    a = *self
    i = 0
    return puts "given #{arg.size}, expected 0..1" if arg.size > 1

    if arg[0].is_a? Class
      a.length.times do
        return true if a[i].is_a?(arg[0])

        i += 1
      end
    elsif arg[0].is_a? Regexp
      a.length.times do
        return true if a[i] =~ arg[0]

        i += 1
      end
    elsif arg.size == 1
      a.length.times do
        return true if a[i] == arg[0]

        i += 1
      end
    elsif block_given?
      a.length.times do
        return true if yield(a[i])

        i += 1
      end
    else
      a.length.times do
        return true if a[i]

        i += 1
      end
    end
    false
  end

  def my_none?(*arg)
    a = *self
    i = 0
    return puts "given #{arg.size}, expected 0..1" if arg.size > 1

    if arg[0].is_a? Class
      a.length.times do
        return false if a[i].is_a?(arg[0])

        i += 1
      end
    elsif arg[0].is_a? Regexp
      a.length.times do
        return false if a[i] =~ arg[0]

        i += 1
      end
    elsif arg.size == 1
      a.length.times do
        return false if a[i] == arg[0]

        i += 1
      end
    elsif block_given?
      a.length.times do
        return false if yield(a[i])

        i += 1
      end
    else
      a.length.times do
        return false if a[i]

        i += 1
      end
    end
    true
  end

  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity
  # rubocop:enable Metrics/MethodLength

  def my_count(arg = nil)
    a = *self
    i = 0
    count = 0
    if block_given?
      a.length.times do
        count += 1 if yield(a[i])
        i += 1
      end
      count
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

  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
  # rubocop:disable Metrics/MethodLength
  def my_inject(*arg)
    a = *self
    return puts "given #{arg.size}, expected 0..2" if arg.size > 2

    if arg[0].is_a? Symbol
      pr = arg[0].to_proc
      accumulator = a[0]
      i = 1
      (a.length - 1).times do
        accumulator = pr.call(accumulator, a[i])
        i += 1
      end
    elsif arg[1].is_a? Symbol
      accumulator = arg[0]
      pr = arg[1].to_proc
      a.my_each do |element|
        accumulator = pr.call(accumulator, element)
      end
    elsif block_given?
      accumulator = arg[0]
      a.my_each do |element|
        accumulator = !accumulator ? element : yield(accumulator, element)
      end
    else
      raise LocalJumpError unless block_given?
    end
    accumulator
  end
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity
  # rubocop:enable Metrics/MethodLength
end
# rubocop:enable Metrics/ModuleLength

def multiply_els(arr)
  arr.my_inject { |multi, num| multi * num }
end
