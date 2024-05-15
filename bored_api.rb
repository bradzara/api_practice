require "http"

random = HTTP.get("http://www.boredapi.com/api/activity/").parse

p random