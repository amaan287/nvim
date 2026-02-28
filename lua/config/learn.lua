local M = {}

local session = {
  active = false,
  start_time = nil,
  snapshot = {},
}

local function notify(msg)
  vim.notify(msg, vim.log.levels.INFO)
end

function M.start()
  if session.active then
    notify("Learning session already active.")
    return
  end

  session.active = true
  session.start_time = os.time()
  session.snapshot = {}

  -- Take snapshot of all listed buffers at start
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
      local name = vim.api.nvim_buf_get_name(buf)
      if name ~= "" then
        session.snapshot[name] = table.concat(
          vim.api.nvim_buf_get_lines(buf, 0, -1, false),
          "\n"
        )
      end
    end
  end
  notify("Learning session started.")
end

local function collect_buffers()
  local collected = {}

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then

      local name = vim.api.nvim_buf_get_name(buf)
      if name ~= "" then
        local current = table.concat(
          vim.api.nvim_buf_get_lines(buf, 0, -1, false),
          "\n"
        )

        local before = session.snapshot[name] or ""

        if current ~= before then
          table.insert(collected, {
            name = name,
            before = before,
            after = current,
          })
        end
      end
    end
  end

  return collected
end

function M.stop()
  if not session.active then
    notify("No active learning session.")
    return
  end

  session.active = false

  -- Auto-save all files
  vim.cmd("wall")

  local buffers = collect_buffers()

  if #buffers == 0 then
    notify("No modified buffers found.")
    return
  end

  local prompt = {}
  table.insert(prompt, "Create a detailed step-by-step tutorial explaining what was built.")
  table.insert(prompt, "Do NOT include code.")
  table.insert(prompt, "Explain concepts clearly as if teaching.")
  table.insert(prompt, "Also explain why each change was made.")
  table.insert(prompt, "Add a reflection section about what concepts were learned.")
  table.insert(prompt, "")

  for _, buf in ipairs(buffers) do
    table.insert(prompt, "File: " .. buf.name)
    table.insert(prompt, "--- BEFORE ---")
    table.insert(prompt, buf.before)
    table.insert(prompt, "--- AFTER ---")
    table.insert(prompt, buf.after)
    table.insert(prompt, "")
  end

  local full_prompt = table.concat(prompt, "\n")

  notify("Generating tutorial via OpenCode...")

  local output = {}
  local cmd = { "opencode", full_prompt }

  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if not data then return end
      for _, line in ipairs(data) do
        if line ~= "" then
          table.insert(output, line)
        end
      end
    end,
    on_exit = function()
      local date_folder = vim.fn.getcwd() .. "/learning_logs"
      vim.fn.mkdir(date_folder, "p")

      local filename = os.date("%Y%m%d_%H%M%S") .. ".md"
      local path = date_folder .. "/" .. filename

      local file = io.open(path, "w")
      if file then
        file:write(table.concat(output, "\n"))
        file:close()
        notify("Tutorial saved to learning_logs/" .. filename)
      else
        notify("Failed to write tutorial file.")
      end
    end,
  })
end

return M
