
local ____modules = {}
local ____moduleCache = {}
local ____originalRequire = require
local function require(file)
    if ____moduleCache[file] then
        return ____moduleCache[file]
    end
    if ____modules[file] then
        ____moduleCache[file] = ____modules[file]()
        return ____moduleCache[file]
    else
        if ____originalRequire then
            return ____originalRequire(file)
        else
            error("module '" .. file .. "' not found")
        end
    end
end
____modules = {
[".lualib_bundle"] = function() function __TS__ArrayIsArray(value)
    return (type(value) == "table") and ((value[1] ~= nil) or (next(value, nil) == nil))
end

function __TS__ArrayConcat(arr1, ...)
    local args = {...}
    local out = {}
    for ____, val in ipairs(arr1) do
        out[#out + 1] = val
    end
    for ____, arg in ipairs(args) do
        if __TS__ArrayIsArray(arg) then
            local argAsArray = arg
            for ____, val in ipairs(argAsArray) do
                out[#out + 1] = val
            end
        else
            out[#out + 1] = arg
        end
    end
    return out
end

function __TS__ArrayEvery(arr, callbackfn)
    do
        local i = 0
        while i < #arr do
            if not callbackfn(_G, arr[i + 1], i, arr) then
                return false
            end
            i = i + 1
        end
    end
    return true
end

function __TS__ArrayFilter(arr, callbackfn)
    local result = {}
    do
        local i = 0
        while i < #arr do
            if callbackfn(_G, arr[i + 1], i, arr) then
                result[#result + 1] = arr[i + 1]
            end
            i = i + 1
        end
    end
    return result
end

function __TS__ArrayForEach(arr, callbackFn)
    do
        local i = 0
        while i < #arr do
            callbackFn(_G, arr[i + 1], i, arr)
            i = i + 1
        end
    end
end

function __TS__ArrayFind(arr, predicate)
    local len = #arr
    local k = 0
    while k < len do
        local elem = arr[k + 1]
        if predicate(_G, elem, k, arr) then
            return elem
        end
        k = k + 1
    end
    return nil
end

function __TS__ArrayFindIndex(arr, callbackFn)
    do
        local i = 0
        local len = #arr
        while i < len do
            if callbackFn(_G, arr[i + 1], i, arr) then
                return i
            end
            i = i + 1
        end
    end
    return -1
end

function __TS__ArrayIncludes(self, searchElement, fromIndex)
    if fromIndex == nil then
        fromIndex = 0
    end
    local len = #self
    local k = fromIndex
    if fromIndex < 0 then
        k = len + fromIndex
    end
    if k < 0 then
        k = 0
    end
    for i = k, len do
        if self[i + 1] == searchElement then
            return true
        end
    end
    return false
end

function __TS__ArrayIndexOf(arr, searchElement, fromIndex)
    local len = #arr
    if len == 0 then
        return -1
    end
    local n = 0
    if fromIndex then
        n = fromIndex
    end
    if n >= len then
        return -1
    end
    local k
    if n >= 0 then
        k = n
    else
        k = len + n
        if k < 0 then
            k = 0
        end
    end
    do
        local i = k
        while i < len do
            if arr[i + 1] == searchElement then
                return i
            end
            i = i + 1
        end
    end
    return -1
end

function __TS__ArrayJoin(self, separator)
    if separator == nil then
        separator = ","
    end
    local result = ""
    for index, value in ipairs(self) do
        if index > 1 then
            result = tostring(result) .. tostring(separator)
        end
        result = tostring(result) .. tostring(
            tostring(value)
        )
    end
    return result
end

function __TS__ArrayMap(arr, callbackfn)
    local newArray = {}
    do
        local i = 0
        while i < #arr do
            newArray[i + 1] = callbackfn(_G, arr[i + 1], i, arr)
            i = i + 1
        end
    end
    return newArray
end

function __TS__ArrayPush(arr, ...)
    local items = {...}
    for ____, item in ipairs(items) do
        arr[#arr + 1] = item
    end
    return #arr
end

function __TS__ArrayReduce(arr, callbackFn, ...)
    local len = #arr
    local k = 0
    local accumulator = nil
    if select("#", ...) ~= 0 then
        accumulator = select(1, ...)
    elseif len > 0 then
        accumulator = arr[1]
        k = 1
    else
        error("Reduce of empty array with no initial value", 0)
    end
    for i = k, len - 1 do
        accumulator = callbackFn(_G, accumulator, arr[i + 1], i, arr)
    end
    return accumulator
end

function __TS__ArrayReduceRight(arr, callbackFn, ...)
    local len = #arr
    local k = len - 1
    local accumulator = nil
    if select("#", ...) ~= 0 then
        accumulator = select(1, ...)
    elseif len > 0 then
        accumulator = arr[k + 1]
        k = k - 1
    else
        error("Reduce of empty array with no initial value", 0)
    end
    for i = k, 0, -1 do
        accumulator = callbackFn(_G, accumulator, arr[i + 1], i, arr)
    end
    return accumulator
end

function __TS__ArrayReverse(arr)
    local i = 0
    local j = #arr - 1
    while i < j do
        local temp = arr[j + 1]
        arr[j + 1] = arr[i + 1]
        arr[i + 1] = temp
        i = i + 1
        j = j - 1
    end
    return arr
end

function __TS__ArrayShift(arr)
    return table.remove(arr, 1)
end

function __TS__ArrayUnshift(arr, ...)
    local items = {...}
    do
        local i = #items - 1
        while i >= 0 do
            table.insert(arr, 1, items[i + 1])
            i = i - 1
        end
    end
    return #arr
end

function __TS__ArraySort(arr, compareFn)
    if compareFn ~= nil then
        table.sort(
            arr,
            function(a, b) return compareFn(_G, a, b) < 0 end
        )
    else
        table.sort(arr)
    end
    return arr
end

function __TS__ArraySlice(list, first, last)
    local len = #list
    local relativeStart = first or 0
    local k
    if relativeStart < 0 then
        k = math.max(len + relativeStart, 0)
    else
        k = math.min(relativeStart, len)
    end
    local relativeEnd = last
    if last == nil then
        relativeEnd = len
    end
    local final
    if relativeEnd < 0 then
        final = math.max(len + relativeEnd, 0)
    else
        final = math.min(relativeEnd, len)
    end
    local out = {}
    local n = 0
    while k < final do
        out[n + 1] = list[k + 1]
        k = k + 1
        n = n + 1
    end
    return out
end

function __TS__ArraySome(arr, callbackfn)
    do
        local i = 0
        while i < #arr do
            if callbackfn(_G, arr[i + 1], i, arr) then
                return true
            end
            i = i + 1
        end
    end
    return false
end

function __TS__ArraySplice(list, ...)
    local len = #list
    local actualArgumentCount = select("#", ...)
    local start = select(1, ...)
    local deleteCount = select(2, ...)
    local actualStart
    if start < 0 then
        actualStart = math.max(len + start, 0)
    else
        actualStart = math.min(start, len)
    end
    local itemCount = math.max(actualArgumentCount - 2, 0)
    local actualDeleteCount
    if actualArgumentCount == 0 then
        actualDeleteCount = 0
    elseif actualArgumentCount == 1 then
        actualDeleteCount = len - actualStart
    else
        actualDeleteCount = math.min(
            math.max(deleteCount or 0, 0),
            len - actualStart
        )
    end
    local out = {}
    do
        local k = 0
        while k < actualDeleteCount do
            local from = actualStart + k
            if list[from + 1] then
                out[k + 1] = list[from + 1]
            end
            k = k + 1
        end
    end
    if itemCount < actualDeleteCount then
        do
            local k = actualStart
            while k < (len - actualDeleteCount) do
                local from = k + actualDeleteCount
                local to = k + itemCount
                if list[from + 1] then
                    list[to + 1] = list[from + 1]
                else
                    list[to + 1] = nil
                end
                k = k + 1
            end
        end
        do
            local k = len
            while k > ((len - actualDeleteCount) + itemCount) do
                list[k] = nil
                k = k - 1
            end
        end
    elseif itemCount > actualDeleteCount then
        do
            local k = len - actualDeleteCount
            while k > actualStart do
                local from = (k + actualDeleteCount) - 1
                local to = (k + itemCount) - 1
                if list[from + 1] then
                    list[to + 1] = list[from + 1]
                else
                    list[to + 1] = nil
                end
                k = k - 1
            end
        end
    end
    local j = actualStart
    for i = 3, actualArgumentCount do
        list[j + 1] = select(i, ...)
        j = j + 1
    end
    do
        local k = #list - 1
        while k >= ((len - actualDeleteCount) + itemCount) do
            list[k + 1] = nil
            k = k - 1
        end
    end
    return out
end

function __TS__ArrayToObject(array)
    local object = {}
    do
        local i = 0
        while i < #array do
            object[i] = array[i + 1]
            i = i + 1
        end
    end
    return object
end

function __TS__ArrayFlat(array, depth)
    if depth == nil then
        depth = 1
    end
    local result = {}
    for ____, value in ipairs(array) do
        if (depth > 0) and __TS__ArrayIsArray(value) then
            result = __TS__ArrayConcat(
                result,
                __TS__ArrayFlat(value, depth - 1)
            )
        else
            result[#result + 1] = value
        end
    end
    return result
end

function __TS__ArrayFlatMap(array, callback)
    local result = {}
    do
        local i = 0
        while i < #array do
            local value = callback(_G, array[i + 1], i, array)
            if (type(value) == "table") and __TS__ArrayIsArray(value) then
                result = __TS__ArrayConcat(result, value)
            else
                result[#result + 1] = value
            end
            i = i + 1
        end
    end
    return result
end

function __TS__ArraySetLength(arr, length)
    if (((length < 0) or (length ~= length)) or (length == math.huge)) or (math.floor(length) ~= length) then
        error(
            "invalid array length: " .. tostring(length),
            0
        )
    end
    do
        local i = #arr - 1
        while i >= length do
            arr[i + 1] = nil
            i = i - 1
        end
    end
    return length
end

function __TS__Class(self)
    local c = {prototype = {}}
    c.prototype.__index = c.prototype
    c.prototype.constructor = c
    return c
end

function __TS__ClassExtends(target, base)
    target.____super = base
    local staticMetatable = setmetatable({__index = base}, base)
    setmetatable(target, staticMetatable)
    local baseMetatable = getmetatable(base)
    if baseMetatable then
        if type(baseMetatable.__index) == "function" then
            staticMetatable.__index = baseMetatable.__index
        end
        if type(baseMetatable.__newindex) == "function" then
            staticMetatable.__newindex = baseMetatable.__newindex
        end
    end
    setmetatable(target.prototype, base.prototype)
    if type(base.prototype.__index) == "function" then
        target.prototype.__index = base.prototype.__index
    end
    if type(base.prototype.__newindex) == "function" then
        target.prototype.__newindex = base.prototype.__newindex
    end
    if type(base.prototype.__tostring) == "function" then
        target.prototype.__tostring = base.prototype.__tostring
    end
end

function __TS__CloneDescriptor(____bindingPattern0)
    local enumerable
    enumerable = ____bindingPattern0.enumerable
    local configurable
    configurable = ____bindingPattern0.configurable
    local get
    get = ____bindingPattern0.get
    local set
    set = ____bindingPattern0.set
    local writable
    writable = ____bindingPattern0.writable
    local value
    value = ____bindingPattern0.value
    local descriptor = {enumerable = enumerable == true, configurable = configurable == true}
    local hasGetterOrSetter = (get ~= nil) or (set ~= nil)
    local hasValueOrWritableAttribute = (writable ~= nil) or (value ~= nil)
    if hasGetterOrSetter and hasValueOrWritableAttribute then
        error("Invalid property descriptor. Cannot both specify accessors and a value or writable attribute.", 0)
    end
    if get or set then
        descriptor.get = get
        descriptor.set = set
    else
        descriptor.value = value
        descriptor.writable = writable == true
    end
    return descriptor
end

function __TS__Decorate(decorators, target, key, desc)
    local result = target
    do
        local i = #decorators
        while i >= 0 do
            local decorator = decorators[i + 1]
            if decorator then
                local oldResult = result
                if key == nil then
                    result = decorator(_G, result)
                elseif desc == true then
                    local value = rawget(target, key)
                    local descriptor = __TS__ObjectGetOwnPropertyDescriptor(target, key) or ({configurable = true, writable = true, value = value})
                    local desc = decorator(_G, target, key, descriptor) or descriptor
                    local isSimpleValue = (((desc.configurable == true) and (desc.writable == true)) and (not desc.get)) and (not desc.set)
                    if isSimpleValue then
                        rawset(target, key, desc.value)
                    else
                        __TS__SetDescriptor(
                            target,
                            key,
                            __TS__ObjectAssign({}, descriptor, desc)
                        )
                    end
                elseif desc == false then
                    result = decorator(_G, target, key, desc)
                else
                    result = decorator(_G, target, key)
                end
                result = result or oldResult
            end
            i = i - 1
        end
    end
    return result
end

function __TS__DecorateParam(paramIndex, decorator)
    return function(____, target, key) return decorator(_G, target, key, paramIndex) end
end

function __TS__ObjectGetOwnPropertyDescriptors(object)
    local metatable = getmetatable(object)
    if not metatable then
        return {}
    end
    return rawget(metatable, "_descriptors") or ({})
end

function __TS__Delete(target, key)
    local descriptors = __TS__ObjectGetOwnPropertyDescriptors(target)
    local descriptor = descriptors[key]
    if descriptor then
        if not descriptor.configurable then
            error(
                ((("Cannot delete property " .. tostring(key)) .. " of ") .. tostring(target)) .. ".",
                0
            )
        end
        descriptors[key] = nil
        return true
    end
    if target[key] ~= nil then
        target[key] = nil
        return true
    end
    return false
end

function __TS__DelegatedYield(iterable)
    if type(iterable) == "string" then
        for index = 0, #iterable - 1 do
            coroutine.yield(
                __TS__StringAccess(iterable, index)
            )
        end
    elseif iterable.____coroutine ~= nil then
        local co = iterable.____coroutine
        while true do
            local status, value = coroutine.resume(co)
            if not status then
                error(value, 0)
            end
            if coroutine.status(co) == "dead" then
                return value
            else
                coroutine.yield(value)
            end
        end
    elseif iterable[Symbol.iterator] then
        local iterator = iterable[Symbol.iterator](iterable)
        while true do
            local result = iterator:next()
            if result.done then
                return result.value
            else
                coroutine.yield(result.value)
            end
        end
    else
        for ____, value in ipairs(iterable) do
            coroutine.yield(value)
        end
    end
end

function __TS__New(target, ...)
    local instance = setmetatable({}, target.prototype)
    instance:____constructor(...)
    return instance
end

function __TS__GetErrorStack(self, constructor)
    local level = 1
    while true do
        local info = debug.getinfo(level, "f")
        level = level + 1
        if not info then
            level = 1
            break
        elseif info.func == constructor then
            break
        end
    end
    return debug.traceback(nil, level)
end
function __TS__WrapErrorToString(self, getDescription)
    return function(self)
        local description = getDescription(self)
        local caller = debug.getinfo(3, "f")
        if (_VERSION == "Lua 5.1") or (caller and (caller.func ~= error)) then
            return description
        else
            return (tostring(description) .. "\n") .. self.stack
        end
    end
end
function __TS__InitErrorClass(self, Type, name)
    Type.name = name
    return setmetatable(
        Type,
        {
            __call = function(____, _self, message) return __TS__New(Type, message) end
        }
    )
end
Error = __TS__InitErrorClass(
    _G,
    (function()
        local ____ = __TS__Class()
        ____.name = ""
        function ____.prototype.____constructor(self, message)
            if message == nil then
                message = ""
            end
            self.message = message
            self.name = "Error"
            self.stack = __TS__GetErrorStack(_G, self.constructor.new)
            local metatable = getmetatable(self)
            if not metatable.__errorToStringPatched then
                metatable.__errorToStringPatched = true
                metatable.__tostring = __TS__WrapErrorToString(_G, metatable.__tostring)
            end
        end
        function ____.prototype.__tostring(self)
            return (((self.message ~= "") and (function() return (self.name .. ": ") .. self.message end)) or (function() return self.name end))()
        end
        return ____
    end)(),
    "Error"
)
for ____, errorName in ipairs({"RangeError", "ReferenceError", "SyntaxError", "TypeError", "URIError"}) do
    _G[errorName] = __TS__InitErrorClass(
        _G,
        (function()
            local ____ = __TS__Class()
            ____.name = ____.name
            __TS__ClassExtends(____, Error)
            function ____.prototype.____constructor(self, ...)
                Error.prototype.____constructor(self, ...)
                self.name = errorName
            end
            return ____
        end)(),
        errorName
    )
end

__TS__Unpack = table.unpack or unpack

function __TS__FunctionBind(fn, thisArg, ...)
    local boundArgs = {...}
    return function(____, ...)
        local args = {...}
        do
            local i = 0
            while i < #boundArgs do
                table.insert(args, i + 1, boundArgs[i + 1])
                i = i + 1
            end
        end
        return fn(
            thisArg,
            __TS__Unpack(args)
        )
    end
end

____symbolMetatable = {
    __tostring = function(self)
        return ("Symbol(" .. (self.description or "")) .. ")"
    end
}
function __TS__Symbol(description)
    return setmetatable({description = description}, ____symbolMetatable)
end
Symbol = {
    iterator = __TS__Symbol("Symbol.iterator"),
    hasInstance = __TS__Symbol("Symbol.hasInstance"),
    species = __TS__Symbol("Symbol.species"),
    toStringTag = __TS__Symbol("Symbol.toStringTag")
}

function __TS__GeneratorIterator(self)
    return self
end
function __TS__GeneratorNext(self, ...)
    local co = self.____coroutine
    if coroutine.status(co) == "dead" then
        return {done = true}
    end
    local status, value = coroutine.resume(co, ...)
    if not status then
        error(value, 0)
    end
    return {
        value = value,
        done = coroutine.status(co) == "dead"
    }
end
function __TS__Generator(fn)
    return function(...)
        local args = {...}
        local argsLength = select("#", ...)
        return {
            ____coroutine = coroutine.create(
                function() return fn(
                    (unpack or table.unpack)(args, 1, argsLength)
                ) end
            ),
            [Symbol.iterator] = __TS__GeneratorIterator,
            next = __TS__GeneratorNext
        }
    end
end

function __TS__InstanceOf(obj, classTbl)
    if type(classTbl) ~= "table" then
        error("Right-hand side of 'instanceof' is not an object", 0)
    end
    if classTbl[Symbol.hasInstance] ~= nil then
        return not (not classTbl[Symbol.hasInstance](classTbl, obj))
    end
    if type(obj) == "table" then
        local luaClass = obj.constructor
        while luaClass ~= nil do
            if luaClass == classTbl then
                return true
            end
            luaClass = luaClass.____super
        end
    end
    return false
end

function __TS__InstanceOfObject(value)
    local valueType = type(value)
    return (valueType == "table") or (valueType == "function")
end

function __TS__IteratorGeneratorStep(self)
    local co = self.____coroutine
    local status, value = coroutine.resume(co)
    if not status then
        error(value, 0)
    end
    if coroutine.status(co) == "dead" then
        return
    end
    return true, value
end
function __TS__IteratorIteratorStep(self)
    local result = self:next()
    if result.done then
        return
    end
    return true, result.value
end
function __TS__IteratorStringStep(self, index)
    index = index + 1
    if index > #self then
        return
    end
    return index, string.sub(self, index, index)
end
function __TS__Iterator(iterable)
    if type(iterable) == "string" then
        return __TS__IteratorStringStep, iterable, 0
    elseif iterable.____coroutine ~= nil then
        return __TS__IteratorGeneratorStep, iterable
    elseif iterable[Symbol.iterator] then
        local iterator = iterable[Symbol.iterator](iterable)
        return __TS__IteratorIteratorStep, iterator
    else
        return __TS__Unpack(
            {
                ipairs(iterable)
            }
        )
    end
end

Map = (function()
    local Map = __TS__Class()
    Map.name = "Map"
    function Map.prototype.____constructor(self, entries)
        self[Symbol.toStringTag] = "Map"
        self.items = {}
        self.size = 0
        self.nextKey = {}
        self.previousKey = {}
        if entries == nil then
            return
        end
        local iterable = entries
        if iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            while true do
                local result = iterator:next()
                if result.done then
                    break
                end
                local value = result.value
                self:set(value[1], value[2])
            end
        else
            local array = entries
            for ____, kvp in ipairs(array) do
                self:set(kvp[1], kvp[2])
            end
        end
    end
    function Map.prototype.clear(self)
        self.items = {}
        self.nextKey = {}
        self.previousKey = {}
        self.firstKey = nil
        self.lastKey = nil
        self.size = 0
    end
    function Map.prototype.delete(self, key)
        local contains = self:has(key)
        if contains then
            self.size = self.size - 1
            local next = self.nextKey[key]
            local previous = self.previousKey[key]
            if next and previous then
                self.nextKey[previous] = next
                self.previousKey[next] = previous
            elseif next then
                self.firstKey = next
                self.previousKey[next] = nil
            elseif previous then
                self.lastKey = previous
                self.nextKey[previous] = nil
            else
                self.firstKey = nil
                self.lastKey = nil
            end
            self.nextKey[key] = nil
            self.previousKey[key] = nil
        end
        self.items[key] = nil
        return contains
    end
    function Map.prototype.forEach(self, callback)
        for ____, key in __TS__Iterator(
            self:keys()
        ) do
            callback(_G, self.items[key], key, self)
        end
    end
    function Map.prototype.get(self, key)
        return self.items[key]
    end
    function Map.prototype.has(self, key)
        return (self.nextKey[key] ~= nil) or (self.lastKey == key)
    end
    function Map.prototype.set(self, key, value)
        local isNewValue = not self:has(key)
        if isNewValue then
            self.size = self.size + 1
        end
        self.items[key] = value
        if self.firstKey == nil then
            self.firstKey = key
            self.lastKey = key
        elseif isNewValue then
            self.nextKey[self.lastKey] = key
            self.previousKey[key] = self.lastKey
            self.lastKey = key
        end
        return self
    end
    Map.prototype[Symbol.iterator] = function(self)
        return self:entries()
    end
    function Map.prototype.entries(self)
        local ____ = self
        local items = ____.items
        local nextKey = ____.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = {key, items[key]}}
                key = nextKey[key]
                return result
            end
        }
    end
    function Map.prototype.keys(self)
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = key}
                key = nextKey[key]
                return result
            end
        }
    end
    function Map.prototype.values(self)
        local ____ = self
        local items = ____.items
        local nextKey = ____.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = items[key]}
                key = nextKey[key]
                return result
            end
        }
    end
    Map[Symbol.species] = Map
    return Map
end)()

__TS__MathAtan2 = math.atan2 or math.atan

function __TS__Number(value)
    local valueType = type(value)
    if valueType == "number" then
        return value
    elseif valueType == "string" then
        local numberValue = tonumber(value)
        if numberValue then
            return numberValue
        end
        if value == "Infinity" then
            return math.huge
        end
        if value == "-Infinity" then
            return -math.huge
        end
        local stringWithoutSpaces = string.gsub(value, "%s", "")
        if stringWithoutSpaces == "" then
            return 0
        end
        return 0 / 0
    elseif valueType == "boolean" then
        return (value and 1) or 0
    else
        return 0 / 0
    end
end

function __TS__NumberIsFinite(value)
    return (((type(value) == "number") and (value == value)) and (value ~= math.huge)) and (value ~= -math.huge)
end

function __TS__NumberIsNaN(value)
    return value ~= value
end

____radixChars = "0123456789abcdefghijklmnopqrstuvwxyz"
function __TS__NumberToString(self, radix)
    if ((((radix == nil) or (radix == 10)) or (self == math.huge)) or (self == -math.huge)) or (self ~= self) then
        return tostring(self)
    end
    radix = math.floor(radix)
    if (radix < 2) or (radix > 36) then
        error("toString() radix argument must be between 2 and 36", 0)
    end
    local integer, fraction = math.modf(
        math.abs(self)
    )
    local result = ""
    if radix == 8 then
        result = string.format("%o", integer)
    elseif radix == 16 then
        result = string.format("%x", integer)
    else
        repeat
            do
                result = tostring(
                    __TS__StringAccess(____radixChars, integer % radix)
                ) .. tostring(result)
                integer = math.floor(integer / radix)
            end
        until not (integer ~= 0)
    end
    if fraction ~= 0 then
        result = tostring(result) .. "."
        local delta = 1e-16
        repeat
            do
                fraction = fraction * radix
                delta = delta * radix
                local digit = math.floor(fraction)
                result = tostring(result) .. tostring(
                    __TS__StringAccess(____radixChars, digit)
                )
                fraction = fraction - digit
            end
        until not (fraction >= delta)
    end
    if self < 0 then
        result = "-" .. tostring(result)
    end
    return result
end

function __TS__ObjectAssign(to, ...)
    local sources = {...}
    if to == nil then
        return to
    end
    for ____, source in ipairs(sources) do
        for key in pairs(source) do
            to[key] = source[key]
        end
    end
    return to
end

function ____descriptorIndex(self, key)
    local value = rawget(self, key)
    if value ~= nil then
        return value
    end
    local metatable = getmetatable(self)
    while metatable do
        local rawResult = rawget(metatable, key)
        if rawResult ~= nil then
            return rawResult
        end
        local descriptors = rawget(metatable, "_descriptors")
        if descriptors then
            local descriptor = descriptors[key]
            if descriptor then
                if descriptor.get then
                    return descriptor.get(self)
                end
                return descriptor.value
            end
        end
        metatable = getmetatable(metatable)
    end
end
function ____descriptorNewindex(self, key, value)
    local metatable = getmetatable(self)
    while metatable do
        local descriptors = rawget(metatable, "_descriptors")
        if descriptors then
            local descriptor = descriptors[key]
            if descriptor then
                if descriptor.set then
                    descriptor.set(self, value)
                else
                    if descriptor.writable == false then
                        error(
                            ((("Cannot assign to read only property '" .. key) .. "' of object '") .. tostring(self)) .. "'",
                            0
                        )
                    end
                    descriptor.value = value
                end
                return
            end
        end
        metatable = getmetatable(metatable)
    end
    rawset(self, key, value)
end
function __TS__SetDescriptor(target, key, desc, isPrototype)
    if isPrototype == nil then
        isPrototype = false
    end
    local metatable = ((isPrototype and (function() return target end)) or (function() return getmetatable(target) end))()
    if not metatable then
        metatable = {}
        setmetatable(target, metatable)
    end
    local value = rawget(target, key)
    if value ~= nil then
        rawset(target, key, nil)
    end
    if not rawget(metatable, "_descriptors") then
        metatable._descriptors = {}
    end
    local descriptor = __TS__CloneDescriptor(desc)
    metatable._descriptors[key] = descriptor
    metatable.__index = ____descriptorIndex
    metatable.__newindex = ____descriptorNewindex
end

function __TS__ObjectDefineProperty(target, key, desc)
    local luaKey = (((type(key) == "number") and (function() return key + 1 end)) or (function() return key end))()
    local value = rawget(target, luaKey)
    local hasGetterOrSetter = (desc.get ~= nil) or (desc.set ~= nil)
    local descriptor
    if hasGetterOrSetter then
        if value ~= nil then
            error(
                "Cannot redefine property: " .. tostring(key),
                0
            )
        end
        descriptor = desc
    else
        local valueExists = value ~= nil
        descriptor = {
            set = desc.set,
            get = desc.get,
            configurable = (((desc.configurable ~= nil) and (function() return desc.configurable end)) or (function() return valueExists end))(),
            enumerable = (((desc.enumerable ~= nil) and (function() return desc.enumerable end)) or (function() return valueExists end))(),
            writable = (((desc.writable ~= nil) and (function() return desc.writable end)) or (function() return valueExists end))(),
            value = (((desc.value ~= nil) and (function() return desc.value end)) or (function() return value end))()
        }
    end
    __TS__SetDescriptor(target, luaKey, descriptor)
    return target
end

function __TS__ObjectEntries(obj)
    local result = {}
    for key in pairs(obj) do
        result[#result + 1] = {key, obj[key]}
    end
    return result
end

function __TS__ObjectFromEntries(entries)
    local obj = {}
    local iterable = entries
    if iterable[Symbol.iterator] then
        local iterator = iterable[Symbol.iterator](iterable)
        while true do
            local result = iterator:next()
            if result.done then
                break
            end
            local value = result.value
            obj[value[1]] = value[2]
        end
    else
        for ____, entry in ipairs(entries) do
            obj[entry[1]] = entry[2]
        end
    end
    return obj
end

function __TS__ObjectGetOwnPropertyDescriptor(object, key)
    local metatable = getmetatable(object)
    if not metatable then
        return
    end
    if not rawget(metatable, "_descriptors") then
        return
    end
    return rawget(metatable, "_descriptors")[key]
end

function __TS__ObjectKeys(obj)
    local result = {}
    for key in pairs(obj) do
        result[#result + 1] = key
    end
    return result
end

function __TS__ObjectRest(target, usedProperties)
    local result = {}
    for property in pairs(target) do
        if not usedProperties[property] then
            result[property] = target[property]
        end
    end
    return result
end

function __TS__ObjectValues(obj)
    local result = {}
    for key in pairs(obj) do
        result[#result + 1] = obj[key]
    end
    return result
end

function __TS__ParseFloat(numberString)
    local infinityMatch = string.match(numberString, "^%s*(-?Infinity)")
    if infinityMatch then
        return (((__TS__StringAccess(infinityMatch, 0) == "-") and (function() return -math.huge end)) or (function() return math.huge end))()
    end
    local number = tonumber(
        string.match(numberString, "^%s*(-?%d+%.?%d*)")
    )
    return number or (0 / 0)
end

__TS__parseInt_base_pattern = "0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTvVwWxXyYzZ"
function __TS__ParseInt(numberString, base)
    if base == nil then
        base = 10
        local hexMatch = string.match(numberString, "^%s*-?0[xX]")
        if hexMatch then
            base = 16
            numberString = ((string.match(hexMatch, "-") and (function() return "-" .. tostring(
                __TS__StringSubstr(numberString, #hexMatch)
            ) end)) or (function() return __TS__StringSubstr(numberString, #hexMatch) end))()
        end
    end
    if (base < 2) or (base > 36) then
        return 0 / 0
    end
    local allowedDigits = (((base <= 10) and (function() return __TS__StringSubstring(__TS__parseInt_base_pattern, 0, base) end)) or (function() return __TS__StringSubstr(__TS__parseInt_base_pattern, 0, 10 + (2 * (base - 10))) end))()
    local pattern = ("^%s*(-?[" .. allowedDigits) .. "]*)"
    local number = tonumber(
        string.match(numberString, pattern),
        base
    )
    if number == nil then
        return 0 / 0
    end
    if number >= 0 then
        return math.floor(number)
    else
        return math.ceil(number)
    end
end

Set = (function()
    local Set = __TS__Class()
    Set.name = "Set"
    function Set.prototype.____constructor(self, values)
        self[Symbol.toStringTag] = "Set"
        self.size = 0
        self.nextKey = {}
        self.previousKey = {}
        if values == nil then
            return
        end
        local iterable = values
        if iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            while true do
                local result = iterator:next()
                if result.done then
                    break
                end
                self:add(result.value)
            end
        else
            local array = values
            for ____, value in ipairs(array) do
                self:add(value)
            end
        end
    end
    function Set.prototype.add(self, value)
        local isNewValue = not self:has(value)
        if isNewValue then
            self.size = self.size + 1
        end
        if self.firstKey == nil then
            self.firstKey = value
            self.lastKey = value
        elseif isNewValue then
            self.nextKey[self.lastKey] = value
            self.previousKey[value] = self.lastKey
            self.lastKey = value
        end
        return self
    end
    function Set.prototype.clear(self)
        self.nextKey = {}
        self.previousKey = {}
        self.firstKey = nil
        self.lastKey = nil
        self.size = 0
    end
    function Set.prototype.delete(self, value)
        local contains = self:has(value)
        if contains then
            self.size = self.size - 1
            local next = self.nextKey[value]
            local previous = self.previousKey[value]
            if next and previous then
                self.nextKey[previous] = next
                self.previousKey[next] = previous
            elseif next then
                self.firstKey = next
                self.previousKey[next] = nil
            elseif previous then
                self.lastKey = previous
                self.nextKey[previous] = nil
            else
                self.firstKey = nil
                self.lastKey = nil
            end
            self.nextKey[value] = nil
            self.previousKey[value] = nil
        end
        return contains
    end
    function Set.prototype.forEach(self, callback)
        for ____, key in __TS__Iterator(
            self:keys()
        ) do
            callback(_G, key, key, self)
        end
    end
    function Set.prototype.has(self, value)
        return (self.nextKey[value] ~= nil) or (self.lastKey == value)
    end
    Set.prototype[Symbol.iterator] = function(self)
        return self:values()
    end
    function Set.prototype.entries(self)
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = {key, key}}
                key = nextKey[key]
                return result
            end
        }
    end
    function Set.prototype.keys(self)
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = key}
                key = nextKey[key]
                return result
            end
        }
    end
    function Set.prototype.values(self)
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = key}
                key = nextKey[key]
                return result
            end
        }
    end
    Set[Symbol.species] = Set
    return Set
end)()

WeakMap = (function()
    local WeakMap = __TS__Class()
    WeakMap.name = "WeakMap"
    function WeakMap.prototype.____constructor(self, entries)
        self[Symbol.toStringTag] = "WeakMap"
        self.items = {}
        setmetatable(self.items, {__mode = "k"})
        if entries == nil then
            return
        end
        local iterable = entries
        if iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            while true do
                local result = iterator:next()
                if result.done then
                    break
                end
                local value = result.value
                self.items[value[1]] = value[2]
            end
        else
            for ____, kvp in ipairs(entries) do
                self.items[kvp[1]] = kvp[2]
            end
        end
    end
    function WeakMap.prototype.delete(self, key)
        local contains = self:has(key)
        self.items[key] = nil
        return contains
    end
    function WeakMap.prototype.get(self, key)
        return self.items[key]
    end
    function WeakMap.prototype.has(self, key)
        return self.items[key] ~= nil
    end
    function WeakMap.prototype.set(self, key, value)
        self.items[key] = value
        return self
    end
    WeakMap[Symbol.species] = WeakMap
    return WeakMap
end)()

WeakSet = (function()
    local WeakSet = __TS__Class()
    WeakSet.name = "WeakSet"
    function WeakSet.prototype.____constructor(self, values)
        self[Symbol.toStringTag] = "WeakSet"
        self.items = {}
        setmetatable(self.items, {__mode = "k"})
        if values == nil then
            return
        end
        local iterable = values
        if iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            while true do
                local result = iterator:next()
                if result.done then
                    break
                end
                self.items[result.value] = true
            end
        else
            for ____, value in ipairs(values) do
                self.items[value] = true
            end
        end
    end
    function WeakSet.prototype.add(self, value)
        self.items[value] = true
        return self
    end
    function WeakSet.prototype.delete(self, value)
        local contains = self:has(value)
        self.items[value] = nil
        return contains
    end
    function WeakSet.prototype.has(self, value)
        return self.items[value] == true
    end
    WeakSet[Symbol.species] = WeakSet
    return WeakSet
end)()

function __TS__SourceMapTraceBack(fileName, sourceMap)
    _G.__TS__sourcemap = _G.__TS__sourcemap or ({})
    _G.__TS__sourcemap[fileName] = sourceMap
    if _G.__TS__originalTraceback == nil then
        _G.__TS__originalTraceback = debug.traceback
        debug.traceback = function(thread, message, level)
            local trace
            if ((thread == nil) and (message == nil)) and (level == nil) then
                trace = _G.__TS__originalTraceback()
            else
                trace = _G.__TS__originalTraceback(thread, message, level)
            end
            if type(trace) ~= "string" then
                return trace
            end
            local result = string.gsub(
                trace,
                "(%S+).lua:(%d+)",
                function(file, line)
                    local fileSourceMap = _G.__TS__sourcemap[tostring(file) .. ".lua"]
                    if fileSourceMap and fileSourceMap[line] then
                        return (file .. ".ts:") .. tostring(fileSourceMap[line])
                    end
                    return (file .. ".lua:") .. line
                end
            )
            return result
        end
    end
end

function __TS__Spread(iterable)
    local arr = {}
    if type(iterable) == "string" then
        do
            local i = 0
            while i < #iterable do
                arr[#arr + 1] = __TS__StringAccess(iterable, i)
                i = i + 1
            end
        end
    else
        for ____, item in __TS__Iterator(iterable) do
            arr[#arr + 1] = item
        end
    end
    return __TS__Unpack(arr)
end

function __TS__StringAccess(self, index)
    if (index >= 0) and (index < #self) then
        return string.sub(self, index + 1, index + 1)
    end
end

function __TS__StringCharAt(self, pos)
    if pos ~= pos then
        pos = 0
    end
    if pos < 0 then
        return ""
    end
    return string.sub(self, pos + 1, pos + 1)
end

function __TS__StringCharCodeAt(self, index)
    if index ~= index then
        index = 0
    end
    if index < 0 then
        return 0 / 0
    end
    return string.byte(self, index + 1) or (0 / 0)
end

function __TS__StringConcat(str1, ...)
    local args = {...}
    local out = str1
    for ____, arg in ipairs(args) do
        out = tostring(out) .. tostring(arg)
    end
    return out
end

function __TS__StringEndsWith(self, searchString, endPosition)
    if (endPosition == nil) or (endPosition > #self) then
        endPosition = #self
    end
    return string.sub(self, (endPosition - #searchString) + 1, endPosition) == searchString
end

function __TS__StringIncludes(self, searchString, position)
    if not position then
        position = 1
    else
        position = position + 1
    end
    local index = string.find(self, searchString, position, true)
    return index ~= nil
end

function __TS__StringPadEnd(self, maxLength, fillString)
    if fillString == nil then
        fillString = " "
    end
    if maxLength ~= maxLength then
        maxLength = 0
    end
    if (maxLength == -math.huge) or (maxLength == math.huge) then
        error("Invalid string length", 0)
    end
    if (#self >= maxLength) or (#fillString == 0) then
        return self
    end
    maxLength = maxLength - #self
    if maxLength > #fillString then
        fillString = tostring(fillString) .. tostring(
            string.rep(
                fillString,
                math.floor(maxLength / #fillString)
            )
        )
    end
    return tostring(self) .. tostring(
        string.sub(
            fillString,
            1,
            math.floor(maxLength)
        )
    )
end

function __TS__StringPadStart(self, maxLength, fillString)
    if fillString == nil then
        fillString = " "
    end
    if maxLength ~= maxLength then
        maxLength = 0
    end
    if (maxLength == -math.huge) or (maxLength == math.huge) then
        error("Invalid string length", 0)
    end
    if (#self >= maxLength) or (#fillString == 0) then
        return self
    end
    maxLength = maxLength - #self
    if maxLength > #fillString then
        fillString = tostring(fillString) .. tostring(
            string.rep(
                fillString,
                math.floor(maxLength / #fillString)
            )
        )
    end
    return tostring(
        string.sub(
            fillString,
            1,
            math.floor(maxLength)
        )
    ) .. tostring(self)
end

function __TS__StringReplace(source, searchValue, replaceValue)
    searchValue = string.gsub(searchValue, "[%%%(%)%.%+%-%*%?%[%^%$]", "%%%1")
    if type(replaceValue) == "string" then
        replaceValue = string.gsub(replaceValue, "%%", "%%%%")
        local result = string.gsub(source, searchValue, replaceValue, 1)
        return result
    else
        local result = string.gsub(
            source,
            searchValue,
            function(match) return replaceValue(_G, match) end,
            1
        )
        return result
    end
end

function __TS__StringSlice(self, start, ____end)
    if (start == nil) or (start ~= start) then
        start = 0
    end
    if ____end ~= ____end then
        ____end = 0
    end
    if start >= 0 then
        start = start + 1
    end
    if (____end ~= nil) and (____end < 0) then
        ____end = ____end - 1
    end
    return string.sub(self, start, ____end)
end

function __TS__StringSubstring(self, start, ____end)
    if ____end ~= ____end then
        ____end = 0
    end
    if (____end ~= nil) and (start > ____end) then
        start, ____end = __TS__Unpack({____end, start})
    end
    if start >= 0 then
        start = start + 1
    else
        start = 1
    end
    if (____end ~= nil) and (____end < 0) then
        ____end = 0
    end
    return string.sub(self, start, ____end)
end

function __TS__StringSplit(source, separator, limit)
    if limit == nil then
        limit = 4294967295
    end
    if limit == 0 then
        return {}
    end
    local out = {}
    local index = 0
    local count = 0
    if (separator == nil) or (separator == "") then
        while (index < (#source - 1)) and (count < limit) do
            out[count + 1] = __TS__StringAccess(source, index)
            count = count + 1
            index = index + 1
        end
    else
        local separatorLength = #separator
        local nextIndex = (string.find(source, separator, nil, true) or 0) - 1
        while (nextIndex >= 0) and (count < limit) do
            out[count + 1] = __TS__StringSubstring(source, index, nextIndex)
            count = count + 1
            index = nextIndex + separatorLength
            nextIndex = (string.find(
                source,
                separator,
                math.max(index + 1, 1),
                true
            ) or 0) - 1
        end
    end
    if count < limit then
        out[count + 1] = __TS__StringSubstring(source, index)
    end
    return out
end

function __TS__StringStartsWith(self, searchString, position)
    if (position == nil) or (position < 0) then
        position = 0
    end
    return string.sub(self, position + 1, #searchString + position) == searchString
end

function __TS__StringSubstr(self, from, length)
    if from ~= from then
        from = 0
    end
    if length ~= nil then
        if (length ~= length) or (length <= 0) then
            return ""
        end
        length = length + from
    end
    if from >= 0 then
        from = from + 1
    end
    return string.sub(self, from, length)
end

function __TS__StringTrim(self)
    local result = string.gsub(self, "^[%s ﻿]*(.-)[%s ﻿]*$", "%1")
    return result
end

function __TS__StringTrimEnd(self)
    local result = string.gsub(self, "[%s ﻿]*$", "")
    return result
end

function __TS__StringTrimStart(self)
    local result = string.gsub(self, "^[%s ﻿]*", "")
    return result
end

____symbolRegistry = {}
function __TS__SymbolRegistryFor(key)
    if not ____symbolRegistry[key] then
        ____symbolRegistry[key] = __TS__Symbol(key)
    end
    return ____symbolRegistry[key]
end
function __TS__SymbolRegistryKeyFor(sym)
    for key in pairs(____symbolRegistry) do
        if ____symbolRegistry[key] == sym then
            return key
        end
    end
end

function __TS__TypeOf(value)
    local luaType = type(value)
    if luaType == "table" then
        return "object"
    elseif luaType == "nil" then
        return "undefined"
    else
        return luaType
    end
end

end,
[".src.MathShortcuts"] = function() local ____exports = {}
local Tau = 2 * math.pi
local function abs(n)
    return math.abs(n)
end
local function floor(n)
    return math.floor(n)
end
local function sqrt(n)
    return math.sqrt(n)
end
local function cos(n)
    return math.cos(n)
end
local function sin(n)
    return math.sin(n)
end
local function pow(n, e)
    return math.pow(n, e)
end
local function log(n)
    return math.log(n)
end
local function max(...)
    return math.max(...)
end
local function min(...)
    return math.min(...)
end
local function round(n)
    return math.floor(n + 0.5)
end
local function clamp(n, min, max)
    return ((n < min) and min) or (((n > max) and max) or n)
end
____exports.abs = abs
____exports.floor = floor
____exports.sqrt = sqrt
____exports.cos = cos
____exports.sin = sin
____exports.pow = pow
____exports.log = log
____exports.round = round
____exports.clamp = clamp
____exports.min = min
____exports.max = max
____exports.Tau = Tau
return ____exports
end,
[".src.Color"] = function() local ____exports = {}
local ____MathShortcuts = require("src.MathShortcuts")
local clamp = ____MathShortcuts.clamp
local pow = ____MathShortcuts.pow
local log = ____MathShortcuts.log
local min = ____MathShortcuts.min
local max = ____MathShortcuts.max
local round = ____MathShortcuts.round
local OneThird = 1 / 3
local TwoThird = 2 / 3
local OneSixth = 1 / 6
local function normBit(n)
    return round(n * 255)
end
local function fromTemperature(k)
    k = clamp(k, 1000, 40000) / 100
    return {
        r = ((k <= 66) and 255) or clamp(
            329.698727446 * pow(k - 60, -0.1332047592),
            0,
            255
        ),
        g = ((k <= 66) and clamp(
            (99.4708025861 * log(k)) - 161.1195681661,
            0,
            255
        )) or clamp(
            288.1221695283 * pow(k - 60, -0.0755148492),
            0,
            255
        ),
        b = ((k >= 66) and 255) or (((k <= 19) and 0) or clamp(
            (138.5177312231 * log(k - 10)) - 305.0447927307,
            0,
            255
        ))
    }
end
local function rgb2hsl(...)
    local x = {...}
    local r
    local g
    local b
    if type(x) == "table" then
        r = x.r
        g = x.g
        b = x.b
    else
        r = x[0]
        g = x[1]
        b = x[2]
    end
    r = r / 255
    g = g / 255
    b = b / 255
    local maxc = max(r, g, b)
    local minc = min(r, g, b)
    local l = (minc + maxc) / 2
    if minc == maxc then
        return {h = 0, s = 0, l = l}
    end
    local s = ((l <= 0.5) and ((maxc - minc) / (maxc + minc))) or ((maxc - minc) / ((2 - maxc) - minc))
    local rc = (maxc - r) / (maxc - minc)
    local gc = (maxc - g) / (maxc - minc)
    local bc = (maxc - b) / (maxc - minc)
    local h = ((r == maxc) and (bc - gc)) or (((g == maxc) and ((2 + rc) - bc)) or ((4 + gc) - rc))
    h = (h / 6) % 1
    return {
        h = normBit(h),
        s = normBit(s),
        l = normBit(l)
    }
end
local function hsl2rgb(...)
    local x = {...}
    local h
    local s
    local l
    if type(x) == "table" then
        h = x.h
        s = x.s
        l = x.l
    else
        h = x[0]
        s = x[1]
        l = x[2]
    end
    local function v(m1, m2, h)
        h = h % 1
        return ((h < OneSixth) and (m1 + (((m2 - m1) * h) * 6))) or (((h < 0.5) and m2) or (((h < TwoThird) and (m1 + (((m2 - m1) * (TwoThird - h)) * 6))) or m1))
    end
    if s == 0 then
        return {r = l, g = l, b = l}
    end
    local m2 = ((l <= 0.5) and (l * (1 + s))) or ((l + s) - (l * s))
    local m1 = (2 * l) - m2
    local r = v(m1, m2, h + OneThird)
    local g = v(m1, m2, h)
    local b = v(m1, m2, h - OneThird)
    return {
        r = normBit(r),
        g = normBit(g),
        b = normBit(b)
    }
end
____exports.rgb2hsl = rgb2hsl
____exports.hsl2rgb = hsl2rgb
____exports.fromTemperature = fromTemperature
return ____exports
end,
[".src.Utility"] = function() require("lualib_bundle");
local ____exports = {}
local function sum(ls)
    return __TS__ArrayReduce(
        ls,
        function(____, a, b) return a + b end,
        0
    )
end
local function range(start, stop, step)
    if step == nil then
        step = 1
    end
    step = (((start > stop) and (step > 0)) and (function()
        step = step * -1
        return step
    end)()) or step
    if ((step > 0) and (start >= stop)) or ((step < 0) and (start <= stop)) then
        return {}
    end
    local result = {}
    do
        local i = start
        while (((step > 0) and (function() return i < stop end)) or (function() return i > stop end))() do
            __TS__ArrayPush(result, i)
            i = i + step
        end
    end
    return result
end
local function rangeInclusive(start, stop, step)
    if step == nil then
        step = 1
    end
    step = (((start > stop) and (step > 0)) and (function()
        step = step * -1
        return step
    end)()) or step
    if ((step > 0) and (start >= stop)) or ((step < 0) and (start <= stop)) then
        return {}
    end
    local result = {}
    do
        local i = start
        while (((step > 0) and (function() return i <= stop end)) or (function() return i >= stop end))() do
            __TS__ArrayPush(result, i)
            i = i + step
        end
    end
    return result
end
____exports.sum = sum
____exports.range = range
____exports.rangeInclusive = rangeInclusive
return ____exports
end,
[".src.Dither"] = function() local ____exports = {}
local Sixteenth = 1 / 16
local ThreeSixteenths = 3 * Sixteenth
local FiveSixteenths = 5 * Sixteenth
local SevenSixteenths = 7 * Sixteenth
local FsMatrix = {{0, 0, SevenSixteenths}, {ThreeSixteenths, FiveSixteenths, Sixteenth}}
return ____exports
end,
[".src.Point"] = function() local ____exports = {}
local function init(x, y)
    return {x = x, y = y}
end
____exports.init = init
return ____exports
end,
[".src.Size"] = function() local ____exports = {}
local function init(w, h)
    return {xDimension = w, yDimension = h}
end
____exports.init = init
return ____exports
end,
[".src.Orientation"] = function() local ____exports = {}
local ____MathShortcuts = require("src.MathShortcuts")
local sqrt = ____MathShortcuts.sqrt
local pointy = {
    forward = {
        sqrt(3),
        sqrt(3) / 2,
        0,
        3 / 2
    },
    backward = {
        sqrt(3) / 3,
        -1 / 3,
        0,
        2 / 3
    },
    startingAngle = 0.5
}
local flat = {
    forward = {
        3 / 2,
        0,
        sqrt(3) / 2,
        sqrt(3)
    },
    backward = {
        2 / 3,
        0,
        -1 / 3,
        sqrt(3) / 3
    },
    startingAngle = 0
}
____exports.pointy = pointy
____exports.flat = flat
return ____exports
end,
[".src.Layout"] = function() local ____exports = {}
local function init(r, s, o)
    return {orientation = r, size = s, origin = o}
end
____exports.init = init
return ____exports
end,
[".src.Hex"] = function() require("lualib_bundle");
local ____exports = {}
local ____MathShortcuts = require("src.MathShortcuts")
local floor = ____MathShortcuts.floor
local abs = ____MathShortcuts.abs
local Tau = ____MathShortcuts.Tau
local cos = ____MathShortcuts.cos
local sin = ____MathShortcuts.sin
local max = ____MathShortcuts.max
local Utility = require("src.Utility")
local Point = require("src.Point")
local function init(q, r, s)
    if ((q + r) + s) ~= 0 then
        return {q = 0, r = 0, s = 0}
    end
    return {q = q, r = r, s = s}
end
local base = init(0, 0, 0)
local faces = {
    topRight = init(1, 0, -1),
    centerRight = init(1, -1, 0),
    bottomRight = init(0, -1, 1),
    bottomLeft = init(-1, 0, 1),
    centerLeft = init(-1, 1, 0),
    topLeft = init(0, 1, -1)
}
local vertices = {
    topRight = init(2, -1, -1),
    bottomRight = init(1, -2, 1),
    bottom = init(-1, -1, 2),
    bottomLeft = init(-2, 1, 1),
    topLeft = init(-1, 2, -1),
    top = init(1, 1, -2)
}
local function fromAxial(q, r)
    return init(q, r, -q - r)
end
local function fromVector(v)
    local q, r, s = unpack(v)
    return init(q, r, s)
end
local function add(a, b)
    return init(a.q + b.q, a.r + b.r, a.s + b.s)
end
local function scale(h, n)
    return init(h.q * n, h.r * n, h.s * n)
end
local function invert(h)
    return init(-h.q, -h.r, -h.s)
end
local function subtract(a, b)
    return add(
        a,
        invert(b)
    )
end
local function equal(a, b)
    return ((a.q == b.q) and (a.r == b.r)) and (a.s == b.s)
end
local function rotateRight(h)
    return init(-h.r, -h.s, -h.q)
end
local function rotateLeft(h)
    return init(-h.s, -h.q, -h.r)
end
local function length(h)
    return floor(
        Utility.sum(
            __TS__ArrayMap(
                {h.q, h.r, h.s},
                function(____, x) return abs(x) end
            )
        )
    ) / 2
end
local function distance(a, b)
    return length(
        subtract(a, b)
    )
end
local function round(h)
    local q = math.floor(h.q + 0.5)
    local r = math.floor(h.r + 0.5)
    local s = math.floor(h.s + 0.5)
    local deltaQ = abs(q - h.q)
    local deltaR = abs(r - h.r)
    local deltaS = abs(s - h.s)
    if (deltaQ > deltaR) and (deltaS > deltaS) then
        q = -r - s
    elseif deltaR > deltaS then
        r = -q - s
    else
        s = -q - r
    end
    return init(q, r, s)
end
local function hexToPixel(layout, h)
    local m = layout.orientation
    local x = ((m.forward[1] * h.q) + (m.forward[2] * h.r)) * layout.size.xDimension
    local y = ((m.forward[3] * h.q) + (m.forward[4] * h.r)) * layout.size.yDimension
    return Point.init(x + layout.origin.x, y + layout.origin.y)
end
local function pixelToHex(layout, p)
    local m = layout.orientation
    local x = (p.x - layout.origin.x) / layout.size.xDimension
    local y = (p.y - layout.origin.y) / layout.size.yDimension
    local pt = Point.init(x, y)
    local q = (m.backward[1] * pt.x) + (m.backward[2] * pt.y)
    local r = (m.backward[3] * pt.x) + (m.backward[4] * pt.y)
    return fromAxial(q, r)
end
local function cornerOffset(layout, corner)
    local angle = (Tau * (layout.orientation.startingAngle - corner)) / 6
    local x = layout.size.xDimension * cos(angle)
    local y = layout.size.yDimension * sin(angle)
    return Point.init(x, y)
end
local function getCorners(layout, h)
    local center = hexToPixel(layout, h)
    return __TS__ArrayMap(
        Utility.range(0, 6),
        function(____, i)
            local offset = cornerOffset(layout, i)
            return Point.init(center.x + offset.x, center.y + offset.y)
        end
    )
end
local function lerp(a, b, t)
    return (a * (1 - t)) + (b * t)
end
local function hexLerp(a, b, t)
    local q = lerp(a.q, b.q, t)
    local r = lerp(a.r, b.r, t)
    local s = lerp(a.s, b.s, t)
    return init(q, r, s)
end
local function hexLineDraw(a, b)
    local n = distance(a, b)
    local aNudge = init(a.q + 0.000001, a.r + 0.000001, a.s - 0.000002)
    local bNudge = init(b.q + 0.000001, b.r + 0.000001, b.s - 0.000002)
    local step = 1 / max(n, 1)
    return __TS__ArrayMap(
        Utility.range(0, n),
        function(____, i) return round(
            hexLerp(aNudge, bNudge, step * i)
        ) end
    )
end
local function faceNeighbor(h, d)
    return add(h, faces[d])
end
local function vertexNeighbor(h, d)
    return add(h, vertices[d])
end
____exports.init = init
____exports.fromAxial = fromAxial
____exports.fromVector = fromVector
____exports.base = base
____exports.equal = equal
____exports.add = add
____exports.subtract = subtract
____exports.scale = scale
____exports.round = round
____exports.invert = invert
____exports.rotateLeft = rotateLeft
____exports.rotateRight = rotateRight
____exports.lerp = hexLerp
____exports.lineDraw = hexLineDraw
____exports.faces = faces
____exports.vertices = vertices
____exports.length = length
____exports.distance = distance
____exports.getNeighbor = faceNeighbor
____exports.getDiagonal = vertexNeighbor
____exports.toPixel = hexToPixel
____exports.fromPixel = pixelToHex
____exports.getCorners = getCorners
return ____exports
end,
[".src.ImageSize"] = function() local ____exports = {}
local ____MathShortcuts = require("src.MathShortcuts")
local floor = ____MathShortcuts.floor
local sqrt = ____MathShortcuts.sqrt
local presetImage, sizer
local Sizer = {caption = "TACKLEBOX - SIZER", label = {modify = "Modify (i)", scale = "Scale (i)", presets = "Presets (i)", squares = "Squares (i)", info = "Info", back = "Back"}, info = {caption = "SIZER - ABOUT", message = "Change image size easier.\n\nThis extends `Image > Set Image Size` by DB. Modify to quickly adjust image size smartly. Scale to simply scale the image size up or down (use built-in picture transform to adjust pixels). Presets extends DB's preset options. Squares extends DB's preset options."}, modify = {caption = "SIZER - MODIFY", label = {half = "Half Image Size", dblWidth = "Double Image Width", dblHeight = "Double Image Height", quad = "Double Image Height and Width", gold = "Snap Image to Golden Ratio"}}, scale = {caption = "SIZER - SCALE", label = {factor = "Size Factor"}}, squares = {caption = "SIZER - SQUARES", label = {sq114 = "114x114", sq128 = "128x128", sq192 = "192x192", sq256 = "256x256", sq512 = "512x512", sq768 = "768x768", sq814 = "814x814"}}, presets = {caption = "SIZER - PRESET RESOLUTIONS", label = {eight = "Eight Bit", nonStd = "Non Standard", ibmStd = "IBM Standard", conHh = "Console and Handheld", sprite = "Common Sprites"}, eight = {caption = "SIZER - PRESET - EIGHT BIT", label = {apple = "Apple Hi Res [280 x 192]", atariE = "Atari Mode E [192 x 192]", atariF = "Atari Mode F [384 x 192]", cWide = "Commodore 64 Wide [160 x 200]", cga = "CGA/Commodore 64 [320 x 200]", msx = "MSX [256 x 192]", msx2 = "MSX2 [512 x 212]", msx28 = "MSX2 Mode 8 [256 x 212]"}}, non = {caption = "SIZER - PRESET - NON STANDARD", label = {macMono = "Mac Mono [512 x 342]", macColor = "Mac Color [512 x 384]"}}, ibm = {caption = "SIZER - PRESET - IBM STANDARD", label = {cga6 = "CGA Mode 6 [640 x 200]", ega = "EGA [640 x 350]", vga = "VGA [640 x 480]", svga = "SVGA [800 x 600]", xga = "XGA [1024 x 768]"}}, con = {caption = "SIZER - PRESET - CONSOLES", label = {nes = "NES [256 x 240]", snes = "SNES [256 x 224]", gen = "Genesis [320 x 224]", gb = "GameBoy [160 x 144]", gba = "GameBoy Advanced [240 x 160]", ds = "DS [256 x 192]"}}, sprite = {caption = "SIZER - PRESET - SPRITES", label = {nesGb = "NES or GameBoy Sprite [8 x 8]", nesTall = "NES Tall Sprite [8 x 16]", snes = "SNES/GBA/DS Sprite [64 x 64]", gen = "Genesis Sprite [32 x 32]"}}}}
local function sizerInfo()
    messagebox(Sizer.info.caption, Sizer.info.message)
    local ____ = sizer
end
local function getGolden(w, h)
    local phi = (1 + sqrt(5)) / 2
    local max, min, hor = unpack(((h > w) and ({w, h, true})) or ({h, w, false}))
    local ratio = max / min
    local x = floor((phi * max) / ratio)
    return (hor and ({x, h})) or ({w, x})
end
local function scale(w, h, factor)
    return {w * factor, h * factor}
end
local function scaleImage()
    local w, h = getpicturesize()
    local maxWidth = floor(3000 / w)
    local maxHeight = floor(3000 / h)
    local max = ((maxWidth > maxHeight) and maxWidth) or maxHeight
    local ok, factor = inputbox(Sizer.scale.caption, Sizer.scale.label.factor, 2, 0, max, 2)
    local scaleW, scaleH = unpack(
        scale(w, h, factor)
    );
    ((ok and (function() return setpicturesize(scaleW, scaleH) end)) or (function() return sizer end))()
end
local function modifyImage()
    local w, h = getpicturesize()
    local goldW, goldH = unpack(
        getGolden(w, h)
    )
    local ok, half, dblX, dblY, quad, gold = inputbox(Sizer.modify.caption, Sizer.modify.label.half, 1, 1, 0, 0, Sizer.modify.label.dblWidth, 0, 1, 0, 0, Sizer.modify.label.dblHeight, 0, 1, 0, 0, Sizer.modify.label.quad, 0, 1, 0, 0, Sizer.modify.label.gold, 0, 1, 0, 0)
    local ws, hs = unpack(((half == 1) and ({w / 2, h / 2})) or (((dblX == 1) and ({w * 2, h})) or (((dblY == 1) and ({w, h * 2})) or (((quad == 1) and ({w * 2, h * 2})) or ({goldW, goldH})))));
    ((ok and (function() return setpicturesize(ws, hs) end)) or (function() return sizer end))()
end
local Resolutions = {["Apple HiRes"] = {280, 192}, ["Atari Mode E"] = {192, 192}, ["Atari Mode F"] = {384, 192}, ["C64 Wide"] = {160, 200}, ["C64/CGA"] = {320, 200}, MSX = {256, 192}, MSX2 = {512, 212}, ["MSX2 Mode 8"] = {256, 212}, ["Mac Mono"] = {512, 342}, ["Mac Color"] = {512, 384}, ["CGA Mode 6"] = {640, 200}, EGA = {640, 350}, VGA = {640, 480}, SVGA = {800, 600}, XGA = {1024, 768}, NES = {256, 240}, SNES = {256, 224}, Genesis = {320, 224}, GameBoy = {160, 144}, GameBoyAdvanced = {240, 160}, DS = {256, 192}, ["NES/GB Sprite"] = {8, 8}, ["NES Tall/GB Sprite"] = {6, 16}, ["SNES/GBA/DS Sprite"] = {64, 64}, ["Genesis Sprite"] = {32, 32}}
local Squares = {{114, 114}, {128, 128}, {192, 192}, {256, 256}, {512, 512}, {768, 768}, {814, 814}}
local function setFromRes(r)
    local w, h = unpack(r)
    setpicturesize(w, h)
end
local function appleHiRes()
    return setFromRes(Resolutions["Apple HiRes"])
end
local function atariModeE()
    return setFromRes(Resolutions["Atari Mode E"])
end
local function atariModeF()
    return setFromRes(Resolutions["Atari Mode F"])
end
local function c64Wide()
    return setFromRes(Resolutions["C64 Wide"])
end
local function cga()
    return setFromRes(Resolutions["C64/CGA"])
end
local function msx()
    return setFromRes(Resolutions.MSX)
end
local function msx2()
    return setFromRes(Resolutions.MSX2)
end
local function msx2Mode8()
    return setFromRes(Resolutions["MSX2 Mode 8"])
end
local function macMono()
    return setFromRes(Resolutions["Mac Mono"])
end
local function macColor()
    return setFromRes(Resolutions["Mac Color"])
end
local function cgaMode6()
    return setFromRes(Resolutions["CGA Mode 6"])
end
local function ega()
    return setFromRes(Resolutions.EGA)
end
local function vga()
    return setFromRes(Resolutions.VGA)
end
local function svga()
    return setFromRes(Resolutions.SVGA)
end
local function xga()
    return setFromRes(Resolutions.XGA)
end
local function nes()
    return setFromRes(Resolutions.NES)
end
local function snes()
    return setFromRes(Resolutions.SNES)
end
local function genesis()
    return setFromRes(Resolutions.Genesis)
end
local function gb()
    return setFromRes(Resolutions.GameBoy)
end
local function gba()
    return setFromRes(Resolutions.GameBoyAdvanced)
end
local function ds()
    return setFromRes(Resolutions.DS)
end
local function spriteNes()
    return setFromRes(Resolutions["NES/GB Sprite"])
end
local function spriteNesTall()
    return setFromRes(Resolutions["NES Tall/GB Sprite"])
end
local function spriteSnes()
    return setFromRes(Resolutions["SNES/GBA/DS Sprite"])
end
local function spriteGenesis()
    return setFromRes(Resolutions["Genesis Sprite"])
end
local function sq114()
    return setFromRes(Squares[1])
end
local function sq128()
    return setFromRes(Squares[2])
end
local function sq192()
    return setFromRes(Squares[3])
end
local function sq256()
    return setFromRes(Squares[4])
end
local function sq512()
    return setFromRes(Squares[5])
end
local function sq768()
    return setFromRes(Squares[6])
end
local function sq814()
    return setFromRes(Squares[7])
end
local function presetEight()
    return selectbox(Sizer.presets.eight.caption, Sizer.presets.eight.label.apple, appleHiRes, Sizer.presets.eight.label.atariE, atariModeE, Sizer.presets.eight.label.atariF, atariModeF, Sizer.presets.eight.label.cWide, c64Wide, Sizer.presets.eight.label.cga, cga, Sizer.presets.eight.label.msx, msx, Sizer.presets.eight.label.msx2, msx2, Sizer.presets.eight.label.msx28, msx2Mode8, Sizer.label.back, presetImage)
end
local function presetNon()
    return selectbox(Sizer.presets.non.caption, Sizer.presets.non.label.macMono, macMono, Sizer.presets.non.label.macColor, macColor, Sizer.label.back, presetImage)
end
local function presetIbm()
    return selectbox(Sizer.presets.ibm.caption, Sizer.presets.ibm.label.cga6, cgaMode6, Sizer.presets.ibm.label.ega, ega, Sizer.presets.ibm.label.vga, vga, Sizer.presets.ibm.label.svga, svga, Sizer.presets.ibm.label.xga, xga, Sizer.label.back, presetImage)
end
local function presetCon()
    return selectbox(Sizer.presets.con.caption, Sizer.presets.con.label.nes, nes, Sizer.presets.con.label.snes, snes, Sizer.presets.con.label.gen, genesis, Sizer.presets.con.label.gb, gb, Sizer.presets.con.label.gba, gba, Sizer.presets.con.label.ds, ds, Sizer.label.back, presetImage)
end
local function presetSprite()
    return selectbox(Sizer.presets.sprite.caption, Sizer.presets.sprite.label.nesGb, spriteNes, Sizer.presets.sprite.label.nesTall, spriteNesTall, Sizer.presets.sprite.label.snes, spriteSnes, Sizer.presets.sprite.label.gen, spriteGenesis, Sizer.label.back, presetImage)
end
presetImage = function() return selectbox(Sizer.presets.caption, Sizer.presets.label.eight, presetEight, Sizer.presets.label.nonStd, presetNon, Sizer.presets.label.ibmStd, presetIbm, Sizer.presets.label.conHh, presetCon, Sizer.presets.label.sprite, presetSprite, Sizer.label.back, sizer) end
local function squareImage()
    return selectbox(Sizer.squares.caption, Sizer.squares.label.sq114, sq114, Sizer.squares.label.sq128, sq128, Sizer.squares.label.sq192, sq192, Sizer.squares.label.sq256, sq256, Sizer.squares.label.sq512, sq512, Sizer.squares.label.sq768, sq768, Sizer.squares.label.sq814, sq814, Sizer.label.back, sizer)
end
sizer = function(main) return selectbox(Sizer.caption, Sizer.label.modify, modifyImage, Sizer.label.scale, scaleImage, Sizer.label.presets, presetImage, Sizer.label.squares, squareImage, Sizer.label.info, sizerInfo, Sizer.label.back, main) end
____exports.sizer = sizer
return ____exports
end,
[".src.index"] = function() local ____exports = {}
____exports.Point = require("src.Point")
____exports.Size = require("src.Size")
____exports.Utility = require("src.Utility")
____exports.Hex = require("src.Hex")
____exports.Layout = require("src.Layout")
____exports.Orientation = require("src.Orientation")
____exports.Sizer = require("src.ImageSize")
____exports.Color = require("src.Color")
return ____exports
end,
[".src.main"] = function() require("lualib_bundle");
local ____exports = {}
local Point = require("src.Point")
local Size = require("src.Size")
local Utility = require("src.Utility")
local Hex = require("src.Hex")
local Layout = require("src.Layout")
local Orientation = require("src.Orientation")
local Color = require("src.Color")
local ____ImageSize = require("src.ImageSize")
local sizer = ____ImageSize.sizer
local ____MathShortcuts = require("src.MathShortcuts")
local min = ____MathShortcuts.min
local max = ____MathShortcuts.max
local floor = ____MathShortcuts.floor
local hex, hexInfo, color, menu
local MainMenu = {caption = "TACKLEBOX v1.1", label = {hex = "HEXER", color = "COLOR TEMPERATURE", sizer = "SIZER", info = "INFO"}, back = "Back", quit = "QUIT"}
local Info = {caption = "TACKLEBOX - ABOUT", message = "Utility scripts by endowdly\n\nLetters inside () after scripts indicate what they affect:\ni: image, b: brush, p: palette\nc: color, t: text, l: layer\na: animation, n: pen\n\nContact: github.com/endowdly\n\nInspired by DB"}
local ColorMenu = {caption = "TACKLEBOX - COLOR TEMP", label = {colorSet = "Color Set (p)", demo = "Demo (i,  p)"}, colorSet = {caption = "COLOR TEMP - COLOR SET", label = {temp = "Color Temperature (K)", index = "Color Index"}}}
local HexMenu = {caption = "TACKLEBOX - HEXER", label = {rhombus = "Rhombus (i)", triangle = "Triangle (i)", hexagon = "Hexagon (i)", rectangle = "Rectangle (i)", fill = "Fill Canvas (i)", info = "Info"}, info = {caption = "HEXER - ABOUT", message = "Draw hexagon tiles maps.\n\nHexagons can be flat topped or pointy topped. Uncheck 'Flat' in layout panels to make pointy cells. Triangular maps will set their pointedness based on their orientation. Rectangular maps can be oriented along one of the three hex axes. Size includes origin row and grows symmetrically.\n\nInspired by RedBlobGames"}, basic = {label = {width = "Hex Width", height = "Hex Height", fgIdx = "Foreground Index", bgIdx = "Background Index", ox = "Origin X", oy = "Origin Y"}}, rhombus = {basic = "HEXER - RHOMBUS - BASICS", caption = "HEXER - RHOMBUS - LAYOUT", label = {flat = "Flat Top", qr = "Orient qr", rs = "Orient rs", sq = "Orient sq", rows = "Rows", cols = "Columns"}}, triangle = {basic = "HEXER - TRIANGLE - BASICS", caption = "HEXER - TRIANGLE - LAYOUT", label = {up = "Point Up", down = "Point Down", left = "Point Left", right = "Point Right", size = "Size"}}, hexagon = {basic = "HEXER - HEXAGON - BASICS", caption = "HEXER - HEXAGON - LAYOUT", label = {flat = "Flat Top", size = "Size"}}, rectangle = {basic = "HEXER - RECTANGLE - BASICS", caption = "HEXER - RECTANGLE - LAYOUT", label = {flat = "Flat Top", qr = "Orient qr", rs = "Orient rs", sq = "Orient sq", flip = "Flip Orientation", rows = "Rows", cols = "Columns"}}, fill = {basic = "HEXER - FILL - BASICS", caption = "HEXER - FILL - LAYOUT", label = {flat = "Flat Top"}}}
local width, height = getpicturesize()
local x0 = width / 2
local y0 = height / 2
local function getHexBasics(title)
    return inputbox(
        title,
        HexMenu.basic.label.width,
        20,
        1,
        100,
        0,
        HexMenu.basic.label.height,
        20,
        1,
        100,
        0,
        HexMenu.basic.label.fgIdx,
        getforecolor(),
        0,
        255,
        0,
        HexMenu.basic.label.bgIdx,
        getbackcolor(),
        0,
        255,
        0,
        HexMenu.basic.label.ox,
        x0,
        0,
        width,
        0,
        HexMenu.basic.label.oy,
        y0,
        0,
        height,
        0
    )
end
local function ShapeRhombus(q1, r1, q2, r2, f)
    return __TS__ArrayFlatMap(
        Utility.rangeInclusive(q1, q2),
        function(____, q) return __TS__ArrayMap(
            Utility.rangeInclusive(r1, r2),
            function(____, r) return f(q, r, -q - r) end
        ) end
    )
end
local function ShapeTriangleDownRight(size)
    local hexes = {}
    do
        local q = 0
        while q <= size do
            do
                local r = 0
                while r <= (size - q) do
                    __TS__ArrayPush(
                        hexes,
                        Hex.init(q, r, -q - r)
                    )
                    r = r + 1
                end
            end
            q = q + 1
        end
    end
    return hexes
end
local function ShapeTriangleUpLeft(size)
    local hexes = {}
    do
        local q = 0
        while q <= size do
            do
                local r = size - q
                while r <= size do
                    __TS__ArrayPush(
                        hexes,
                        Hex.fromAxial(q, r)
                    )
                    r = r + 1
                end
            end
            q = q + 1
        end
    end
    return hexes
end
local function ShapeHexagon(size)
    return __TS__ArrayFlatMap(
        Utility.rangeInclusive(-size, size),
        function(____, q) return __TS__ArrayMap(
            Utility.rangeInclusive(
                max(-size, -q - size),
                min(size, -q + size)
            ),
            function(____, r) return Hex.fromAxial(q, r) end
        ) end
    )
end
local function ShapeRectangle(w, h, f)
    local i1 = -floor(w / 2)
    local i2 = i1 + w
    local j1 = -floor(h / 2)
    local j2 = j1 + h
    return __TS__ArrayFlatMap(
        Utility.range(j1, j2),
        function(____, j) return __TS__ArrayMap(
            Utility.range(
                i1 - floor(j / 2),
                i2 - floor(j / 2)
            ),
            function(____, i) return f(i, j, -i - j) end
        ) end
    )
end
local function drawHex(fg, layout, hex)
    local function toMap(x, min, max)
        local y = x + 1
        return ((y > max) and min) or y
    end
    local cornersTo = __TS__ArrayMap(
        Utility.rangeInclusive(0, 5),
        function(____, n) return toMap(n, 0, 5) end
    )
    local corners = Hex.getCorners(layout, hex)
    for i = 0, 5 do
        local fromCorner = corners[i + 1]
        local toCorner = corners[cornersTo[i + 1] + 1]
        drawline(fromCorner.x, fromCorner.y, toCorner.x, toCorner.y, fg)
    end
end
local function drawGrid(bg, fg, layout, hs)
    if hs == nil then
        return
    end
    __TS__ArrayForEach(
        hs,
        function(____, hex)
            drawHex(fg, layout, hex)
        end
    )
end
local function permuteQRS(q, r, s)
    return Hex.init(q, r, s)
end
local function permuteQSR(q, s, r)
    return Hex.init(q, r, s)
end
local function permuteSRQ(s, r, q)
    return Hex.init(q, r, s)
end
local function permuteSQR(s, q, r)
    return Hex.init(q, r, s)
end
local function permuteRQS(r, q, s)
    return Hex.init(q, r, s)
end
local function permuteRSQ(r, s, q)
    return Hex.init(q, r, s)
end
local function rhombusMenu()
    local sizeOk, w, h, fg, bg, ox, oy = getHexBasics(HexMenu.rhombus.basic)
    local maxRows = height / h
    local maxCols = width / w
    if sizeOk == true then
        local ok, flat, qr, rs, sq, rows, cols = inputbox(HexMenu.rhombus.caption, HexMenu.rhombus.label.flat, 1, 0, 1, 0, HexMenu.rhombus.label.qr, 1, 0, 1, -2, HexMenu.rhombus.label.rs, 0, 0, 1, -2, HexMenu.rhombus.label.sq, 0, 0, 1, -2, HexMenu.rhombus.label.rows, 2, 1, maxRows, 0, HexMenu.rhombus.label.cols, 2, 1, maxCols, 0)
        local orientation = ((flat == 1) and Orientation.flat) or Orientation.pointy
        local hexSize = Size.init(w, h)
        local origin = Point.init(ox, oy)
        local layout = Layout.init(orientation, hexSize, origin)
        local hexes = ((qr == 1) and ShapeRhombus(-rows, -cols, rows, cols, permuteQRS)) or (((rs == 1) and ShapeRhombus(-rows, -cols, rows, cols, permuteRSQ)) or ShapeRhombus(-rows, -cols, rows, cols, permuteSQR));
        (((ok == true) and (function() return drawGrid(bg, fg, layout, hexes) end)) or (function() return hex() end))()
    else
        hex()
    end
end
local function triangleMenu()
    local sizeOk, w, h, fg, bg, ox, oy = getHexBasics(HexMenu.triangle.basic)
    local maxRows = height / h
    local maxCols = width / w
    local maxSize = min(maxRows, maxCols)
    if sizeOk == true then
        local ok, up, down, right, left, size = inputbox(HexMenu.triangle.caption, HexMenu.triangle.label.up, 1, 0, 1, -1, HexMenu.triangle.label.down, 0, 0, 1, -1, HexMenu.triangle.label.right, 0, 0, 1, -1, HexMenu.triangle.label.left, 0, 0, 1, -1, HexMenu.triangle.label.size, 5, 1, maxSize, 0)
        local orientation = (((up == 1) or (down == 1)) and Orientation.pointy) or Orientation.flat
        local hexSize = Size.init(w, h)
        local origin = Point.init(ox, oy)
        local layout = Layout.init(orientation, hexSize, origin)
        local hexes = (((up == 1) or (left == 1)) and ShapeTriangleUpLeft(size)) or ShapeTriangleDownRight(size);
        (((ok == true) and (function() return drawGrid(bg, fg, layout, hexes) end)) or (function() return hex() end))()
    else
        hex()
    end
end
local function hexagonMenu()
    local sizeOk, w, h, fg, bg, ox, oy = getHexBasics(HexMenu.hexagon.basic)
    local maxRows = height / h
    local maxCols = width / w
    local maxSize = (min(maxRows, maxCols) / 2) - 1
    if sizeOk == true then
        local ok, flat, size = inputbox(HexMenu.hexagon.caption, HexMenu.hexagon.label.flat, 1, 0, 1, 0, HexMenu.hexagon.label.size, 3, 0, maxSize, 0)
        local orientation = ((flat == 1) and Orientation.flat) or Orientation.pointy
        local hexSize = Size.init(w, h)
        local origin = Point.init(ox, oy)
        local layout = Layout.init(orientation, hexSize, origin)
        local hexes = ShapeHexagon(size);
        (((ok == true) and (function() return drawGrid(bg, fg, layout, hexes) end)) or (function() return hex() end))()
    else
        hex()
    end
end
local function rectangleMenu()
    local sizeOk, w, h, fg, bg, ox, oy = getHexBasics(HexMenu.rectangle.basic)
    local maxRows = height / h
    local maxCols = width / w
    if sizeOk == true then
        local ok, flat, qr, rs, sq, flip, rows, cols = inputbox(HexMenu.rectangle.caption, HexMenu.rectangle.label.flat, 1, 0, 1, 0, HexMenu.rectangle.label.qr, 1, 0, 1, -1, HexMenu.rectangle.label.rs, 0, 0, 1, -1, HexMenu.rectangle.label.sq, 0, 0, 1, -1, HexMenu.rectangle.label.flip, 0, 0, 1, 0, HexMenu.rectangle.label.rows, 4, 1, maxRows, 0, HexMenu.rectangle.label.cols, 4, 1, maxCols, 0)
        local orientation = ((flat == 1) and Orientation.flat) or Orientation.pointy
        local hexSize = Size.init(w, h)
        local origin = Point.init(ox, oy)
        local layout = Layout.init(orientation, hexSize, origin)
        local getf = ((qr == 1) and permuteQRS) or (((rs == 1) and permuteRSQ) or permuteSQR)
        local getF = ((qr == 1) and permuteRQS) or (((rs == 1) and permuteSRQ) or permuteQSR)
        local xfrm = ((flip == 1) and getF) or getf
        local hexes = ShapeRectangle(rows, cols, xfrm);
        (((ok == true) and (function() return drawGrid(bg, fg, layout, hexes) end)) or (function() return hex() end))()
    else
        hex()
    end
end
local function fillMenu()
    local sizeOk, w, h, fg, bg, _, __ = getHexBasics(HexMenu.fill.basic)
    if sizeOk then
        local ok, flat = inputbox(HexMenu.fill.caption, HexMenu.fill.label.flat, 1, 0, 1, 0)
        local maxRows = height / h
        local maxCols = width / w
        local orientation = ((flat == 1) and Orientation.flat) or Orientation.pointy
        local origin = Point.init(x0, y0)
        local hexSize = Size.init(w, h)
        local layout = Layout.init(orientation, hexSize, origin)
        local hexes = ShapeRectangle(maxRows, maxCols, permuteQRS);
        (((ok == true) and (function() return drawGrid(bg, fg, layout, hexes) end)) or (function() return hex() end))()
    else
        hex()
    end
end
hex = function() return selectbox(HexMenu.caption, HexMenu.label.rhombus, rhombusMenu, HexMenu.label.triangle, triangleMenu, HexMenu.label.hexagon, hexagonMenu, HexMenu.label.rectangle, rectangleMenu, HexMenu.label.fill, fillMenu, HexMenu.label.info, hexInfo, MainMenu.back, menu) end
hexInfo = function()
    messagebox(HexMenu.info.caption, HexMenu.info.message)
    hex()
end
local function colorFill()
    clearpicture(0)
    local r = (40000 - 1000) / 255
    local sampledColors = Utility.rangeInclusive(1000, 40000, r)
    for n = 1, 255 do
        local color = Color.fromTemperature(sampledColors[n])
        setcolor(n, color.r, color.g, color.b)
        local xh = (x0 / 2) - (256 / 2)
        local yH = (y0 / 2) + 10
        local yB = (y0 / 2) - 10
        drawfilledrect(xh + n, yH, xh + n, yB, n)
    end
end
local function colorSet()
    local ok, temp, index = inputbox(ColorMenu.colorSet.caption, ColorMenu.colorSet.label.temp, 2400, 1000, 40000, 0, ColorMenu.colorSet.label.index, 1, 0, 255, 0)
    local x = Color.fromTemperature(temp);
    (((ok == true) and (function() return setcolor(index, x.r, x.g, x.b) end)) or (function() return color() end))()
end
color = function() return selectbox(ColorMenu.caption, ColorMenu.label.colorSet, colorSet, ColorMenu.label.demo, colorFill, MainMenu.back, menu) end
local function info()
    messagebox(Info.caption, Info.message)
    menu()
end
local function dummy()
    return nil
end
menu = function() return selectbox(
    MainMenu.caption,
    MainMenu.label.hex,
    hex,
    MainMenu.label.color,
    color,
    MainMenu.label.sizer,
    sizer(menu),
    MainMenu.label.info,
    info,
    MainMenu.quit,
    dummy
) end
menu()
return ____exports
end,
[".test.hexer.test"] = function() local ____exports = {}
local ____chai = require("test.chai")
local expect = ____chai.expect
local ____assert = ____chai.assert
local ____src = require("src")
local Hex = ____src.Hex
local Point = ____src.Point
local Size = ____src.Size
local Layout = ____src.Layout
local Orientation = ____src.Orientation
describe(
    nil,
    "Hex.getCorners",
    function()
        it(
            nil,
            "outputs six points",
            function()
                local size = Size.init(20, 20)
                local origin = Point.init(100, 100)
                local hex = Hex.init(0, 0, 0)
                local layout = Layout.init(Orientation.pointy, size, origin)
                local corners = Hex.getCorners(layout, hex)
                expect(nil, #corners).to:equal(6)
            end
        )
    end
)
describe(
    nil,
    "Hex",
    function()
        local a = Hex.init(1, -3, 2)
        local b = Hex.init(3, -7, 4)
        it(
            nil,
            "adds hexes",
            function()
                local expected = Hex.init(4, -10, 6)
                local actual = Hex.add(a, b)
                ____assert:deepEqual(actual, expected)
            end
        )
        it(
            nil,
            "subtracts hexes",
            function()
                local expected = Hex.init(-2, 4, -2)
                local actual = Hex.subtract(a, b)
                ____assert:deepEqual(actual, expected)
            end
        )
        it(
            nil,
            "gets hex distance",
            function()
                local given = Hex.base
                local expected = 7
                local actual = Hex.distance(b, given)
                ____assert:equal(actual, expected)
            end
        )
        it(
            nil,
            "rotates hexes right",
            function()
                local expected = Hex.init(3, -2, -1)
                local actual = Hex.rotateRight(a)
                ____assert:deepEqual(actual, expected)
            end
        )
        it(
            nil,
            "rotates hexes left",
            function()
                local expected = Hex.init(-2, -1, 3)
                local actual = Hex.rotateLeft(a)
                ____assert:deepEqual(actual, expected)
            end
        )
        it(
            nil,
            "rounds hexes",
            function()
                local a = Hex.base
                local b = Hex.init(10, -20, 10)
                local t = 0.5
                local x = Hex.lerp(a, b, t)
                local expected = Hex.init(5, -10, 5)
                local actual = Hex.round(x)
                ____assert:deepEqual(actual, expected)
            end
        )
    end
)
return ____exports
end,
[".test.types.test"] = function() local ____exports = {}
local ____chai = require("test.chai")
local expect = ____chai.expect
local ____src = require("src")
local Point = ____src.Point
local Orientation = ____src.Orientation
local Layout = ____src.Layout
local ____src = require("src")
local Size = ____src.Size
local ____src = require("src")
local Hex = ____src.Hex
describe(
    nil,
    "Point",
    function()
        it(
            nil,
            "can be initialized from init",
            function()
                local point = Point.init(0, 1)
                expect(nil, point.x).to:equal(0)
                expect(nil, point.y).to:equal(1)
            end
        )
    end
)
describe(
    nil,
    "Size",
    function()
        it(
            nil,
            "can be initialized from init",
            function()
                local size = Size.init(0, 1)
                expect(nil, size.xDimension).to:eq(0)
                expect(nil, size.yDimension).to:eq(1)
            end
        )
    end
)
describe:skip(
    "Layout",
    function()
        it(
            nil,
            "can be initialized from init",
            function()
                local orientation = Orientation.pointy
                local size = Size.init(10, 10)
                local origin = Point.init(0, 0)
                local layout = Layout.init(orientation, size, origin)
                expect(nil, layout.orientation).to.be:a("Orientation.Orientation")
            end
        )
    end
)
context(
    nil,
    "Directions",
    function()
        describe(
            nil,
            "Face Direction",
            function()
                it(
                    nil,
                    "has the correct hex at the top-right",
                    function()
                        local expected = Hex.init(1, 0, -1)
                        local actual = Hex.faces.topRight
                        expect(nil, actual).to.deep:equal(expected)
                    end
                )
                it(
                    nil,
                    "has the correct hex at the center-right",
                    function()
                        local expected = Hex.init(1, -1, 0)
                        local actual = Hex.faces.centerRight
                        expect(nil, actual).to.deep:equal(expected)
                    end
                )
                it(
                    nil,
                    "has the correct hex at the bottom-right",
                    function()
                        local expected = Hex.init(0, -1, 1)
                        local actual = Hex.faces.bottomRight
                        expect(nil, actual).to.deep:equal(expected)
                    end
                )
                it(
                    nil,
                    "has the correct hex at the bottom-left",
                    function()
                        local expected = Hex.init(-1, 0, 1)
                        local actual = Hex.faces.bottomLeft
                        expect(nil, actual).to.deep:equal(expected)
                    end
                )
                it(
                    nil,
                    "has the correct hex at the center-left",
                    function()
                        local expected = Hex.init(-1, 1, 0)
                        local actual = Hex.faces.centerLeft
                        expect(nil, actual).to.deep:equal(expected)
                    end
                )
                it(
                    nil,
                    "has the correct hex at the top-left",
                    function()
                        local expected = Hex.init(0, 1, -1)
                        local actual = Hex.faces.topLeft
                        expect(nil, actual).to.deep:equal(expected)
                    end
                )
            end
        )
        describe(
            nil,
            "Vertex Direction",
            function()
                it(
                    nil,
                    "has the correct hex at the top",
                    function()
                        local expected = Hex.init(1, 1, -2)
                        local actual = Hex.vertices.top
                        expect(nil, actual).to.deep:equal(expected)
                    end
                )
                it(
                    nil,
                    "has the correct hex at the top-right",
                    function()
                        local expected = Hex.init(2, -1, -1)
                        local actual = Hex.vertices.topRight
                        expect(nil, actual).to.deep:equal(expected)
                    end
                )
                it(
                    nil,
                    "has the correct hex at the bottom-right",
                    function()
                        local expected = Hex.init(1, -2, 1)
                        local actual = Hex.vertices.bottomRight
                        expect(nil, actual).to.deep:equal(expected)
                    end
                )
                it(
                    nil,
                    "has the correct hex at the bottom",
                    function()
                        local expected = Hex.init(-1, -1, 2)
                        local actual = Hex.vertices.bottom
                        expect(nil, actual).to.deep:equal(expected)
                    end
                )
                it(
                    nil,
                    "has the correct hex at the bottom-left",
                    function()
                        local expected = Hex.init(-2, 1, 1)
                        local actual = Hex.vertices.bottomLeft
                        expect(nil, actual).to.deep:equal(expected)
                    end
                )
                it(
                    nil,
                    "has the correct hex at the top-left",
                    function()
                        local expected = Hex.init(-1, 2, -1)
                        local actual = Hex.vertices.topLeft
                        expect(nil, actual).to.deep:equal(expected)
                    end
                )
            end
        )
    end
)
return ____exports
end,
[".test.utility.test"] = function() local ____exports = {}
local ____chai = require("test.chai")
local expect = ____chai.expect
local ____src = require("src")
local Utility = ____src.Utility
context(
    nil,
    "Utilities",
    function()
        describe(
            nil,
            "sum",
            function()
                it(
                    nil,
                    "sums lists",
                    function()
                        local ls = {0, 1, 2}
                        local sum = Utility.sum(ls)
                        expect(nil, sum).to:equal(3)
                    end
                )
            end
        )
        describe(
            nil,
            "range",
            function()
                it(
                    nil,
                    "returns an exclusive, one-stepped, incrementing range when start < stop",
                    function()
                        local r = Utility.range(1, 5)
                        local e = {1, 2, 3, 4}
                        expect(nil, r).to.deep:equal(e)
                    end
                )
                it(
                    nil,
                    "returns an exclusive, one-stepped, decrementing range when start > stop",
                    function()
                        local r = Utility.range(5, 1)
                        local e = {5, 4, 3, 2}
                        expect(nil, r).to.deep:equal(e)
                    end
                )
                it(
                    nil,
                    "returns an exclusive, n-stepped, incrementing range when start < stop and step is n",
                    function()
                        local r = Utility.range(1, 10, 2)
                        local e = {1, 3, 5, 7, 9}
                        expect(nil, r).to.deep:equal(e)
                    end
                )
                it(
                    nil,
                    "returns an exclusive, n-stepped, decrementing range when start < stop and step is n",
                    function()
                        local r = Utility.range(10, 1, 2)
                        local e = {10, 8, 6, 4, 2}
                        expect(nil, r).to.deep:equal(e)
                    end
                )
            end
        )
        describe(
            nil,
            "rangeInclusive",
            function()
                it(
                    nil,
                    "returns an inclusive, one-stepped, incrementing range when start < stop",
                    function()
                        local r = Utility.rangeInclusive(1, 5)
                        local e = {1, 2, 3, 4, 5}
                        expect(nil, r).to.deep:equal(e)
                    end
                )
                it(
                    nil,
                    "returns an inclusive, one-stepped, decrementing range when start > stop",
                    function()
                        local r = Utility.rangeInclusive(5, 1)
                        local e = {5, 4, 3, 2, 1}
                        expect(nil, r).to.deep:equal(e)
                    end
                )
                it(
                    nil,
                    "returns an inclusive, n-stepped, incrementing range when start < stop and step is n",
                    function()
                        local r = Utility.rangeInclusive(0, 10, 2)
                        local e = {0, 2, 4, 6, 8, 10}
                        expect(nil, r).to.deep:equal(e)
                    end
                )
                it(
                    nil,
                    "returns an inclusive, n-stepped, decrementing range when start < stop and step is n",
                    function()
                        local r = Utility.rangeInclusive(10, 0, 2)
                        local e = {10, 8, 6, 4, 2, 0}
                        expect(nil, r).to.deep:equal(e)
                    end
                )
            end
        )
    end
)
return ____exports
end,
}
return require(".src.main")
