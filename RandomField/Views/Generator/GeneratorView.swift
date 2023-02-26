import SwiftUI

struct GeneratorView: View {

    @EnvironmentObject var generator: RandomTextGenerator
    @ObservedObject var model: GeneratorModel

    @State private var isAlertPresented = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                VSpacer(Constants.spacerHeight)
                parametersTextFields
                VSpacer(Constants.spacerHeight)
                wordsCountText
                VSpacer(Constants.spacerHeight)
                generatedTextEditor
            }
            .padding(.horizontal, Constants.padding)
            .padding(.bottom, Constants.buttonSize.height + Constants.padding)
        }
        .overlay(alignment: .bottom) {
            generateButton
        }
        .alert(
            "Check your parameters",
            isPresented: $isAlertPresented,
            actions: {
                Button("Ok") {
                    model.resetToDefaults()
                }
            }
        )
        .scrollDismissesKeyboard(.interactively)
        .tint(.green)
    }
}

// MARK: - Private

private extension GeneratorView {
    
    @ViewBuilder
    var parametersTextFields: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("min words")
                    .font(.caption2)
                TextField("", text: $model.minWordCount)
            }
            VStack(alignment: .leading) {
                Text("max words")
                    .font(.caption2)
                TextField("", text: $model.maxWordCount)
            }
            VStack(alignment: .leading) {
                Text("max word length")
                    .font(.caption2)
                TextField("", text: $model.maxWordLength)
                   
            }
        }
        .keyboardType(.numberPad)
    }
    
    @ViewBuilder
    var wordsCountText: some View {
        Text("Words count:")
            .font(.caption)
        Text("\(generator.wordsCount)")
            .font(.body)
    }
    
    @ViewBuilder
    var generatedTextEditor: some View {
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
    
    var generateButton: some View {
        Button {
            generate()
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

private extension GeneratorView {
    
    func generate() {
        Task {
            guard
                let minWords = Int(model.minWordCount),
                let maxWords = Int(model.maxWordCount),
                let maxWordLength = Int(model.maxWordLength)
            else {
                isAlertPresented = true
                return
            }
            
            await generator.generateText(
                minWordCount: minWords,
                maxWordCount: maxWords,
                maxWordLength: maxWordLength
            )
        }
    }
}

// MARK: - Constants

private struct Constants {
    static let spacerHeight = 50.0
    static let padding = 20.0
    static let buttonSize = CGSize(width: 300, height: 60)
    static let textEditorMinHeight = 100.0
}

// MARK: - Previews

struct ContentView_Previews: PreviewProvider {
    
    @StateObject static var model = GeneratorModel()
    @StateObject static var textGenerator = RandomTextGenerator()
    
    static var previews: some View {
        GeneratorView(model: model)
            .environmentObject(textGenerator)
    }
}
