UUID_FORMAT = [8, 4, 4, 4, 12]
CHOICES = %w(a b c d e f 0 1 2 3 4 5 6 7 8 9)


def uuid
  uuid_str = ''
  UUID_FORMAT.each do |int|
    int.times do |x|
      uuid_str << CHOICES.sample
    end
  uuid_str << '-'
  end
  uuid_str
end

p uuid()
