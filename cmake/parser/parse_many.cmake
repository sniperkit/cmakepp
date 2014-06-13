
  function(parse_many rstring)
    map_tryget(${definition} begin)
    ans(begin)
    map_tryget(${definition} end)
    ans(end)
    map_tryget(${definition} element)
    ans(element)
    map_tryget(${definition} separator)
    ans(separator)         

    # create copy of input string
    ref_get(${rstring})
    ans(str)
    ref_setnew("${str}")
    ans(str)

    if(begin)
      parse_string(${str} ${begin})
      ans(res)
      list(LENGTH res len)
      if(${len} EQUAL 0)
        return()
      endif()
    endif()
    set(result_list)
    while(true)

      # try to parse end of list if it was parsed stop iterating
      if(end)
        parse_string(${str} ${end})
        ans(res)
        list(LENGTH res len)
        if(${len} GREATER 0)
          break()
        endif()
      endif()

      if(separator)
        if(result_list)
          parse_string(${str} ${separator})
          ans(res)
          list(LENGTH res len)
          if(${len} EQUAL 0)
            if(NOT end)
              break()
            endif()
            return()
          endif()
        endif()
      endif()

      parse_string("${str}" "${element}")
      ans(res)
      list(LENGTH res len)
      if(${len} EQUAL 0)
        if(NOT end)
          break()
        endif()
        return()
      endif()
      
      list(APPEND result_list "${res}")
    endwhile()    

    # set rstring
    ref_get(${str})
    ans(str)
    ref_set(${rstring} "${str}")
    
    list(LENGTH return_list len)
    if(NOT len)
      #return("")
    endif()
    return_ref(result_list)
  endfunction()
