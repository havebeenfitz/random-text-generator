import SwiftUI

final class GeneratorModel: ObservableObject {

    @Published var minWordCount = Constants.minWordCountDefault
    @Published var maxWordCount = Constants.maxWordCountDefault
    @Published var maxWordLength = Constants.maxWordLength
    
    @MainActor
    func resetToDefaults() {
        self.minWordCount = Constants.minWordCountDefault
        self.maxWordCount = Constants.maxWordCountDefault
        self.maxWordLength = Constants.maxWordLength
    }
}

// MARK: - Subtypes

enum GenerateResult {
    case succeed
    case failed
}

// MARK: - Private

private struct Constants {
    
    static let minWordCountDefault = "1"
    static let maxWordCountDefault = "100"
    static let maxWordLength = "15"
}
