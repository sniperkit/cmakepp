![cmakepp logo](https://raw.githubusercontent.com/toeb/cmakepp/master/logo.png "cmakepp logo")

## A CMake Enhancement Suite
[![Travis branch](https://img.shields.io/travis/toeb/cmakepp/master.svg)](https://travis-ci.org/toeb/cmakepp)
[![GitHub stars](https://img.shields.io/github/stars/toeb/cmakepp.svg?)](https://github.com/toeb/cmakepp/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/toeb/cmakepp.svg)](https://github.com/toeb/cmakepp/network)
[![GitHub issues](https://img.shields.io/github/issues/toeb/cmakepp.svg)](https://github.com/toeb/cmakepp/issues)
[![Build Status](https://webapi.biicode.com/v1/badges/toeb/toeb/cmakepp/master?pleasegithubstopcachingmycoolbadge)](https://www.biicode.com/toeb/cmakepp)
[![Project Stats](https://www.ohloh.net/p/cmakepp/widgets/project_thin_badge.gif)](https://www.ohloh.net/p/cmakepp)


# Usage
Look through the files in the package.  Most functions will be commented and the other's usage can be inferred.  All functions are avaiable as soon as you include the `cmakepp.cmake` file.  To find functionality browse the `README.md` files throughout this project.



# Feature Overview

`cmakepp` has a lot of different functions. I tried to subdivide them into some meaningful sections. 


* [Creating Checksums](cmake/checksum/README.md)
* [Collections](cmake/collections/README.md)
* [Date/Time](cmake/datetime/README.md)
* [Events](cmake/events/README.md)
* [Filesystem](cmake/filesystem/README.md)
* [Functions](cmake/function/README.md)
* [Logging Functions](cmake/log/README.md)
* [Maps - Structured Data in CMake](cmake/map/README.md)
* [Navigation Functions](cmake/navigation/README.md)
* [Objects ](cmake/object/README.md)
* [Package Management](cmake/package/README.md)
* [User Data](cmake/persistence/README.md)
* [Process Management](cmake/process/README.md)
* [Quick Map Syntax](cmake/quickmap/README.md)
* [Reference Values](cmake/ref/README.md)
* [Windows Registry](cmake/reg/README.md)
* [Parsing and handling semantic versions](cmake/semver/README.md)
* [String Functions](cmake/string/README.md)
* [Targets](cmake/targets/README.md)
* [Templating ](cmake/templating/README.md)
* [Uniform Resource Identifiers (URIs)](cmake/uri/README.md)
* [HTTP Client](cmake/web/README.md)




# Samples 

I have developed some samples to show off `cmakepp`'s capabilities. Here you can find an overview of these samples







* [Compiling a simple progam by including `cmakepp` and pulling `eigen` library ](samples/01-include-cmakepp-pull-eigen/README.md)
* [Including and using `cmakepp` in `CMakeLists.txt`](samples/02-include-cmakepp-in-CMakeLists/README.md)
* [Downloading and Including `cmakepp` in a `CMakeLists.txt`](samples/03-download-include-cmakepp-in-CMakeLists/README.md)
* [Creating a Compressed Package](samples/04-create-simple-compressed-package/README.md)
* [Creating and Installing a Package with an Install Hook](samples/05-create-install-simple-package-with-install-script/README.md)
* [Installing and Using Projects with vanilla `CMake`](samples/06-vanilla-cmake-project-with-install/README.md)






# Getting `cmakepp` 

You have multiple options to install `cmakepp` the only prerequisite for all options is that [`CMake`](http://www.cmake.org) is installed with a version `>=2.8.12`.  `cmakepp` will also work with version less than `2.8.12` however some functions might fail.


* [Install by Console](#install_console) - Recommended
* Use the [Biicode Block](https://www.biicode.com/toeb/cmakepp)
* [Download a release](#install_download) and include it in your cmake script file - If you do not want to run the tests or have access to the single function files this option is for you.
  - [Manually setup aliases](#install_aliases)
* Clone the repository and include `cmakepp.cmake` in your `CMakeLists.txt` (or other cmake script)


## <a href="install_console"></a> Install by Console

For ease of use I provide you with simple copy paste code for your console of choice.  These scripts download the `install.cmake` file and execute it.  This file in turn downloads `cmakepp` and adds itself to your os (creating aliases and setting a environment variable - which allow you to use [icmake](#icmake) and [cmakepp cli](#cmake_cli) from the console).

*Bash*
```
#!bin/bash
wget https://raw.github.com/toeb/cmakepp/master/install.cmake && cmake -P install.cmake && rm install.cmake
```

*Powershell*
```
((new-object net.webclient).DownloadString('https://raw.github.com/toeb/cmakepp/master/install.cmake')) |`
out-file -Encoding ascii install.cmake\; `
cmake -P install.cmake\; `
rm install.cmake\;


```

## <a name="install_download"></a> Install by Downloading a Release

You can go ahead and download the current release from [here](https://github.com/toeb/cmakepp/releases).  A release supplies you with a standalone version of  `cmakepp` which contains every function of `cmakepp`.  This standalone  file can be included in any of your `CMake` scripts.

The following code shows you how you can retrieve and include it in any of your script files.


```
## downloads and includes `cmakepp.cmake` 
if(NOT EXISTS "cmakepp.cmake")
  file(DOWNLOAD "https://github.com/toeb/cmakepp/releases/download/v0.0.4/cmakepp.cmake" "cmakepp.cmake")
endif()
include("cmakepp.cmake")
```

## <a href="install_aliases"></a> Manually setting up aliases


```
cmake -P ./cmakepp.cmake cmakepp_setup_environment
```

After You run this and relogin/repoen your console/resource your .bashrc you will have access to the alias `cmakepp`, `icmake`, `pkg`. Also the environment variable `CMAKEPP_PATH` will be set to the location were `cmakepp.cmake` resides.


# Testing
To test the code (alot is tested but not all) run the following in the root dir of cmakepp *this takes long :)*

``` 
cmake -P build/script.cmake 
```

# Developing

If you want to help to develope `cmakepp` or want to develope `CMake` scripts which use `cmakepp` you can do the following:

* Install Sublime Text 3
* Be sure you have the `cmakepp` repository checked out
* open the `cmakepp.sublime-project` project in sublime text
* (add the folder in which you are developing your scripts)
* select the correct build system
  * `cmakepp run test` will run the current script open in SublimeText file as a test. It does not matter were this file resides. It expects a single function to exist inside this file - the name does not matter as it will be imported.  Inside the test function you will be provided with the following (also see [test_execute]():  
    * all `cmakepp` functions will be loaded from your current version of cmakepp.
    * a timer will run and report the time in milliseconds that your test took **NOTE** this is not very exact but sufficient in most cases
    * `${test_dir}` contains the the path of an empty directory which will remain the same for that specific test. It is cleared before the test is run so you can write anything to it and do not have to care about housekeeping.
    * the `<pwd>` will be set to `${test_dir}` allowing you to start using all `cmakepp` file/process functions relative to the test directory
    * `${test_name}` will contain the name chosen for this test (filename w/o extension)
  * `cmakepp run all tests` will run each test in `cmakepp` 
  * `cmakepp template run` will execute a `cmakepp` template file of which the filename ends with `.in` (see [templating](#))
  * you can open the `cmakepp.sublime-project` and modify the build system.
    
# Contributing

I would be very happy If you choose to contribute to `cmakepp`. You can open any issue on github and I will try to reply as soon as possible. I care about any feature you want implemented, bug you want squashed, or modification.

If you want to change something you may send pull requests through github. Normally I will check them quickly and `travis-ci` will build them.  I suggest you run all tests using the sublime project before you create a pull request to see if anything breaks.  (the master branch will have to pass the tests)  

Also if you want to support me financially for all the hardwork - consider donating a couple of $ <a href='https://pledgie.com/campaigns/28347'><img alt='Click here to lend your support to: cmakepp  and make a donation at pledgie.com !' src='https://pledgie.com/campaigns/28347.png?skin_name=chrome' border='0' ></a>

# Developer Guidlines

I am a bit a hypocrit. I am trying to adhere to these rules though:

* **DO NOT USE SHOUTY SYNTAX**  
* test your code. A single test file will suffice it should cover normal use cases and edge cases.  I use tests for documentation.
* One file per function. 
* Create a comment header with markdown above the function(with 2 # ).
* put the function in the most suitable folder. 
* name the function in a none colliding way
  - `CMake` only has a global scope for functions. Therefore be sure to name them in a way that they do not collide with existing functions and will not in the future.
* use `snake_case` for function names.  `CMake`'s functions are case independent so I discourage using `camelcase` 


# Implementation Notes


## <a name="formalisms"></a> Formalisms 

**Note**: *This section is incomplete but will give you an idea how I formally define data and functions.*

To describe cmake functions I use formalisms which I found most useful they should be intuitively understandable but here I want to describe them in detail.


* `@` denotes character data
* `<string> ::= "\""@"\""` denotes a string literal
* `<regex> ::= /<string>/` denotes a regular expression (as cmake defines it)
* `<identifier> ::= /[a-zA-Z0-9_-]+/` denotes a identifier which can be used for definitions
* `<datatype> ::= "<" "any"|"bool"|"number"|""|"void"|""|<structured data> <?"...">">"` denotes a datatype the elipses denotes that multiple values in array form are described else the datatype can be `any`, `bool`, `number`, `<structured data>` etc.. 
* `<named definition> ::= "<"<identifier>">"`
* `<definition> ::= "<"<?"?"><identifier>|<identifier>":"<datatype>|<datatype>>">"`  denotes a possibly name piece of data. this is used in signatures and object descriptions e.g. `generate_greeting(<firstname:<string>> <?lastname:<string>>):<string>` specifies a function which which takes a required parameter called `first_name` which is of type `string` and an optional parameter called `lastname` which is of type `string` and returns a `string`
* `<structured data> ::= "{"<? <named definition> ...>"}"`
* `<void>` primitve which stand for nothing
* `<falseish>:"false"|""|"no"` cmake's false values (list incomplete)
* `<trueish>: !<falseish>`
* `<bool> ::= "true":"false"` indicates a well defined true or false value
* `<boolish> ::= <trueish>|<falsish>|<bool>`
* `<any> ::= <string>|<number>|<structured data>|<bool>|<void>`
* `<named function parameter>`
* `<function parameter> ::= <definition>|<named function parameter>`
* `<function definition> `
* ... @todo


## <a name="return"></a>Returning values

**Related Functions**

* `return(...)` overwritten CMake function accepting arguments which are returned
* `ans(<var>)` a shorthand for getting the result of a function call and storing it in var
* `clr([PARENT_SCOPE])` clears the `__ans` variable in current scope or in PARENT_SCOPE if flag is set.  

A CMake function can return values by accessing it's parent scope.  Normally one does the following to return a value
```
  function(myfunc result)
    set(${result} "return value" PARENT_SCOPE)
  endfunction()
  myfunc(res)
  assert(${res} STREQUAL "return value")
```
This type of programming causes problems when nesting functions as one has to return every return value that a nested function returns. Doing this automatically would cause alot of overhead as the whole scope would have to be parsed to see which values are new after a  function call.

A cleaner alternative known from many programming languages is using a return value. I propose and have implemented the following pattern to work around the missing function return values of cmake. 

```
  function(myfunc)
    return("return_value")
  endfunction()
  myfunc()
  ans(res)
  # the __ans var is used as a register
  assert(${__ans} STREQUAL "return value")
  assert(${res} STREQUAL "return value")
```

This is possible by overwriting CMakes default return() function with a macro. It accepts variables and  will call `set(__ans ${ARGN} PARENT_SCOPE)` so after the call to `myfunc()` the scope will contain the variable `__ans`. using the `ans(<var>)` function is a shorthand for `set(<var> ${__ans})`.  

### Caveats

* The returnvalue should immediately be consumed after the call to `myfunc` because it might be reused again somewhere else.
* functions which do  not call return will not set  `__ans` in their parent scope.  If it is unclear weather a function really sets `__ans` you may want to clear it before the function call using `clr()` 
* the overwrite for `return` has to be a macro, else accessing the `PARAENT_SCOPE` would be unfeasible. However macros caus the passed arguments to be re-evaluated which destroys some string - string containing escaped variables or  other escaped characters.  This is often a problem - therfore I have als added the `return_ref` function which accepts a variable name that is then returned. 

### Alternatives
* a stack machine would also be a possiblity as this would allow returning multiple values. I have decided using the simpler single return value appoach as it is possible to return a structured list or a map if multiple return values are needed.



## <a name="cmakepp_cli"></a>`cmakepp` Console Client

`cmakepp` can be used as a platform independent console application. When you start `cmakepp.cmake` in script mode it parse the passed command line arguments and execute the specified `cmakepp` function returning the value in a serialization format. When you install `cmakepp` it will create an alias for `cmake -P /path/to/cmakepp.cmake` called `cmakepp`.

```bash
## return content of this directory using the cmakepp.cmake file
> cmake -P /path/to/cmakepp.cmake glob *.cmake --relative
[
 "cmakepp.cmake",
 "install.cmake",
 "package.cmake"
]

## perform a http GET request using the cmakepp alias
> cmakepp http_get http://httpbin.org/get?key=value --json
{
 "args":{
  "key":"value"
 },
 "headers":{
  "Accept":"*/*",
  "Host":"httpbin.org",
  "User-Agent":"curl/7.16.1"
 },
 "origin":"87.157.218.55",
 "url":"http://httpbin.org/get?key=value"
}

## parse an uri using the cmakepp alias
> cmakepp uri http+https://toeb:pass@www.example.com/path/to/file.ext?key=value&key2.subkey=value2 --select "scheme: @scheme key2.subkey: @params.key2.subkey"
"scheme: http+https key2.subkey: value2"
```

## <a name="icmake"></a>Interactive CMake Shell

If you want to learn try or learn cmake and `cmakepp` you can use the interactive cmake shell by launching `cmake -P icmake.cmake` which gives you a prompt with the all functions available in `cmakepp` and cmake in general.

`icmake` allows you to enter valid cmake and also a more lazily you can neglect to enter the parentheses around functions e.g. `cd my/path ` -> `cd(my/path)`

Since console interaction is complicated with cmake and cmake itself is not very general purpose by design the interactive cmake shell is not as user friendly as it should be.  If you input an error the shell will terminate because cmake terminates. This problem might be addressed in the future (I have an idea however not the time to implement and test it)
Example:
```
> ./icmake.sh
icmake> cd /usr/tobi
"/usr/tobi"
icmake> pwd
"/usr/tobi"
icmake> @echo off
echo is now off
icmake> pwd
icmake> message("${ANS}")
/usr/tobi
icmake> @echo on
echo is now on
icmake> function(myfunc name)\  # <-- backslash allows multiline input
          message("hello ${name}") \
          obj("{name: $name}")\
          ans(person)\
          return(${person})\
        endfunction()
"/usr/tobi"                 # <-- the last output of any function is always repeated. 
icmake> myfunc Tobi
hello Tobi          # <-- output in function using message
{"name":"Tobi"}       # <-- json serialized return value of function
icmake> quit
icmake is quitting
> 
```