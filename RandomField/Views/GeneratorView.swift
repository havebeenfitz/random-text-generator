import SwiftUI

struct GeneratorView: View {
    
    @StateObject private var generator = RandomTextGenerator()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                VSpacer(Constants.spacerHeight)
                
                Text("Words count:")
                    .font(.caption)
                Text("\(generator.wordsCount)")
                    .font(.body)
                
                VSpacer(Constants.spacerHeight)
                
                Text("Generated and editable text:")
                    .font(.caption)
                TextEditor(text: $generator.text)
                    .textFieldStyle(.roundedBorder)
                    .font(.body)
                    .frame(
                        minHeight: Constants.textEditorMinHeight,
                        maxHeight: .infinity
                    )
            }
            .padding(.horizontal, Constants.padding)
            .padding(.bottom, Constants.buttonSize.height + Constants.padding)
        }
        .overlay(alignment: .bottom) {
            generateButton
        }
        .tint(.green)
    }
    
    private var generateButton: some View {
        Button {
            generator.generateText()
        } label: {
            Text("Generate!")
                .bold()
        }
        .frame(width: Constants.buttonSize.width, height: Constants.buttonSize.height)
        .background(Color.green)
        .foregroundColor(.white)
        .clipShape(
            RoundedRectangle(
                cornerRadius: Constants.buttonSize.height / 2,
                style: .continuous
            )
        )
        .padding(.bottom, Constants.padding)
    }
}

// MARK: - Private

private struct Constants {
    
    static let spacerHeight = 50.0
    static let padding = 20.0
    static let buttonSize = CGSize(width: 300, height: 60)
    static let textEditorMinHeight = 100.0
}

// MARK: - Previews

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        GeneratorView()
    }
}
