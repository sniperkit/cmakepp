##
##
## runs all tests specified in glob expressions in parallel 
function(test_execute_glob_parallel)
  list_extract_flag(args --no-status)
  ans(no_status)
  set(args ${ARGN})

  ## get all test files 
  cd("${CMAKE_CURRENT_BINARY_DIR}")
  glob("${args}")
  ans(test_files)


  ## setup refs which are used by callback
  list(LENGTH test_files test_count)
  ref_set(test_count ${test_count})
  ref_set(tests_failed)
  ref_set(tests_succeeded)
  ref_set(tests_completed)

  ## 
  set(processes)

  ## status callback  shows 
  set(status_callback)
  if(NOT no_status)
    function_new()
    ans(status_callback)  
    function(${status_callback})
      ref_get(tests_failed)
      ans(tests_failed)
      ref_get(tests_succeeded)
      ans(tests_succeeded)
      ref_get(test_count)
      ans(test_count)
      ref_get(tests_completed)
      ans(tests_completed)

      list(LENGTH tests_failed failure_count)
      list(LENGTH tests_succeeded success_count)
      list(LENGTH tests_completed completed_count)

      timer_elapsed(test_time_sum)
      ans(elapsed_time)
      spinner()
      ans(spinner)
      status_line("${completed_count}  / ${test_count}  ok: ${success_count} nok: ${failure_count}  (running ${running_count}) (elapsed time ${elapsed_time} ms) ${spinner}")
    endfunction()
    ## add flag
    set(status_callback --idle-callback ${status_callback})
  endif()

  ## test complete callback outputs info and if test fails also the stderr of the test's process
  function_new()
  ans(test_complete_callback)
  function(${test_complete_callback} process_handle)
    map_tryget(${process_handle} exit_code)
    ans(error)

    if(error)
      ref_append(tests_failed ${process_handle})
      message(FORMAT "failed: {process_handle.test_file}")
      message(FORMAT "test output: {process_handle.stderr}")
    else()
      ref_append(tests_succeeded ${process_handle})
      message(FORMAT "success: {process_handle.test_file}")

    endif()
    ref_append(tests_completed ${process_handle})
  endfunction()

  ## init time for all tests
  timer_start(test_time_sum)

  ## start every test in parallel 
  foreach(test_file ${test_files})
    ## start test in a async process and add it to the process list
    cmakepp("test_execute" "${test_file}" --async)  # wrapped execute()
    ans(process)
    list(APPEND processes ${process})    

    ## add a property to process handle which is passed on to callback
    map_set(${process} test_file ${test_file})

    ## add a listener to on_terminated event from process handle
    assign(success = process.on_terminated.add(${test_complete_callback}))

    ## since starting a process is relatively slow I added a process wait -1 
    ## here that gathers all completed processes 
    ## -1 indicates that it will take only the finished processes
    process_wait_n(-1 ${processes} ${status_callback})
    ans(complete)
    ## remove the completed tests from the processes so that they will not be waited for again
    if(complete)
      list(REMOVE_ITEM processes ${complete})
    endif()
  endforeach()
  
  ## wait for all remaining processes (* indicates that all processes are to be waited for)
  process_wait_n(* ${processes} ${status_callback})


endfunction()