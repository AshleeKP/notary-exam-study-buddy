class NotaryPdfScraper
  PDF_URL = "https://dos.ny.gov/system/files/documents/2024/05/notary.pdf"
  
  def initialize(pdf_url = PDF_URL)
    @pdf_url = pdf_url
  end
  
  def download_and_parse
    Rails.logger.info "Downloading PDF from #{@pdf_url}..."
    
    response = HTTParty.get(@pdf_url)
    
    if response.success?
      pdf_path = Rails.root.join("tmp", "notary.pdf")
      File.open(pdf_path, "wb") { |file| file.write(response.body) }
      
      Rails.logger.info "PDF downloaded successfully. Parsing..."
      parse_pdf(pdf_path)
    else
      Rails.logger.error "Failed to download PDF: #{response.code}"
      nil
    end
  end
  
  def parse_pdf(pdf_path)
    reader = PDF::Reader.new(pdf_path)
    text_content = reader.pages.map(&:text).join("\n\n")
    
    {
      page_count: reader.page_count,
      text: text_content
    }
  end
  
  def extract_flashcards(content)
    flashcards = []
    
    # Manually curated flashcards from the NY Notary PDF
    # These are key concepts from the License Law document
    
    flashcards << {
      question: "What is the term of a notary public commission in New York?",
      answer: "4 years",
      topic: "Commission and Appointment"
    }
    
    flashcards << {
      question: "How much does a notary public application cost in New York?",
      answer: "$60",
      topic: "Fees and Costs"
    }
    
    flashcards << {
      question: "What is required to be submitted with a notary application?",
      answer: "A pass slip showing that s/he has taken and passed the notary public examination",
      topic: "Application Requirements"
    }
    
    flashcards << {
      question: "Can an attorney become a notary public without taking the examination?",
      answer: "Yes, an individual admitted to practice in NYS as an attorney may be appointed a notary public without an examination",
      topic: "Special Provisions"
    }
    
    flashcards << {
      question: "Where are notaries public commissioned?",
      answer: "In their counties of residence",
      topic: "Jurisdiction"
    }
    
    flashcards << {
      question: "Which official maintains a record of the notary's commission and signature?",
      answer: "The county clerk",
      topic: "Record Keeping"
    }
    
    flashcards << {
      question: "Can notaries take acknowledgments and affidavits over the telephone?",
      answer: "No, it is illegal. The individual making the acknowledgment or affidavit must appear in person before the notary",
      topic: "Professional Conduct"
    }
    
    flashcards << {
      question: "What is the simplest legally acceptable form of an oath?",
      answer: "'Do you solemnly swear that the contents of this affidavit subscribed by you is correct and true?'",
      topic: "Oaths and Affirmations"
    }
    
    flashcards << {
      question: "What can a person who conscientiously declines taking an oath use instead?",
      answer: "An affirmation, such as 'Do you solemnly, sincerely and truly declare and affirm that the statements made by you are true and correct?'",
      topic: "Oaths and Affirmations"
    }
    
    flashcards << {
      question: "What does the seal or stamp of a notary public authenticate?",
      answer: "The official signature of the notary public",
      topic: "Notarial Seal and Signature"
    }
    
    flashcards << {
      question: "Who is NOT eligible to become a notary public in New York?",
      answer: "Any person who has been convicted of a felony or crime involving dishonesty",
      topic: "Disqualifications"
    }
    
    flashcards << {
      question: "What must a notary do before executing any document?",
      answer: "Require the presence of the party whose acknowledgment is being taken, or prove their identity satisfactorily",
      topic: "Professional Conduct"
    }
    
    flashcards
  end
end
