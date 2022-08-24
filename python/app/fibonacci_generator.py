from functools import reduce

class FibonacciGenerator():
    def __init__(self, index):
        self.__index__ = index
        self.__fibonacci__ = lambda n: reduce(lambda x, _: x + [x[-1] + x[-2]], range(n - 2), [0, 1])

    def calculate(self):
        result = self.__fibonacci__(self.__index__ + 1)
        return result[self.__index__]

