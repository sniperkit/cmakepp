function(obj_gettype obj)
	obj_getprototype(${obj} )
  ans(proto)
	if(NOT proto)
    return()
	endif()
  map_get_special(${proto} constructor)
  ans(res)
	return_ref(res)

	
endfunction()