local lookup_table = {
	a = 0, e = 0, i = 0, o = 0, u = 0, y = 0, h = 0, w = 0,
	b = 1, f = 1, p = 1, v = 1,
	c = 2, g = 2, j = 2, k = 2, q = 2, s = 2, x = 2, z = 2,
	d = 3, t = 3,
	l = 4,
	m = 5, n = 5,
	r = 6,
}

local function string_foreach (str, fnc)
	for i = 1, #str do
		local c = string.sub(str, i, i)
		fnc (i, c)
	end
end

local function string_at (str, idx)
	return string.sub(str, idx, idx)
end

local function zeros (n, accu)
	if 0 == n then
		return accu
	end

	return zeros (n - 1, accu .. '0')
end

return setmetatable ({}, {
	__call = function (self, name)
		self.encoded = string_at (string.upper (name), 1)

		local rest = string.lower (string.sub (name, 2))
		local code = ''
		string_foreach (rest, function (_, c)
			local value = tostring (lookup_table[c])
			if nil == value then
				error ('unkonwn character, only english alphabet supported!')
			end
			code = code .. value
		end)

		local reduced_code = ''
		string_foreach (code, function (i, c)
			if (i + 1 <= #code
				and string_at (code, i) ~= string_at (code, i + 1))
			or (i + 1) == #code
			then
				reduced_code = reduced_code .. c
			end
		end)

		string_foreach (reduced_code, function (_, c)
			if '0' ~= c then
				self.encoded = self.encoded .. c
			end
		end)

		local l = #self.encoded
		if 4 > l then
			self.encoded = self.encoded .. zeros (l - 4, '')
		elseif 4 < l then
			self.encoded = string.sub (self.encoded, 1, 4)
		end

		return self
	end,
})