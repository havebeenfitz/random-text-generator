import SwiftUI

@main
struct RandomFieldApp: App {
    
    @StateObject var model = GeneratorModel()
    @StateObject var textGenerator = RandomTextGenerator()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                GeneratorView(model: model)
                    .navigationTitle("Random text generator")
                    .environmentObject(textGenerator)
            }
        }
    }
}
