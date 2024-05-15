input = File.open('./weather.dat', File::RDONLY){|f| f.read }
array = input.lines.map(&:split)


i = 2
least_diff = [999999, 0]

while i < array.length
  day = array[i][0]
  max = array[i][1]
  min = array[i][2]
  if max.to_i - min.to_i < least_diff[0]
    least_diff = [max.to_i - min.to_i, day]
  end
  i += 1
end
 
p least_diff
