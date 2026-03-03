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
    
    # === APPOINTMENT & COMMISSION ===
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
    
    # === PROFESSIONAL CONDUCT & PROHIBITED ACTIONS ===
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
    
    # === PROHIBITED CONDUCT ===
    flashcards << {
      question: "Can a notary give legal advice?",
      answer: "No, unless the notary is an attorney licensed to practice law. A notary public may not give legal advice about any matter",
      topic: "Prohibited Conduct"
    }
    
    flashcards << {
      question: "Can a notary ask for or receive legal business from clients?",
      answer: "No, a notary public may not ask for and get legal business to send to a lawyer",
      topic: "Prohibited Conduct"
    }
    
    flashcards << {
      question: "Can a notary divide or share fees with a lawyer?",
      answer: "No, a notary public may not divide or agree to divide fees with a lawyer, or accept any compensation from a lawyer",
      topic: "Prohibited Conduct"
    }
    
    flashcards << {
      question: "Can a notary advertise themselves as providing legal services?",
      answer: "No (unless they are an attorney), a notary public may not advertise in any manner any legal services or papers",
      topic: "Prohibited Conduct"
    }
    
    flashcards << {
      question: "Unless they are a lawyer, what practice of law is prohibited to notaries?",
      answer: "Notaries (unless lawyers) may not engage directly or indirectly in the practice of law",
      topic: "Prohibited Conduct"
    }
    
    # === ACKNOWLEDGMENTS ===
    flashcards << {
      question: "Can a notary use an acknowledgment of a will as an attestation clause?",
      answer: "No, such acknowledgment cannot be deemed equivalent to an attestation clause accompanying a will",
      topic: "Acknowledgments and Attestations"
    }
    
    flashcards << {
      question: "What principle governs the importance of proper notarial acknowledgments?",
      answer: "Upon the faith of these acknowledgments rests the title of real property. The only security is the fidelity of notaries in requiring parties' presence",
      topic: "Acknowledgments and Attestations"
    }
    
    # === POWERS AND DUTIES ===
    flashcards << {
      question: "What are the main powers of a notary public?",
      answer: "To take acknowledgments and proofs of deeds, mortgages, powers of attorney and other instruments in writing; to demand acceptance or payment of foreign and inland bills",
      topic: "Powers and Duties"
    }
    
    flashcards << {
      question: "Can a notary use foreign language terms in a notarial act?",
      answer: "No, a notary public shall not use terms in a foreign language in any notarial act",
      topic: "Professional Conduct"
    }
    
    # === JURISDICTIONAL RULES ===
    flashcards << {
      question: "What can a notary public with residence in NY but working in another county do?",
      answer: "They may elect to file a certificate of official character with other New York State county clerks",
      topic: "Jurisdiction"
    }
    
    flashcards << {
      question: "Can non-residents become notaries public in New York?",
      answer: "Yes, nonresidents who have offices or places of business in New York State may become notaries. The oath must be filed in the county where the office is located",
      topic: "Jurisdiction"
    }
    
    # === SPECIAL PROVISIONS ===
    flashcards << {
      question: "What happens if a notary moves out of state but maintains an office in NY?",
      answer: "They do not vacate their office as a notary public if they still maintain a place of business or office in New York State",
      topic: "Special Provisions"
    }
    
    flashcards << {
      question: "What is required from a nonresident notary who ceases to maintain a NY office?",
      answer: "They vacate their office as a notary public and surrender their commission",
      topic: "Special Provisions"
    }
    
    flashcards << {
      question: "What education requirement must a notary public applicant meet?",
      answer: "The applicant must have the equivalent of a common school education",
      topic: "Qualifications"
    }
    
    # === VOCABULARY & DEFINITIONS ===
    flashcards << {
      question: "What is an acknowledgment?",
      answer: "A notarial act by which the notary witnesses the signature of the signer and confirms their identity and willingness to sign a document",
      topic: "Vocabulary"
    }
    
    flashcards << {
      question: "What is an affidavit?",
      answer: "A written statement made under oath or affirmation before a notary public, declaring facts the affiant believes to be true",
      topic: "Vocabulary"
    }
    
    flashcards << {
      question: "What is a jurat?",
      answer: "A notarial certificate attached to an affidavit stating that the affiant swore or affirmed to it before the notary public",
      topic: "Vocabulary"
    }
    
    flashcards << {
      question: "What is an attestation clause?",
      answer: "A clause used to introduce witness signatures to a will or other document (not an acknowledgment)",
      topic: "Vocabulary"
    }
    
    flashcards << {
      question: "What is a certificate of acknowledgment?",
      answer: "A written statement by the notary confirming that the person whose signature is being acknowledged appeared before the notary and executed the document",
      topic: "Vocabulary"
    }
    
    flashcards << {
      question: "What is a notarial seal?",
      answer: "An embossed, stamped, or printed mark made by the notary to identify the notary public and authenticate notarial acts",
      topic: "Vocabulary"
    }
    
    flashcards << {
      question: "What is a commission?",
      answer: "Official authorization from the Secretary of State appointing a person as a notary public for a 4-year term",
      topic: "Vocabulary"
    }
    
    flashcards << {
      question: "What is the principal in a notarial act?",
      answer: "The person whose signature is being notarized or who is appearing before the notary (the party requesting notarization)",
      topic: "Vocabulary"
    }
    
    flashcards << {
      question: "What is proof of execution?",
      answer: "A notarial act certifying that the notary witnessed the signature and identity of the person whose signature is being proved",
      topic: "Vocabulary"
    }
    
    flashcards << {
      question: "What is a certificate of official character?",
      answer: "A document filed with county clerks certifying that a notary public is duly commissioned and authorized to perform notarial acts",
      topic: "Vocabulary"
    }
    
    flashcards << {
      question: "What does it mean to notarize?",
      answer: "To authenticate or certify a document or signature through the performance of a notarial act by a commissioned notary public",
      topic: "Vocabulary"
    }
    
    flashcards << {
      question: "What is a taker of an affidavit?",
      answer: "The notary public who administers the oath or affirmation to the affiant",
      topic: "Vocabulary"
    }
    
    flashcards << {
      question: "What is the difference between an oath and an affirmation?",
      answer: "An oath invokes a divine being as witness to the truth; an affirmation is a solemn promise without religious reference, equally binding",
      topic: "Vocabulary"
    }
    
    flashcards << {
      question: "What is execution of a document?",
      answer: "The act of signing a document with the intent to be bound by its terms",
      topic: "Vocabulary"
    }
    
    flashcards
  end
end
