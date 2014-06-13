# compares two maps and returns true if they are equal
function(map_equal  mapA mapB)

	map_keys(${mapA} )
	ans(keysA)
	map_keys(${mapB} )
	ans(keysB)

	list(SORT keysA)
	list(SORT keysB)

	list_equal( keysA keysB)
	ans(keys_equal)
	if(NOT keys_equal)
		#message("not keys equal ${keysA} - ${keysB}")
		return(false)
	endif()

	foreach(key ${keysA})
		map_get(${mapA}  ${key})
		ans(valA)
		map_get(${mapB}  ${key})
		ans(valB)
		list_equal( ${valA} ${valB})
		ans(val_equal)
		if(NOT val_equal)
			#message("not vals equal")
			return(false)
		endif()
	endforeach()
	return(true)
endfunction()