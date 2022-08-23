class FibonacciGenerator
  def initialize(number)
    @fibonacci = Hash.new{ |h,k| h[k] = k < 2 ? k : h[k-1] + h[k-2] }
    @number = number
  end

  def calculate
    @fibonacci[@number]
  end
end

