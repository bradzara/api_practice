require 'net/http'
require 'uri'
require 'json'

# Define a method to search for a player by name
def search_player(first_name, last_name)
  # Construct the URI with the search query parameter
  uri = URI.parse("https://api.balldontlie.io/v1/players?search=#{URI.encode_www_form_component(first_name)}?search=#{URI.encode_www_form_component(last_name)}")
  request = Net::HTTP::Get.new(uri)

  req_options = {
    use_ssl: uri.scheme == "https",
  }

  request["Authorization"] = "a7ecfef6-f62a-4e59-9766-b4d30e3c03d3"
  
  # Perform the HTTP request
  response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
    http.request(request)
  end

  # Print the raw response for debugging
  puts "Raw response code: #{response.code}"
  puts "Raw response body: #{response.body}"

  if response.code.to_i == 200
    JSON.parse(response.body)
  else
    puts "Error: #{response.message}"
    {}
  end
end

# Define a method to display player data
def display_player_data(player_data, first_name, last_name)
  if player_data["data"] && !player_data["data"].empty?
    player_data["data"].each do |player|
      id = player["id"]
      first_name = player["first_name"]
      last_name = player["last_name"]
      position = player["position"]
      team = player["team"]
      team_name = team ? team["full_name"] : "N/A"

      puts "Player ID: #{id}"
      puts "First Name: #{first_name}"
      puts "Last Name: #{last_name}"
      puts "Position: #{position}"
      puts "Team: #{team_name}"
      puts "-" * 40
    end
  else
    puts "No player data found for '#{first_name} #{last_name}'."
  end
end

# Example usage
puts "Enter the first name of the player you want to search:"
first_name = gets.chomp
puts "Enter the last name of the player you want to search:"
last_name = gets.chomp
player_data = search_player(first_name, last_name)
display_player_data(player_data, first_name, last_name)