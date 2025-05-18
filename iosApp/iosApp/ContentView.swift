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
    class ViewModel: ObservableObject {
        @Published var greetings: Array<String> = []
                                        
        func startObserving() {
            
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
