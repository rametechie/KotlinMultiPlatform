import SwiftUI
import Shared
import KMPNativeCoroutinesAsync

struct ContentView: View {
    @ObservedObject private(set) var viewModel: ViewModel
    
    let phrases = Greeting().greet()

    var body: some View {
        List(viewModel.greetings, id: \.self) { phrase in
            Text(phrase)
        }
        .task {
            await viewModel.startObserving()
        }
    }
}

extension ContentView {
    @MainActor
    class ViewModel: ObservableObject {
        @Published var greetings: Array<String> = []
                                        
        func startObserving() async{
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
         ContentView(viewModel: ContentView.ViewModel())
    }
}
