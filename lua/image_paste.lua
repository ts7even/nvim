-- Image-aware `p` / `P`.
--
-- When the system clipboard holds an image, `p`/`P` save it to an `.assets/`
-- folder next to the current file (or /tmp for an unnamed :Scratch buffer) and
-- insert a link to it below/above the cursor line. Snacks.image
-- (lua/plugins/snacks.lua) then renders the link inline. Any other paste (text
-- in the clipboard, a named register like "ap, an SSH session) falls through to
-- the built-in p/P untouched.

-- Preferred first: png needs no ImageMagick for Snacks to render.
local IMAGE_TYPES = { "image/png", "image/jpeg", "image/gif", "image/webp", "image/bmp" }

-- How each filetype links to an image. `%s` is the path relative to the file.
-- Filetypes not listed get the bare relative path.
local LINK_FORMATS = {
    markdown = "![](%s)",
    org = "[[file:%s]]",
}

local function have(cmd) return vim.fn.executable(cmd) == 1 end

-- Returns a clipboard backend {ext, read(path) -> ok} when the clipboard
-- currently holds an image, or nil.
local function clipboard_image()
    if vim.env.WAYLAND_DISPLAY and have("wl-paste") then
        local types = vim.fn.systemlist({ "wl-paste", "--list-types" })
        if vim.v.shell_error ~= 0 then return nil end
        for _, mime in ipairs(IMAGE_TYPES) do
            if vim.tbl_contains(types, mime) then
                return {
                    ext = mime:match("/(%w+)$"):gsub("jpeg", "jpg"),
                    read = function(path)
                        return vim.system({ "sh", "-c", 'wl-paste --type "$1" > "$2"', "sh", mime, path })
                            :wait().code == 0
                    end,
                }
            end
        end
    elseif vim.env.DISPLAY and have("xclip") then
        local types = vim.fn.systemlist({ "xclip", "-selection", "clipboard", "-t", "TARGETS", "-o" })
        if vim.v.shell_error ~= 0 then return nil end
        for _, mime in ipairs(IMAGE_TYPES) do
            if vim.tbl_contains(types, mime) then
                return {
                    ext = mime:match("/(%w+)$"):gsub("jpeg", "jpg"),
                    read = function(path)
                        return vim.system({ "sh", "-c", 'xclip -selection clipboard -t "$1" -o > "$2"', "sh", mime, path })
                            :wait().code == 0
                    end,
                }
            end
        end
    elseif vim.fn.has("mac") == 1 and have("pngpaste") then
        -- `pngpaste -` exits non-zero when there's no image on the clipboard.
        vim.fn.system({ "sh", "-c", "pngpaste - > /dev/null 2>&1" })
        if vim.v.shell_error ~= 0 then return nil end
        return {
            ext = "png",
            read = function(path) return vim.system({ "pngpaste", path }):wait().code == 0 end,
        }
    end
    return nil
end

-- Only the clipboard registers can hold an image; "ap etc. are plain pastes.
local function is_clipboard_register(reg)
    return reg == "+" or reg == "*" or (reg == '"' and vim.o.clipboard:find("unnamed") ~= nil)
end

local function paste_image(img, above)
    -- Unnamed buffers (:Scratch) have no directory to hold an .assets/
    -- folder, so their images go to /tmp and are linked by absolute path.
    local file = vim.api.nvim_buf_get_name(0)
    local scratch = file == ""
    local assets = scratch and "/tmp" or vim.fs.dirname(file) .. "/.assets"
    vim.fn.mkdir(assets, "p")

    local stem = (scratch and "scratch" or vim.fn.fnamemodify(file, ":t:r")) .. "-" .. os.date("%Y%m%d-%H%M%S")
    local name, n = stem .. "." .. img.ext, 1
    while vim.uv.fs_stat(assets .. "/" .. name) do
        name, n = ("%s-%d.%s"):format(stem, n, img.ext), n + 1
    end

    local path = assets .. "/" .. name
    if not img.read(path) then
        vim.fn.delete(path)
        vim.notify("Failed to save clipboard image", vim.log.levels.ERROR)
        return
    end

    local rel = scratch and path or "./.assets/" .. name
    local fmt = LINK_FORMATS[vim.bo.filetype] or "%s"
    local row = vim.api.nvim_win_get_cursor(0)[1]
    local at = above and row - 1 or row
    vim.api.nvim_buf_set_lines(0, at, at, false, { fmt:format(rel) })
    vim.api.nvim_win_set_cursor(0, { at + 1, 0 })
end

local function paste(key)
    local reg, count = vim.v.register, vim.v.count
    -- Normal buffers only (files and :Scratch), not terminals, pickers, etc.
    if is_clipboard_register(reg) and vim.bo.buftype == "" then
        local img = clipboard_image()
        if img then return paste_image(img, key == "P") end
    end
    vim.cmd(("normal! %s\"%s%s"):format(count > 0 and count or "", reg, key))
end

vim.keymap.set("n", "p", function() paste("p") end, { desc = "Paste (image-aware)" })
vim.keymap.set("n", "P", function() paste("P") end, { desc = "Paste above (image-aware)" })

