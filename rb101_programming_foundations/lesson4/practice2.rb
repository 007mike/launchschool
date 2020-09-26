ages = { "Herman" => 32,
         "Lily" => 30,
         "Grandpa" => 5843,
         "Eddie" => 10,
         "Marilyn" => 22,
         "Spot" => 237 }
age_sum = 0

ages.each { |_, age| age_sum += age }

puts age_sum
