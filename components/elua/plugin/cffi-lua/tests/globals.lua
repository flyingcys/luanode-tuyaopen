local ffi = require('cffi')

ffi.cdef [[
    extern char const test_string[];
    extern int const test_ints[3];
]]

local L = require("testlib")

assert(L.test_string[0] == string.byte('f'))
assert(L.test_string[1] == string.byte('o'))
assert(L.test_string[2] == string.byte('o'))

assert(L.test_ints[0] == 42)
assert(L.test_ints[1] == 43)
assert(L.test_ints[2] == 44)

-- must be references
assert(tostring(ffi.typeof(L.test_string)) == "ctype<const char (&)[]>")
assert(tostring(ffi.typeof(L.test_ints)) == "ctype<const int (&)[3]>")
