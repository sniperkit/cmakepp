function(test)
	element(MAP)
		value(KEY k1 1)
		value(KEY k2 2)
		element(k3 MAP)
			value(KEY k1 "a")
			element(k2 LIST)
				value(I)
				value(II)
				value(III)
			element(END)
		element(END)
	element(END uut)



	# empty path
	map_navigate(res "")
	assert(${res} STREQUAL "NOTFOUND")
	

	# unevaluated ref
	map_navigate(res "uut")
	assert(${res} STREQUAL "${uut}")


	# evaluated ref
	map_navigate(res "${uut}")
	assert(${res} STREQUAL "${uut}")

	# navigate simple value
	map_navigate(res "uut.k1")
	assert(${res} STREQUAL "1")
	map_navigate(res "${uut}.k1")
	assert(${res} STREQUAL "1")

	# navigate nested value
	map_navigate(res "uut.k3.k1")
	assert(${res} STREQUAL "a")

	# navigate nested value with index
	map_navigate(res "uut.[2].k1")
	assert(${res} STREQUAL "a")

	# navigate nested value multiple indeces
	map_navigate(res "uut.[2][1][2]")
	assert(${res} STREQUAL "III")


	# navigate nested value multiple mixed indeces
	map_navigate(res "uut.[2].k2[2]")
	assert(${res} STREQUAL "III")

endfunction()