# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Spree::Core::Engine.load_seed if defined?(Spree::Core)
Spree::Auth::Engine.load_seed if defined?(Spree::Auth)
Spree::Role.find_or_create_by(name: "schüler")
Spree::Role.find_or_create_by(name: "vereinsmitglied")
Spree::Role.find_or_create_by(name: "trainer")
Spree::MenuBar.find_or_create_by(name: "Header")
Spree::MenuBar.find_or_create_by(name: "Footer")
Spree::Store.find_by(code: "sample-store").destroy!
Spree::Store.find_or_create_by(name: "Kinbaku Dojo e.V", url: "kinbaku-berlin.de", code: "kinbaku", mail_from_address: "shop@kinbaku-berlin.de", default_currency: "EUR")
Spree::Taxonomy.find_or_create_by(name: "Level")
Spree::Taxon.find_or_create_by(
  name: "Beginner",
  permalink: "beginner",
  taxonomy_id:Spree::Taxonomy.find_or_create_by(name: "Level").id,
  parent_id: Spree::Taxon.find_by(permalink: "level").id,
  position: 1
)
Spree::Taxon.find_or_create_by(
  name: "Intermediate",
  permalink: "intermediate",
  taxonomy_id: Spree::Taxonomy.find_or_create_by(name: "Level").id,
  parent_id: Spree::Taxon.find_by(permalink: "level").id,
  position: 2
)
Spree::Taxon.find_or_create_by(
  name: "Advanced",
  permalink: "advanced",
  taxonomy_id: Spree::Taxonomy.find_or_create_by(name: "Level").id,
  parent_id: Spree::Taxon.find_by(permalink: "level").id,
  position: 3
)
Spree::Taxonomy.find_or_create_by(name: "Kurstypen")
Spree::Taxon.find_or_create_by(
  name: "Training",
  permalink: "training",
  taxonomy_id: Spree::Taxonomy.find_or_create_by(name: "Kurstypen").id,
  parent_id: Spree::Taxon.find_by(permalink: "kurstypen").id,
)
Spree::Taxon.find_or_create_by(
  name: "Workshop",
  permalink: "workshop",
  taxonomy_id: Spree::Taxonomy.find_or_create_by(name: "Kurstypen").id,
  parent_id: Spree::Taxon.find_by(permalink: "kurstypen").id,
)
Spree::Page.create(
  title: "Start",
  body: "Welcome to our Dojo"
)