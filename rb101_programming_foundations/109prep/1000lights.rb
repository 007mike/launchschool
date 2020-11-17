#input - integer, n number of lights
#output - array, lights that are in the on position
#rules 
# 1. lights all start off
# 2. first round lights all lights toggled on
# 3. 2nd round lights 2, 4, 6 .. toggled
# 4. 3rd round lights 3, 6, 9 ... toggled
# 5. continue pattern until n rounds complete
#approach
# 1. create a hash consisting of n integer keys and false values
# 2. create a counter loop from 1 to n for round
# 3. create a 2nd counter also from 1 to n for a multiplier
# 4. create a multiplier by multiplying counter 1 by counter 2
# 5. toggle light with key equal to multiplier
# 6. repeat until counter 1 completes
# 7. iterate through hash and create an array of keys where value equals true

def init_lights(n)
  lights = Hash.new
  1.upto(n) { |i| lights[i] = false }
  lights
end

def toggle_lights(hsh)
  1.upto(hsh.size) do |i|
    1.upto(hsh.size) do |j|
      multiplier = i * j
      break if multiplier > hsh.size
      hsh[multiplier] == false ? hsh[multiplier] = true : hsh[multiplier] = false
    end
  end
  hsh
end

def on_lights(hsh)
  hsh.select do |k, v|
    v == true
  end.keys
end

lights = init_lights(1000)
toggled = toggle_lights(lights)
p on_lights(toggled)
