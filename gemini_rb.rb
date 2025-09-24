require_relative 'lib/app'

arg = ARGV[0]
app = App.new

if arg == '--history'
  app.show_history
elsif arg.nil? || arg.strip.empty?
  puts "Por favor, forneça um prompt ou use --history."
else
  app.generate_and_save(arg)
end

app.close