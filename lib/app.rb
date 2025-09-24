require_relative 'gemini_client'
require_relative 'database'
require 'dotenv/load'

class App
  def initialize
    @api_key = ENV['GOOGLE_API_KEY']
    @db = Database.new(
      host: 'localhost',
      dbname: 'gemini_db',
      user: 'postgres',
      password: 'postgres'
    )
    @db.create_table
    @client = GeminiClient.new(@api_key)
  end

  def generate_and_save(prompt)
    response = @client.generate_content(prompt)
    treated_response = response["candidates"][0]["content"]["parts"][0]["text"]
    record = @db.insert(prompt, treated_response)
    puts "Prompt: #{prompt}"
    puts "Resposta: #{treated_response}"
    puts "Salvo no banco: ID=#{record['id']} em #{record['created_at']}"
  end

  def show_history
    history = @db.get_all
    if history.empty?
      puts "Nenhum registro encontrado."
    else
      history.each do |row|
        puts "=============================="
        puts "ID: #{row['id']}"
        puts "Prompt: #{row['prompt']}"
        puts "Response: #{row['response']}"
        puts "Created At: #{row['created_at']}"
      end
      puts "=============================="
    end
  end

  def close
    @db.close
  end
end
