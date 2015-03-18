function(test)

pushd(proj5 --create)
  fwrite_data("package.scmake" "{id:'bsd'}")
  project_handle_default()
  ans(project)
  assign(!project.project_descriptor.package_descriptor_file = 'package.scmake')
  project_open(${project})
  ans(project)
  assertf("{project.package_descriptor.id}" STREQUAL "bsd") 
  assign(project.package_descriptor.some_value = 'asdl')
  project_close(${project})
  fread_data(package.scmake)
  ans(data)
  assertf("{data.id}" STREQUAL "bsd")
  assertf("{data.some_value}" STREQUAL "asdl")

popd()
pushd(proj1 --create)
  project_open()
  ans(project)
  assertf({project.package_descriptor} ISNOTNULL)
  project_close(${project})
popd()

## no packagedescriptor -> package descriptor
pushd(proj2 --create)
  project_open()
  ans(project)
  assign(project.project_descriptor.package_descriptor_file = 'package.scmake')
  assign(project.package_descriptor = '')
  project_close(${project})
  assert(NOT EXISTS "package.scmake") # does not exist because project has not package descriptor
popd()

pushd(proj3 --create)
  project_open()
  ans(project)
  assign(project.package_descriptor.id = 'asd')
  assign(project.project_descriptor.package_descriptor_file = 'package.scmake')
  project_close(${project})
  assert(EXISTS "package.scmake")
  cmake_read("package.scmake")
  ans(data)
  assertf({data.id} STREQUAL "asd")
popd()

pushd(proj4 --create)
  fwrite_data("package.scmake" "{id:'bsd'}")
  project_open()
  ans(project)
  assign(project.project_descriptor.package_descriptor_file = 'package.scmake')
  project_close(${project})
  assertf("{project.package_descriptor.id}" STREQUAL "bsd")
  fread_data("package.scmake")
  ans(data)
  assertf("{data.id}" STREQUAL "bsd")
popd()



endfunction()