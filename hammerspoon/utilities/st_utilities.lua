function mergeTables(table1, table2)
	local result = {}

	for key, value in pairs(table1) do
		result[key] = value
	end

	for key, value in pairs(table2) do
		result[key] = value
	end

	return result
end
