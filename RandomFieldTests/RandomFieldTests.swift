import XCTest
@testable import RandomField

final class RandomFieldTests: XCTestCase {
    
    private var sut = RandomTextGenerator()

    override func setUp() {
        sut.text = ""
    }
    
    func testNotEmptyGenerated() async {
        // Act
        await sut.generateText()
        
        // Assert
        XCTAssertNotEqual(sut.wordsCount, 0)
        XCTAssertNotEqual(sut.text.count, 0)
    }

    func testZeroGeneratedText() async {
        // Act
        await sut.generateText(minWordCount: 0, maxWordCount: 0)
        
        // Assert
        XCTAssertEqual(0, sut.wordsCount)
        XCTAssertEqual(0, sut.text.count)
    }
    
    func testEqualBoundsGeneratedText() async {
        // Act
        await sut.generateText(minWordCount: 5, maxWordCount: 5)
        
        // Assert
        XCTAssertEqual(5, sut.wordsCount)
    }
    
    func testWordCountSeparatedBySpaces() async {
        // Act
        await sut.generateText()
                
        // Assert
        let generatedText = sut.text
        let expectedCount = generatedText.split(separator: " ").count
        XCTAssertEqual(expectedCount, sut.wordsCount)
    }
    
    func testTextNotEndingInSpace() async {
        // Act
        await sut.generateText()
        
        // Assert
        let lastSymbol = String(sut.text.last ?? " ")
        let spaceSymbol = " "
        XCTAssertNotEqual(lastSymbol, spaceSymbol)
    }
}
