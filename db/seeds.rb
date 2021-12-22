# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Rails.env.development?
  AdminUser.create(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

  curations = (1..5).map do |_k|
    Curation.create!(title: Faker::Book.genre, description: Faker::Books::Dune.quote)
  end

  boards = (1..20).map do |_k|
    curation = curations.sample
    Board.create!(curation: curation, category: Faker::Book.title, description: Faker::Books::Dune.saying)
  end

  _notices = (1..1010).map do |_k|
    board = boards.sample
    Notice.create!(board: board, title: Faker::Books::Lovecraft.sentence)
  end
end
