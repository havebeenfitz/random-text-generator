import SwiftUI

@main
struct RandomFieldApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                GeneratorView()
                    .navigationTitle("Random text generator")
            }
        }
    }
}
