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
    
    puts "Generated #{flashcards.count} flashcards"
    
    # TODO: Import to database
  end
end
