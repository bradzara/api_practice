require "http"

def random
  response = HTTP.get("http://www.boredapi.com/api/activity/").to_s
  data = JSON.parse(response)
  puts data["activity"]
  puts "Would you like another option? (Y/N)"
  user_input = gets.chomp.upcase
  if user_input == "Y"
    return random
  elsif user_input == "N"
    exit
  end
end

def filter
  puts "This is the filter method"
end

def menu
  puts "Press 1 for a random choice, or press 2 to filter your choices:"
  user_input = gets.chomp.to_i

  if user_input == 1
    return random
  elsif user_input == 2
    return filter
  else
    puts "Invalid option"
    return menu
  end
end  

menu

