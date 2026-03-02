# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Clear existing data
puts "Clearing existing data..."
CardResult.destroy_all
StudySession.destroy_all
Card.destroy_all
PamphletVersion.destroy_all

# Create 2024 pamphlet version
puts "Creating pamphlet version..."
pamphlet_2024 = PamphletVersion.create!(
  year: 2024,
  description: "NY Notary Public License Law - 2024 Edition"
)

# Create sample notary exam cards
puts "Creating sample cards..."

cards_data = [
  {
    topic: "Notary Basics",
    question: "What is the term of office for a New York notary public?",
    answer: "Four years"
  },
  {
    topic: "Notary Basics",
    question: "What is the fee a notary may charge for administering an oath or affirmation?",
    answer: "$2.00"
  },
  {
    topic: "Notary Duties",
    question: "What must a notary do before taking office?",
    answer: "File an oath of office and official signature with the county clerk"
  },
  {
    topic: "Notary Duties",
    question: "Can a notary notarize their own signature?",
    answer: "No, a notary cannot notarize their own signature"
  },
  {
    topic: "Notary Powers",
    question: "What are the three main duties of a notary public?",
    answer: "Administer oaths and affirmations, take affidavits and depositions, and receive and certify acknowledgments"
  },
  {
    topic: "Requirements",
    question: "What is the minimum age to become a notary public in New York?",
    answer: "18 years old"
  },
  {
    topic: "Requirements",
    question: "Must a notary public be a U.S. citizen?",
    answer: "No, but they must be a resident of New York State or have an office/place of business in New York"
  },
  {
    topic: "Fees",
    question: "What is the maximum fee for taking an acknowledgment?",
    answer: "$2.00"
  },
  {
    topic: "Certificates",
    question: "What information must be included in a notarial certificate?",
    answer: "The venue (state and county), the date, the notary's signature and printed name, and the notary's commission expiration date"
  },
  {
    topic: "Misconduct",
    question: "What is the penalty for a notary who commits misconduct?",
    answer: "Possible removal from office, criminal prosecution, and civil liability"
  },
  {
    topic: "Journal",
    question: "Is a notary required to keep a journal in New York?",
    answer: "No, but it is highly recommended as a best practice"
  },
  {
    topic: "Identification",
    question: "What types of identification are acceptable for notarization?",
    answer: "A valid driver's license, passport, or other government-issued photo ID"
  }
]

cards_data.each do |card_data|
  pamphlet_2024.cards.create!(card_data)
end

puts "✅ Seed data created successfully!"
puts "   - 1 pamphlet version (2024)"
puts "   - #{cards_data.count} sample cards"
