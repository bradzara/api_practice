require 'http'
require 'json'
require 'pp'

url = "https://calendarific.com/api/v2/holidays?api_key=rLRFOR3z27eIRRbVu5OueUywb7HTTMBh&country=US&year=2019"
response = HTTP.get(url)

# Parse the JSON response
holidays_data = JSON.parse(response.body.to_s)

if holidays_data["response"] && holidays_data["response"]["holidays"]
  holidays = holidays_data["response"]["holidays"]

  # Iterate over each holiday and print specific data
  holidays.each do |holiday|
    name = holiday["name"]
    date = holiday["date"]["iso"]
    puts "Holiday: #{name}, Date: #{date}"
  end
else
  puts "No holidays data found in the response."
end