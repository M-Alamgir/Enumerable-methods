module Enumerable
    def my_each
        i = 0
        (self.length).times do
            yield(self[i])
            i += 1
        end
        return self
    end

    def my_map(proc = nil)
        temp = []
        if(proc == nil)
            i = 0
            (self.length).times do
                temp.push(yield(self[i]))
                i += 1
            end
        else
            i = 0
            (self.length).times do
                temp.push(proc.call(self[i]))
                i += 1
            end
        end
        return temp
    end

    def my_each_with_index
        i = 0
        (self.length).times do
            yield(self[i], i)
            i += 1
        end
        return self
    end

    def my_select
        temp = []
        i = 0
        (self.length).times do
            if (yield(self[i]))
                temp.push(self[i])
            end
            i += 1
        end
        return temp
    end

    def my_all?
        i = 0
        (self.length).times do
            return false unless (yield(self[i]))
            i += 1
        end
        return true
    end

    def my_any?
        i = 0
        (self.length).times do
            return true if (yield(self[i]))
            i += 1
        end
        return false
    end

    def my_none?
        i = 0
        (self.length).times do
            return false if (yield(self[i]))
            i += 1
        end
        return true
    end
end

a = [2, 4, 6, 7, 8, 10, 10]