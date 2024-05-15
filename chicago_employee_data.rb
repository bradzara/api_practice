
require "http"

# Make web request to get chicago employee information. Parse it into array/hash format
chicago_employees = HTTP.get("https://data.cityofchicago.org/resource/xzkq-xp2w.json").parse

# Show/print the job titles in the city
p chicago_employees[10]["job_titles"]

# Loop to find all job titles in Chicago

chicago_employees.each do |job|
  p job["job_titles"]
end
