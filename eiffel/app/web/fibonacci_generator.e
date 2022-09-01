note
	description : "Hey dude, it's a Eiffel Fibonacci"
	date        : "$Date$"
	revision    : "$Revision$"

class
	FIBONACCI_GENERATOR

create
	make

feature
	{NONE}
	make
		do
		end

feature
	calculate (k: INTEGER): INTEGER
		local
			j, p, c, n: INTEGER

		do
			from
				p := 0
				c := 1
				j := 1
			until
				j = k
			loop
				n := p + c
				p := c
				c := n
				j := j + 1
			end;

			Result := c
		end
end
