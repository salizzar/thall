defmodule FibonacciGenerator do
    defp comp_fib(0), do: [0 | 0]
    defp comp_fib(1), do: [1 | 0]

    defp comp_fib(n) do
        [h | t] = comp_fib(n-1)
        [h+t | h]
    end

    def calculate(n), do: hd(comp_fib(n))
end
