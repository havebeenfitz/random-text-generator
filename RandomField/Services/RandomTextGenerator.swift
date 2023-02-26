import SwiftUI

final class RandomTextGenerator: ObservableObject {
    
    @Published var text: String = ""
    @Published var wordsCount: Int = 0
    
    private var randomNumberGenerator = SystemRandomNumberGenerator()
    
    init() {
        setupSubscriptions()
    }
    
    
    /// Generate a random string with random characters divided with spaces
    /// - Parameters:
    ///   - maxWordCount: maximum words to generate
    ///   - maxWordLength: maximum word length
    func generateText(maxWordCount: Int = 100, maxWordLength: Int = 15) {
        var finalText = ""
        let wordsCount = Int.random(in: 1 ... maxWordCount)
        
        (1 ... wordsCount).forEach { counter in
            let wordLength = Int.random(in: 1 ... maxWordLength)
            let generatedWord = (0 ..< wordLength).compactMap { _ in Characters.characters.randomElement() }
            
            finalText += generatedWord
            
            guard counter < wordsCount else { return }
            
            finalText += " "
        }
        
        self.wordsCount = wordsCount
        self.text = finalText
    }
}

// MARK: - Methods

private extension RandomTextGenerator {
    
    private func setupSubscriptions() {
        $text
            .map { $0.split(separator: " ").count }
            .assign(to: &$wordsCount)
    }
}

// MARK: - Subtypes

private extension RandomTextGenerator {
    
    enum Characters {
        
        static let scalars = [
            UnicodeScalar("a").value...UnicodeScalar("z").value,
            UnicodeScalar("A").value...UnicodeScalar("Z").value,
            UnicodeScalar("0").value...UnicodeScalar("9").value
        ].joined()
        
        static let characters = scalars.map { Character(UnicodeScalar($0)!) }
    }
}
