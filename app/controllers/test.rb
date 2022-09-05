array = [1,2,3,4,5,6]
array.each do |index|
  print array
  array.delete(index)
  print "\n"
end 