def fun_with_ids
  a_outer = 42


  a_outer_id = a_outer.object_id


  puts "a_outer is #{a_outer} with an id of: #{a_outer_id} before the block."
 
  puts

  an_illustrative_method(a_outer, a_outer_id)


  puts "a_outer is #{a_outer} with an id of: #{a_outer_id} BEFORE and: #{a_outer.object_id} AFTER the method call."

  puts

  puts "a_inner is #{a_inner} with an id of: #{a_inner_id} INSIDE and: #{a_inner.object_id} AFTER the method." rescue puts "ugh ohhhhh"
 
  puts
end


def an_illustrative_method(a_outer, a_outer_id)

  puts "a_outer id was #{a_outer_id} before the method and is: #{a_outer.object_id} inside the method."

  puts

  a_outer = 22
 

  puts "a_outer inside after reassignment is #{a_outer} with an id of: #{a_outer_id} before and: #{a_outer.object_id} after."
 
  puts

  a_inner = a_outer


  a_inner_id = a_inner.object_id


  puts "a_inner is #{a_inner} with an id of: #{a_inner_id} inside the method (compared to #{a_outer.object_id} for outer)."
 
  puts
end

fun_with_ids