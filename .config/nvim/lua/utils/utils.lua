local M = {}

M.table_contains = function(x, tbl)
	local found = false
	for _, v in pairs(tbl) do
		if v == x then
			found = true
		end
	end
	return found
end

M.silent_exec = function(func, arg1, arg2)
	local original = vim.notify
	vim.notify = function() end
	pcall(func, arg1, arg2)
	vim.notify = original
end

M.rm_conflicted_client = function(client, bufnr, keep, throw)
	local keepId, throwId

	for _, clnt in ipairs(vim.lsp.buf_get_clients(bufnr)) do
		if clnt.name == keep then keepId = clnt.id end
		if clnt.name == throw then throwId = clnt.id end
	end

	keepId = keepId or client.name == keep and client.id
	throwId = throwId or client.name == throw and client.id
	if not keepId or not throwId then return end

	M.silent_exec(vim.lsp.buf_detach_client, bufnr, throwId)
end

return M
