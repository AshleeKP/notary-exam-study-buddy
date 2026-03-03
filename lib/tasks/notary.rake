namespace :notary do
  desc "Download and parse NY Notary PDF"
  task scrape_pdf: :environment do
    scraper = NotaryPdfScraper.new
    result = scraper.download_and_parse
    
    if result
      puts "✅ PDF parsed successfully!"
      puts "Pages: #{result[:page_count]}"
      puts "\n--- First 2000 characters ---"
      puts result[:text][0..2000]
      puts "\n\nFull text saved to: tmp/notary_content.txt"
      
      File.write(Rails.root.join("tmp", "notary_content.txt"), result[:text])
    else
      puts "❌ Failed to download/parse PDF"
    end
  end
  
  desc "Generate flashcards from PDF content"
  task generate_flashcards: :environment do
    content_path = Rails.root.join("tmp", "notary_content.txt")
    
    unless File.exist?(content_path)
      puts "❌ Content file not found. Run: rake notary:scrape_pdf first"
      exit 1
    end
    
    content = File.read(content_path)
    scraper = NotaryPdfScraper.new
    flashcards = scraper.extract_flashcards(content)
    
    # Create or update 2024 pamphlet version
    pamphlet_version = PamphletVersion.find_or_create_by(year: 2024)
    
    # Clear existing cards for this version
    pamphlet_version.cards.destroy_all
    
    # Import flashcards
    flashcards.each do |card_data|
      Card.create!(
        pamphlet_version: pamphlet_version,
        question: card_data[:question],
        answer: card_data[:answer],
        topic: card_data[:topic]
      )
    end
    
    puts "✅ Generated #{flashcards.count} flashcards"
    puts "✅ Created in PamphletVersion(year=2024)"
  end
end
