flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

family = {}

flintstones.each_with_index do |flintstone, index|
  family[flintstone] = index
end

p family