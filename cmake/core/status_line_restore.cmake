function(status_line_restore)
  map_tryget(global status)
  ans(status)
  echo_append("${status}")
endfunction()