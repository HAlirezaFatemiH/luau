-- This file is part of the Luau programming language and is licensed under MIT License; see LICENSE.txt for details
-- This file is based on Lua 5.x tests -- https://github.com/lua/lua/tree/master/testes
print('testing strings and string library')

assert('alo' < 'alo1')
assert('' < 'a')
assert('alo\0alo' < 'alo\0b')
assert('alo\0alo\0\0' > 'alo\0alo\0')
assert('alo' < 'alo\0')
assert('alo\0' > 'alo')
assert('\0' < '\1')
assert('\0\0' < '\0\1')
assert('\1\0a\0a' <= '\1\0a\0a')
assert(not ('\1\0a\0b' <= '\1\0a\0a'))
assert('\0\0\0' < '\0\0\0\0')
assert(not('\0\0\0\0' < '\0\0\0'))
assert('\0\0\0' <= '\0\0\0\0')
assert(not('\0\0\0\0' <= '\0\0\0'))
assert('\0\0\0' <= '\0\0\0')
assert('\0\0\0' >= '\0\0\0')
assert(not ('\0\0b' < '\0\0a\0'))
print('+')

assert(string.sub("123456789",2,4) == "234")
assert(string.sub("123456789",7) == "789")
assert(string.sub("123456789",7,6) == "")
assert(string.sub("123456789",7,7) == "7")
assert(string.sub("123456789",0,0) == "")
assert(string.sub("123456789",-10,10) == "123456789")
assert(string.sub("123456789",1,9) == "123456789")
assert(string.sub("123456789",-10,-20) == "")
assert(string.sub("123456789",-1) == "9")
assert(string.sub("123456789",-4) == "6789")
assert(string.sub("123456789",-6, -4) == "456")
assert(string.sub("\000123456789",3,5) == "234")
assert(("\000123456789"):sub(8) == "789")
print('+')

assert(string.find("123456789", "345") == 3)
a,b = string.find("123456789", "345")
assert(string.sub("123456789", a, b) == "345")
assert(string.find("1234567890123456789", "345", 3) == 3)
assert(string.find("1234567890123456789", "345", 4) == 13)
assert(string.find("1234567890123456789", "346", 4) == nil)
assert(string.find("1234567890123456789", ".45", -9) == 13)
assert(string.find("abcdefg", "\0", 5, 1) == nil)
assert(string.find("", "") == 1)
assert(string.find('', 'aaa', 1) == nil)
assert(('alo(.)alo'):find('(.)', 1, 1) == 4)
assert(string.find('', '1', 2) == nil)
assert(string.find('123', '2', 0) == 2)
print('+')

assert(string.len("") == 0)
assert(string.len("\0\0\0") == 3)
assert(string.len("1234567890") == 10)
assert(string.len(123) == 3)

assert(#"" == 0)
assert(#"\0\0\0" == 3)
assert(#"1234567890" == 10)

assert(string.byte("a") == 97)
assert(string.byte("\xe4") > 127)
assert(string.byte(string.char(255)) == 255)
assert(string.byte(string.char(0)) == 0)
assert(string.byte("\0") == 0)
assert(string.byte("\0\0alo\0x", -1) == string.byte('x'))
assert(string.byte("ba", 2) == 97)
assert(string.byte("\n\n", 2, -1) == 10)
assert(string.byte("\n\n", 2, 2) == 10)
assert(string.byte("") == nil)
assert(string.byte("hi", -3) == nil)
assert(string.byte("hi", 3) == nil)
assert(string.byte("hi", 9, 10) == nil)
assert(string.byte("hi", 2, 1) == nil)
assert(string.char() == "")
assert(string.char(0, 255, 0) == "\0\255\0")
assert(string.char(0, string.byte("\xe4"), 0) == "\0\xe4\0")
assert(string.char(string.byte("\xe4l\0óu", 1, -1)) == "\xe4l\0óu")
assert(string.char(string.byte("\xe4l\0óu", 1, 0)) == "")
assert(string.char(string.byte("\xe4l\0óu", -10, 100)) == "\xe4l\0óu")
assert(pcall(function() return string.char(256) end) == false)
assert(pcall(function() return string.char(-1) end) == false)
print('+')

assert(string.upper("ab\0c") == "AB\0C")
assert(string.lower("\0ABCc%$") == "\0abcc%$")
assert(string.rep('teste', 0) == '')
assert(string.rep('tés\00tê', 2) == 'tés\0têtés\000tê')
assert(string.rep('', 10) == '')
assert(string.rep('', 1e9) == '')
assert(pcall(string.rep, 'x', 2e9) == false)

assert(string.reverse"" == "")
assert(string.reverse"\0\1\2\3" == "\3\2\1\0")
assert(string.reverse"\0001234" == "4321\0")

for i=0,30 do assert(string.len(string.rep('a', i)) == i) end

assert(type(tostring(nil)) == 'string')
assert(type(tostring(12)) == 'string')
assert(''..12 == '12' and type(12 .. '') == 'string')
assert(string.find(tostring{}, 'table:'))
assert(string.find(tostring(print), 'function:'))
assert(tostring(1234567890123) == '1234567890123')
assert(#tostring('\0') == 1)
assert(tostring(true) == "true")
assert(tostring(false) == "false")

function nothing() end

assert(pcall(tostring) == false)
assert(pcall(function() return tostring(nothing()) end) == false)

print('+')

x = '"ílo"\n\\'
assert(string.format('%q%s', x, x) == '"\\"ílo\\"\\\n\\\\""ílo"\n\\')
assert(string.format('%q', "\0") == [["\000"]])
assert(string.format('%q', "\r") == [["\r"]])
assert(string.format("\0%c\0%c%x\0", string.byte("\xe4"), string.byte("b"), 140) ==
              "\0\xe4\0b8c\0")
assert(string.format('') == "")
assert(string.format("%c",34)..string.format("%c",48)..string.format("%c",90)..string.format("%c",100) ==
       string.format("%c%c%c%c", 34, 48, 90, 100))
assert(string.format("%c%c%c%c", 1, 0, 2, 3) == '\1\0\2\3')
assert(string.format("%5c%5c%5c%5c", 1, 0, 2, 3) == '    \1    \0    \2    \3')
assert(string.format("%-5c%-5c%-5c%-5c", 1, 0, 2, 3) == '\1    \0    \2    \3    ')
assert(string.format("%s\0 is not \0%s", 'not be', 'be') == 'not be\0 is not \0be')
assert(string.format("%%%d %010d", 10, 23) == "%10 0000000023")
assert(tonumber(string.format("%f", 10.3)) == 10.3)
x = string.format('"%-50s"', 'a')
assert(#x == 52)
assert(string.sub(x, 1, 4) == '"a  ')

assert(string.format("-%.20s.20s", string.rep("%", 2000)) == "-"..string.rep("%", 20)..".20s")
assert(string.format('"-%20s.20s"', string.rep("%", 2000)) ==
       string.format("%q", "-"..string.rep("%", 2000)..".20s"))

assert(string.format("%o %u %x %X", -1, -1, -1, -1) == "1777777777777777777777 18446744073709551615 ffffffffffffffff FFFFFFFFFFFFFFFF")

assert(string.format("%e %E", 1.5, -1.5) == "1.500000e+00 -1.500000E+00")

assert(pcall(string.format, "%##################d", 1) == false)
assert(pcall(string.format, "%.123d", 1) == false)
assert(pcall(string.format, "%?", 1) == false)

-- longest number that can be formated
assert(string.len(string.format('%99.99f', -1e308)) >= 100)

local function return_one_thing()
	return "hi"
end
local function return_two_nils()
	return nil, nil
end

assert(string.format("%*", return_one_thing()) == "hi")
assert(string.format("%* %*", return_two_nils()) == "nil nil")
assert(pcall(function()
	string.format("%* %* %*", return_two_nils())
end) == false)

assert(string.format("%*", "a\0b\0c") == "a\0b\0c")
assert(string.format("%*", string.rep("doge", 3000)) == string.rep("doge", 3000))
assert(string.format("%*", 42) == "42")
assert(string.format("%*", true) == "true")

assert(string.format("%*", setmetatable({}, { __tostring = function() return "ok" end })) == "ok")

local ud = newproxy(true)
getmetatable(ud).__tostring = function() return "good" end
assert(string.format("%*", ud) == "good")

assert(string.format(string.rep("%*", 100), table.unpack(table.create(100, 1))) == string.rep("1", 100))

do
	local a = "1234567890"
	a = string.format("%*%*%*%*%*", a, a, a, a, a)
	a = string.format("%*%*%*%*%*", a, a, a, a, a)
	a = string.format("%*%*%*%*%*", a, a, a, a, a)
	assert(a == string.rep("1234567890", 125))
end

assert(pcall(function()
	string.format("%#*", "bad form")
end) == false)

assert(loadstring("return 1\n--comentário sem EOL no final")() == 1)


assert(table.concat{} == "")
assert(table.concat({}, 'x') == "")
assert(table.concat({'\0', '\0\1', '\0\1\2'}, '.\0.') == "\0.\0.\0\1.\0.\0\1\2")
local a = {}; for i=1,3000 do a[i] = "xuxu" end
assert(table.concat(a, "123").."123" == string.rep("xuxu123", 3000))
assert(table.concat(a, "b", 20, 20) == "xuxu")
assert(table.concat(a, "", 20, 21) == "xuxuxuxu")
assert(table.concat(a, "", 22, 21) == "")
assert(table.concat(a, "3", 2999) == "xuxu3xuxu")

a = {"a","b","c"}
assert(table.concat(a, ",", 1, 0) == "")
assert(table.concat(a, ",", 1, 1) == "a")
assert(table.concat(a, ",", 1, 2) == "a,b")
assert(table.concat(a, ",", 2) == "b,c")
assert(table.concat(a, ",", 3) == "c")
assert(table.concat(a, ",", 4) == "")

-- string.split
do
  local function eq(a, b)
    if #a ~= #b then
      return false
    end
    for i=1,#a do
      if a[i] ~= b[i] then
        return false
      end
    end
    return true
  end

  assert(eq(string.split("abc", ""), {'a', 'b', 'c'}))
  assert(eq(string.split("abc", "b"), {'a', 'c'}))
  assert(eq(string.split("abc", "d"), {'abc'}))
  assert(eq(string.split("abc", "c"), {'ab', ''}))
end

-- validate that variadic string fast calls get correct number of arguments
local function chr1(c)
  return string.char(tonumber(c));
end

assert(chr1("0") == "\0")

--[[
local locales = { "ptb", "ISO-8859-1", "pt_BR" }
local function trylocale (w)
  for _, l in ipairs(locales) do
    if os.setlocale(l, w) then return true end
  end
  return false
end

if not trylocale("collate")  then
  print("locale not supported")
else
  assert("alo" < "álo" and "álo" < "amo")
end

if not trylocale("ctype") then
  print("locale not supported")
else
  assert(string.gsub("áéíóú", "%a", "x") == "xxxxx")
  assert(string.gsub("áÁéÉ", "%l", "x") == "xÁxÉ")
  assert(string.gsub("áÁéÉ", "%u", "x") == "áxéx")
  assert(string.upper"áÁé{xuxu}ção" == "ÁÁÉ{XUXU}ÇÃO")
end

os.setlocale("C")
assert(os.setlocale() == 'C')
assert(os.setlocale(nil, "numeric") == 'C')
]]--

return('OK')


