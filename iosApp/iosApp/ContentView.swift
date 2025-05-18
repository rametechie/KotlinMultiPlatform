import SwiftUI
import Shared

struct ContentView: View {
    @ObservedObject private(set) var viewModel: ViewModel
    
    let phrases = Greeting().greet()

    var body: some View {
        List(phrases: viewModel.greetings)
            .task { await self.viewModel.startObserving() }
    }
}

extension ContentView {
    @MainActor
    class ViewModel: ObservableObject {
        @Published var greetings: Array<String> = []
                                        
        func startObserving() {
            do {
                let sequence = asyncSequence(for: Greeting().greet())
                for try await phrase in sequence {
                    self.greetings.append(phrase)
                }
            } catch {
                print("Failed with error: \(error)")
            }
        }
    }
}

struct ListView: View {
    let phrase: Array<String>
    
    var body: some View {
        List(phrase, id: \.self) {
            Text($0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
