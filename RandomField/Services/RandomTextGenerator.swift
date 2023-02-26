import SwiftUI

final class RandomTextGenerator: ObservableObject {
    
    @Published var text: String = ""
    @Published var wordsCount: Int = 0
    
    private var randomNumberGenerator = SystemRandomNumberGenerator()
    
    init() {
        setupSubscriptions()
    }
    
    
    /// Generate a random string with random characters separated with spaces
    ///
    /// - Parameters:
    ///   - minWordCount: minimum number of wods to generate. Defaults to 1
    ///   - maxWordCount: maximum number of words to generate. Defaults to 100
    ///   - maxWordLength: maximum generated word length. Defaults to 15
    func generateText(minWordCount: Int = 1, maxWordCount: Int = 100, maxWordLength: Int = 15) {
        var finalText = ""
        let wordsCount = Int.random(in: minWordCount ... maxWordCount)
        
        // Max word length should be greater than zero
        assert(maxWordLength > 0)
        
        (0 ..< wordsCount).forEach { counter in
            let wordLength = Int.random(in: 1 ... maxWordLength)
            let generatedWord = (0 ..< wordLength).compactMap { _ in Characters.characters.randomElement() }
            
            finalText += generatedWord
            
            guard counter < wordsCount - 1 else { return }
            
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
