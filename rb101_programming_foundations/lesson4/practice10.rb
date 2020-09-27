# input: munsters hash with nested hash of attributes for each family member
# output: same hash destructively modified to add "age_group" to the nested attributes hash
# explicit: modify the existing hash
# kids is 0 - 17, adults 18 - 64, senior > 65
# age_group is a string
# 1. iterate over each family member
# 2. evaluate age to determine proper age group
# 3. inject new age_group key and value for current family member (destructively)
# 4. output modified hash

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}


munsters.each do | munster , attributes|
  if (0..17).include?(attributes["age"])
    attributes["age_group"] = 'kid'
  elsif (18..64).include?(attributes["age"])
    attributes["age_group"] = 'adult'
  else
    attributes["age_group"] = 'senior'
  end
end

p munsters