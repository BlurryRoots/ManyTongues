Zoundex = require 'zoundex'

function assert_equal (a, b)
	if a ~= b then
		error (tostring (a) .. " not equal " .. tostring (b))
	end
end

function main ()
	assert_equal ('F263', Zoundex("figsworth").encoded)

	assert_equal ('F652', Zoundex ('FarnsWorth').encoded)

	assert_equal ('L126', Zoundex ('lovecraft').encoded)
	assert_equal ('L126', Zoundex ('loafkraft').encoded)
end

main ()
