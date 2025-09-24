require 'httparty'
require 'json'

class GeminiClient
  BASE_URI = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent"

  def initialize(api_key)
    @api_key = api_key
  end

  def generate_content(prompt)
    body = {
      contents: [
        {
          parts: [
            { text: prompt }
          ]
        }
      ]
    }.to_json

    response = HTTParty.post(
      BASE_URI,
      headers: { 
        'Content-Type' => 'application/json',
        'X-goog-api-key' => @api_key
      },
      body: body,
    )

    if response.success?
      JSON.parse(response.body)
    else
      raise "Erro na API: #{response.code} - #{response.message}"
    end
  
  end
end