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
RiddlesScenario.destroy_all
Riddle.destroy_all
Scenario.destroy_all

puts "Importation des scénarios depuis le CSV..."


csv_scenarios = Rails.root.join('db', 'scenarios.csv')

# Vérifier que le fichier existe
unless File.exist?(csv_scenarios)
  puts "ERREUR : Le fichier #{csv_scenarios} n'existe pas !"
  exit
end

scenarios_count = 0

CSV.foreach(csv_scenarios, headers: :first_row, col_sep: ';') do |row|
  Scenario.create!(
    theme: row['theme'],
    difficulty: row['difficulty'],
    description: row['description'],
    duration: row['duration'],
    total_riddles: row['total_riddles']
  )

  scenarios_count += 1
end

puts "#{scenarios_count} scénarios créés"

puts "Importation des riddles depuis le CSV..."

csv_riddles = Rails.root.join('db', 'riddles.csv')


riddles_count = 0

position = 1

# Récupérer le premier scénario
first_scenario = Scenario.first

if first_scenario.nil?
  puts "Aucun scénario trouvé. Impossible d'associer les riddles."
else
  CSV.foreach(csv_riddles, headers: :first_row, col_sep: ';') do |row|
    riddle = Riddle.create!(
      theme: row['theme'],
      title: row['title'],
      question: row['question'],
      answer: row['answer'],
      hint: row['hint'],
      lesson: row['lesson']
    )

    # Créer l'association avec la position
    RiddlesScenario.create!(
      riddle: riddle,
      scenario: first_scenario,
      riddle_position: position
    )

    riddles_count += 1
    position += 1
  end

  puts "#{riddles_count} riddles importés et associés au scénario '#{first_scenario.theme}'"
end

puts "Seeds terminés !"
