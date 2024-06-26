func test_simple():
	var sqids = Sqids.new({
		_suppress=true,
		min_length=len(Sqids.DEFAULT_ALPHABET)
	})
	assert(sqids._error == "")

	var numbers = [1, 2, 3]
	var id_str = "86Rf07xd4zBmiJXQG6otHEbew02c3PWsUOLZxADhCpKj7aVFv9I8RquYrNlSTM"

	assert(sqids.encode(numbers) == id_str)
	assert(sqids.decode(id_str) == numbers)

func test_incremental():
	var numbers = [1, 2, 3]
	var map = {
		6: "86Rf07",
		7: "86Rf07x",
		8: "86Rf07xd",
		9: "86Rf07xd4",
		10: "86Rf07xd4z",
		11: "86Rf07xd4zB",
		12: "86Rf07xd4zBm",
		13: "86Rf07xd4zBmi",
	}

	var length = len(Sqids.DEFAULT_ALPHABET);

	map[length + 0] = "86Rf07xd4zBmiJXQG6otHEbew02c3PWsUOLZxADhCpKj7aVFv9I8RquYrNlSTM"
	map[length + 1] = "86Rf07xd4zBmiJXQG6otHEbew02c3PWsUOLZxADhCpKj7aVFv9I8RquYrNlSTMy"
	map[length + 2] = "86Rf07xd4zBmiJXQG6otHEbew02c3PWsUOLZxADhCpKj7aVFv9I8RquYrNlSTMyf"
	map[length + 3] = "86Rf07xd4zBmiJXQG6otHEbew02c3PWsUOLZxADhCpKj7aVFv9I8RquYrNlSTMyf1"

	for min_length in map:
		var id = map[min_length]
		var sqids = Sqids.new({
			_suppress=true,
			min_length=min_length
		})
		assert(sqids._error == "")

		assert(sqids.encode(numbers) == id)
		assert(len(sqids.encode(numbers)) == min_length)
		assert(sqids.decode(id) == numbers)

func test_incremental_numbers():
	var sqids = Sqids.new({
		_suppress=true,
		min_length=len(Sqids.DEFAULT_ALPHABET)
	})
	assert(sqids._error == "")

	var ids = {
		"SvIzsqYMyQwI3GWgJAe17URxX8V924Co0DaTZLtFjHriEn5bPhcSkfmvOslpBu": [0, 0],
		"n3qafPOLKdfHpuNw3M61r95svbeJGk7aAEgYn4WlSjXURmF8IDqZBy0CT2VxQc": [0, 1],
		"tryFJbWcFMiYPg8sASm51uIV93GXTnvRzyfLleh06CpodJD42B7OraKtkQNxUZ": [0, 2],
		"eg6ql0A3XmvPoCzMlB6DraNGcWSIy5VR8iYup2Qk4tjZFKe1hbwfgHdUTsnLqE": [0, 3],
		"rSCFlp0rB2inEljaRdxKt7FkIbODSf8wYgTsZM1HL9JzN35cyoqueUvVWCm4hX": [0, 4],
		"sR8xjC8WQkOwo74PnglH1YFdTI0eaf56RGVSitzbjuZ3shNUXBrqLxEJyAmKv2": [0, 5],
		"uY2MYFqCLpgx5XQcjdtZK286AwWV7IBGEfuS9yTmbJvkzoUPeYRHr4iDs3naN0": [0, 6],
		"74dID7X28VLQhBlnGmjZrec5wTA1fqpWtK4YkaoEIM9SRNiC3gUJH0OFvsPDdy": [0, 7],
		"30WXpesPhgKiEI5RHTY7xbB1GnytJvXOl2p0AcUjdF6waZDo9Qk8VLzMuWrqCS": [0, 8],
		"moxr3HqLAK0GsTND6jowfZz3SUx7cQ8aC54Pl1RbIvFXmEJuBMYVeW9yrdOtin": [0, 9],
	}

	for id_str in ids:
		var numbers = ids[id_str]
		assert(sqids.encode(numbers) == id_str)
		assert(sqids.decode(id_str) == numbers)

func test_min_lengths():
	for min_length in [0, 1, 5, 10, len(Sqids.DEFAULT_ALPHABET)]:
		for numbers in [
			[0],
			[0, 0, 0, 0, 0],
			[1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
			[100, 200, 300],
			[1000, 2000, 3000],
			[1000000],
			[9223372036854775807],
		]:
			var sqids = Sqids.new({
				_suppress=true,
				min_length=min_length
			})
			assert(sqids._error == "")

			var id_str = sqids.encode(numbers)
			assert(len(id_str) >= min_length)
			assert(sqids.decode(id_str) == numbers)

func test_out_of_range_invalid_min_length():
	var sqids = Sqids.new({
		_suppress=true,
		min_length=-1
	})

	assert(sqids._error == "Minimum length has to be between 0 and 255")

	sqids = Sqids.new({
		_suppress=true,
		min_length=256
	})

	assert(sqids._error == "Minimum length has to be between 0 and 255")
