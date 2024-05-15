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
  puts "Choose a type of activity:"
  puts "education | recreational | social | diy | charity | cooking | relaxation | music | busywork"
  type = gets.chomp
  puts "How many total people will be participating in the activity?"
  participants = gets.chomp.to_i
  puts "On a decimal scale between 0 and 1, how much do you want the activity to cost? 0 being free and 1 being the most expensive:"
  price = gets.chomp.to_f
  puts "On a decimal scale between 0 and 1, how accessible do you want this event to be? 0 being the most accessible and 1 being the least accessible:"
  accessibility = gets.chomp.to_f

  # Validate input
  valid_types = ["education", "recreational", "social", "diy", "charity", "cooking", "relaxation", "music", "busywork"]
  type = type.downcase
  unless valid_types.include?(type)
    puts "Invalid activity type."
    return
  end

  if participants <= 0
    puts "Participants should be a positive number."
    return
  end

  if price < 0 || price > 1
    puts "Price should be between 0 and 1."
    return
  end

  if accessibility < 0 || accessibility > 1
    puts "Accessibility should be between 0 and 1."
    return
  end

  # Build the query string
  query_params = {
    type: type,
    participants: participants,
    price: price,
    accessibility: accessibility
  }.map { |k, v| "#{k}=#{v}" }.join("&")

  url = "http://www.boredapi.com/api/activity?#{query_params}"
  response = HTTP.get(url).to_s
  data = JSON.parse(response)

  if data['error']
    puts data['error']
  else
    puts data['activity']
  end
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

