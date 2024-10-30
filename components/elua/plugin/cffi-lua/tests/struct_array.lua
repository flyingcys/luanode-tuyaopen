local ffi = require("cffi")

ffi.cdef [[
    struct foo {
        int x;
        size_t pad1, pad2;
        struct {
            char y;
            size_t pad3, pad4;
            short z;
        };
        size_t pad5;
        size_t pad6;
        char const *w;
    };

    struct flex {
        int x;
        double y[];
    };

    union bar {
        struct {
            unsigned char x, y;
        };
        unsigned short z;
    };

    struct baz {
        int x, y;
    };

    struct sbaz {
        struct baz x, y, z;
    };

    struct schara {
        char foo[4];
    };

    struct multi {
        int x[3][4][5];
    };

    struct arr {
        char buf[16];
        char buf2[];
    };
]]

-- struct

local x = ffi.new("struct foo")

local s = "hello"
x.x = 150
x.y = 30
x.z = 25
x.w = s

assert(x.x == 150)
assert(x.y == 30)
assert(x.z == 25)
assert(ffi.string(x.w) == "hello")

local ox = ffi.offsetof("struct foo", "x")
local oy = ffi.offsetof("struct foo", "y")
local oz = ffi.offsetof("struct foo", "z")
local ow = ffi.offsetof("struct foo", "w")

assert(ox == 0)
assert(oy > ox)
assert(oz > oy)
assert(ow > oz)

-- simple array

local x = ffi.new("int[3]")
assert(ffi.sizeof(x) == ffi.sizeof("int") * 3)

assert(x[0] == 0)
assert(x[1] == 0)
assert(x[2] == 0)

x[0] = 5
x[1] = 10
x[2] = 15

assert(x[0] == 5)
assert(x[1] == 10)
assert(x[2] == 15)

-- array with initializer

local x = ffi.new("int[3]", 5)
assert(ffi.sizeof(x) == ffi.sizeof("int") * 3)

assert(x[0] == 5)
assert(x[1] == 5)
assert(x[2] == 5)

-- flexible array members

local x = ffi.new("struct flex", 3);
x.x = 5
x.y[0] = 10
x.y[1] = 15
x.y[2] = 20

assert(x.x == 5)
assert(x.y[0] == 10)
assert(x.y[1] == 15)
assert(x.y[2] == 20)

-- union

local x = ffi.new("union bar")
x.x = 5
x.y = 10

assert(x.x == 5)
assert(x.y == 10)
if ffi.abi("le") then
    assert(x.z == 0xA05)
else
    assert(x.z == 0x50A)
end

-- array of structs

local x = ffi.new("struct baz[4]");
assert(ffi.sizeof(x) == ffi.sizeof("int") * 8)

local st = ffi.typeof("struct baz")
x[0] = st(10, 15)

-- test with constant source
local y = ffi.cast("struct baz const *", x)
x[2] = y[0]

-- table initialization of member
x[1] = { 35, 45 }

assert(x[0].x == 10)
assert(x[0].y == 15)
assert(x[1].x == 35)
assert(x[1].y == 45)
assert(x[2].x == 10)
assert(x[2].y == 15)
assert(x[3].x == 0)
assert(x[3].y == 0)

-- test assignment to constant source
local b, err = pcall(function()
    y[0] = st(100, 200)
end)
assert(not b)
assert(err:match(".+: attempt to write to constant location"))

-- struct of structs assignment

local x = ffi.new("struct sbaz")
x.x = st(20, 25)
x.z = x.x
x.y = { 35, 45 }

assert(x.x.x == 20)
assert(x.x.y == 25)
assert(x.y.x == 35)
assert(x.y.y == 45)
assert(x.z.x == 20)
assert(x.z.y == 25)

-- array in string

local x = ffi.new("struct schara")
x.foo = "abc"
assert(ffi.string(x.foo) == "abc")

x.foo = "abcd1234"
assert(ffi.string(x.foo) == "abcd")

-- multidimensional array in struct

local x = ffi.new("struct multi")
assert(ffi.sizeof(x) == ffi.sizeof("struct multi"))
assert(ffi.sizeof(x) == ffi.sizeof("int") * 3 * 4 * 5)
assert(ffi.sizeof(x) == ffi.sizeof("int [3][4][5]"))

-- pointer arithmetic with member arrays

local x = ffi.new("struct arr", 16)
ffi.copy(x.buf, "hello world")
ffi.copy(x.buf2, "flex flex")
assert(ffi.string(x.buf) == "hello world")
assert(ffi.string(x.buf2) == "flex flex")
assert(ffi.string(x.buf + 6) == "world")
assert(ffi.string(x.buf2 + 5) == "flex")
assert(x.buf[4] == (x.buf + 4)[0])
assert(x.buf2[4] == (x.buf2 + 4)[0])
assert(x.buf[4] == string.byte("o"))
