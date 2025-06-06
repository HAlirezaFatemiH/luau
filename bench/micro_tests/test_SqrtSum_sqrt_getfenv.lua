local function prequire(name) local success, result = pcall(require, name); return success and result end
local bench = script and require(script.Parent.bench_support) or prequire("bench_support") or require("../bench_support")

function test()

    local sqrt = math.sqrt
    getfenv()
    local ts0 = os.clock()
    local sum = 0
    for i=0,500000 do sum = sum + sqrt(i) end
    local ts1 = os.clock()

    return ts1-ts0
end

bench.runCode(test, "SqrtSum: sqrt getfenv")