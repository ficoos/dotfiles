function string.split(s, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(s, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end
array = {}
function array.find_item(arr, v)
    for i, val in ipairs(arr) do
        if val == v then
            return i
        end
    end
    return nil
end

-- fix expansion types

if kak_client_list then
    kak_client_list = string.split(kak_client_list)
end

if kak_client_pid then
    kak_client_pid = tonumber(kak_client_pid)
end

local function opts_to_args(opts, def)
    local args = " "
    for name, kind in pairs(def) do
        if kind == "boolean" then
            if opts[name] then
                args = args .. "-" .. name .. " "
            end
        else
            error("unsupported option kind '" .. kind .. "'")
        end
    end

    return args
end

function sh(script)
    return {_type="sh", script=script}
end

-- emit a properly escaped command
function emit_cmd(...)
    local cmd = {}
    for _, v in ipairs({...}) do
        local v_type = (type(v) ~= "table" and type(v)) or v._type
        if v_type == "string" then
            cmd[#cmd+1] = ("%%{%s}"):format(v)
        elseif v_type == "number" then
            cmd[#cmd+1] = tostring(v)
        elseif v_type == "boolean" then
            cmd[#cmd+1] = tostring(v)
        elseif v_type == "sh" then
            cmd[#cmd+1] = ("%%sh{%s}"):format(v.script)
        else
            assert(false, ("unsupported argument of type '%s'"):format(v_type))
        end
    end

    print(table.concat(cmd, " "))
end
