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

end

a = [2, 4, 6, 7, 8, 10, 10]