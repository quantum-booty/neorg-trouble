local util = require("trouble.util")

results = {}


function traverse_headings(win, _buf, cb, _options)
    results = {}

    local lines = vim.api.nvim_buf_get_lines(_buf, 0, -1, true)

    for row, line in ipairs(lines) do
        local match = line:match("^%s*%*+%s+")
        if match then
            local row = row - 1
            local col = match:len()
            local pitem = {
                row = row,
                col = col,
                message = line,
                severity = 0,
                range = {
                    start = { line = row, character = col },
                    ["end"] = { line = row, character = -1 },
                },
            }
            table.insert(results, util.process_item(pitem, _buf))
        end
    end

    cb(results)
end


return traverse_headings
