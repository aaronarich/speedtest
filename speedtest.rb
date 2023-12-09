require 'json'

# Define the command
command = 'speedtest --server-id=1871 --format=json'

# Run the command and capture the output
output = `#{command}`

# Parse the JSON output
begin
  result = JSON.parse(output)
rescue JSON::ParserError => e
  puts "Error parsing JSON: #{e.message}"
  exit 1
end

# Specify the JSON file path
json_file_path = 'output.json'

# Read existing data from the JSON file
existing_data = if File.exist?(json_file_path)
                  JSON.parse(File.read(json_file_path))
                else
                  []
                end

# Append the new result to the existing data
existing_data << result

# Write the updated data back to the JSON file
File.write(json_file_path, JSON.pretty_generate(existing_data))

puts "Output appended to #{json_file_path}"