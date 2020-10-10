UUID_FORMAT = [8, 4, 4, 4, 12]
CHOICES = %w(a b c d e f 0 1 2 3 4 5 6 7 8 9)

def uuid
  uuid_str = ''
  UUID_FORMAT.each_with_index do |int, idx|
    int.times  {|x| uuid_str << CHOICES.sample }
    uuid_str << '-' unless idx >= 3
  end
  
  uuid_str
end

p uuid()
