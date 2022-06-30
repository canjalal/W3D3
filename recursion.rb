=begin
Write a recursive method, range, that takes a start and an end and returns an array of all numbers in that range, exclusive. For example, range(1, 5) should return [1, 2, 3, 4]. If end < start, you can return an empty array.
Write both a recursive and iterative version of sum of an array.
=end
def range(start, finish)
    return [] if finish - start <= 1
    
    return range(start, finish - 1) + [finish - 1]
end

# p range(11, 17)

# def exp(b, n)
#     return nil if b == 0 && n == 0 # this is math!!!
#     return 0 if b == 0 && n != 0
#     return 1 if n == 0

#     b * exp(b, n - 1)
# end

def exp(b, n)
    return 1 if n == 0
    return b if n == 1

    if n % 2 == 0 
        exp(b, n/2) * exp(b, n/2)
    else
        b * (exp(b, (n-1)/2) * exp(b, (n-1)/2))
    end

end

# p exp(5, 3) # 125
# p exp(1, 12) # 1
# p exp(2, 8) # 256
# p exp(-2, 7) # -128
# p exp(5, 0) # 1
# p exp(0, 5) # 0

# # this is math, not Ruby methods.

# # recursion 1
# exp(b, 0) = 1
# exp(b, n) = b * exp(b, n - 1)

# # recursion 2
# exp(b, 0) = 1
# exp(b, 1) = b
# exp(b, n) = exp(b, n / 2) ** 2             [for even n]
# exp(b, n) = b * (exp(b, (n - 1) / 2) ** 2) [for odd n]


class Array

    def deep_dup(data = self)
        return [data.dup] unless data.is_a?(Array)
        newarr = []
        data.each do |ele|
            newarr += deep_dup(ele)
        end
        return newarr

    end
end



# robot_parts = [
#   ["nuts", "bolts", "washers"],
#   ["capacitors", "resistors", "inductors"]
# ]

# robot_parts_copy = robot_parts.deep_dup

# # shouldn't modify robot_parts
# robot_parts_copy[1] << "LEDs"
# # but it does
# p robot_parts[1] # => ["capacitors", "resistors", "inductors", "LEDs"]

def iterative_fibonacci(n)
    return [] if n == 0
    return [0] if n == 1
    return [0, 1] if n == 2

    newarr = [0, 1]

    (n-2).times do
        newarr << newarr[-1] + newarr[-2]
    end 

    newarr

    
end

# p iterative_fibonacci(22)

def recursive_fibonacci(n) # array version
    return [] if n == 0
    return [0] if n == 1
    return [0, 1] if n == 2

    fib = recursive_fibonacci(n - 1)

    fib << fib[-1] + fib[-2] 
    # if n = 7

    # recursive_fibonacci(n - 1) => [0, 1, 1, 2, 3, 5]
end

# p recursive_fibonacci(78)

# def fibonacci(n, memo = {})
#     return 0 if n == 1
#     return 1 if n == 2

#     if(memo[n])
#         return memo[n]
#     else
#         memo[n] = fibonacci(n - 1, memo) + fibonacci(n - 2, memo)
#         return memo[n]
#     end
# end

# p fibonacci(78)



def bsearch(array, target)

    return nil if array.length == 0

    middle = array.length / 2
    left_side = array[0...middle]
    right_side = array[(middle+1)..-1]
    return middle if array[middle] == target

    if target < array[middle]
        bsearch(left_side,target)
    else
        idx = bsearch(right_side,target)
        if idx.nil?
            return nil
        else
            idx + middle + 1
        end
    end



    #     return middle + bsearch(array[(middle + 1)..-1], target)
    # else
    #     return 0 + bsearch(array[0..(middle - 1)], target)
    # end

end


# p bsearch([1, 2, 3], 1) # => 0
# p bsearch([2, 3, 4, 5], 3) # => 1
# p bsearch([2, 4, 6, 8, 10], 6) # => 2
# p bsearch([1, 3, 4, 5, 9], 5) # => 3
# p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
# p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
# p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil

def merge_sort(arr)

    return arr if arr.length <= 1

    middle = arr.length / 2

    left_side = arr[0...middle]
    right_side = arr[middle..-1] # don't use middle+1 because you may be out of bounds. Instead, do 0...middle and middle..-1 to split an array

    merge_sort(left_side)
    merge_sort(right_side)

    merge(merge_sort(left_side),merge_sort(right_side))
end

def merge(sorted_array1, sorted_array2)
    newarr = []
    until sorted_array1.empty? && sorted_array2.empty?
            
        if sorted_array1.empty?
            newarr << sorted_array2.shift
        elsif sorted_array2.empty?
            newarr << sorted_array1.shift
        elsif sorted_array1[0] < sorted_array2[0]
            newarr << sorted_array1.shift
        elsif sorted_array1[0] >= sorted_array2[0]
            newarr << sorted_array2.shift
        end
    end
    newarr
        

end

# p merge_sort([38, 27, 43, 3, 9, 82, 10])

# class Array
    
    def subsets(data)
        newarr = [] 
        return newarr << [] if data.empty?
        # return [data] if data.length <= 1 
        
        data.each_with_index do |ele, i|
            newarr = subsets(data[0...i] + data[i+1..-1]) + newarr
        end   

        newarr<< data
        [[]]|newarr
    end


# end

# p subsets([]) # => [[]]
# p subsets([1]) # => [[], [1]]
# p subsets([1, 2]) # => [[], [1], [2], [1, 2]]
# p subsets([1, 2, 3])
# # # => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]


def permutations(array)
    newarr = []
    return array if array.length == 1
    array.each_with_index do |ele, i|
        newarr << [ele] + permutations()
    end
    
    newarr
    
    
end

p permutations([1, 2, 3]) 
# => [[1, 2, 3], [1, 3, 2],
#     [2, 1, 3], [2, 3, 1],
#     [3, 1, 2], [3, 2, 1]]