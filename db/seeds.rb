# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'csv'

puts "Nettoyage de la base de données..."
Riddle.destroy_all
Scenario.destroy_all

puts "Importation des scénarios depuis le CSV..."

csv_file = Rails.root.join('db', 'scenarios.csv')
csv_data = File.read(csv_file)

scenarios_count = 0

CSV.parse(csv_data, headers: true, header_converters: :symbol) do |row|
  Scenario.create!(
    name: row[:name],
    difficulty: row[:difficulty],
    description: row[:description],
    duration: row[:duration],
    total_riddles: row[:total_riddles]
  )
  scenarios_count += 1
end

puts "#{scenarios_count} scénarios créés"

puts "🧩 Importation des riddles depuis le CSV..."

csv_file = Rails.root.join('db', 'riddles.csv')
csv_data = File.read(csv_file)

riddles_count = 0

CSV.parse(csv_data, headers: true, header_converters: :symbol) do |row|
  # Trouvez le scénario correspondant par la difficulté
  scenario = Scenario.find_by(difficulty: row[:difficulty])

  if scenario
    Riddle.create!(
      question: row[:question],
      answer: row[:answer],
      hint: row[:hint],
      difficulty: row[:difficulty],
      scenario: scenario
      # Ajoutez d'autres champs selon votre structure
    )

    riddles_count += 1
  else
    puts "⚠️  Scénario non trouvé pour la difficulté: #{row[:difficulty]}"
  end
end

puts "✅ #{riddles_count} riddles importés"
puts "🎉 Seeds terminés !"
puts "📊 Résumé: #{Scenario.count} scénarios, #{Riddle.count} riddles"
