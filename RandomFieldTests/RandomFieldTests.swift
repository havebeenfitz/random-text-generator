import XCTest
@testable import RandomField

final class RandomFieldTests: XCTestCase {
    
    private var sut = RandomTextGenerator()

    override func setUp() {
        sut.text = ""
    }
    
    func testNotEmptyGenerated() {
        // Act
        sut.generateText()
        
        // Assert
        
        XCTAssertNotEqual(sut.wordsCount, 0)
        XCTAssertNotEqual(sut.text.count, 0)
    }

    func testMinimumGeneratedText() {
        // Act
        
        sut.generateText(maxWordCount: 1, maxWordLength: 1)
        
        // Assert
        
        let expected = 1
        
        XCTAssertEqual(expected, sut.wordsCount)
        XCTAssertEqual(expected, sut.text.count)
    }
    
    func testRealWordCount() {
        sut.generateText()
        
        let generatedText = sut.text
        let expectedCount = generatedText.split(separator: " ").count
        
        
        XCTAssertEqual(expectedCount, sut.wordsCount)
    }
}
