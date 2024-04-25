require "openai"

client = OpenAI::Client.new(access_token: ENV.fetch("OPEN_AI_KEY"))

api_content = ""
api_message = ""
user_response = ""

line = ""
50.times do 
  line = line + "-"
end

puts "Hello! How can I help you today?"
puts line
user_response = gets.chomp

while user_response != "bye"

  # Prepare an Array of previous messages
  
  api_content = api_content + api_message + user_response
  
  message_list = [
    {
      "role" => "system",
      "content" => "You are a helpful assistant."
    },
    {
      "role" => "user",
      "content" => "#{api_content}"
    }
  ]

  # Call the API to get the next message from GPT
  api_response = client.chat(
    parameters: {
      model: "gpt-3.5-turbo",
      messages: message_list
    }
  )

  api_message = api_response.fetch("choices").at(0).fetch("message").fetch("content")

  puts line

  puts api_message

  puts line

  user_response = gets.chomp
end

puts line
puts "Goodbye"
