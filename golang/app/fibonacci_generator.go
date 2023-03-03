package main

func FibonacciGenerator(index int) int {
	fibonacci := make([]int, index+1, index+2)

	if index < 2 {
		fibonacci = fibonacci[0:2]
	}

	fibonacci[0] = 0
	fibonacci[1] = 1

	for i := 2; i <= index; i++ {
		fibonacci[i] = fibonacci[i-1] + fibonacci[i-2]
	}

	return fibonacci[index]
}
