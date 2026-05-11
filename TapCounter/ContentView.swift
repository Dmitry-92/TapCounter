import SwiftUI

struct ContentView: View {
    @State private var count = 0
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Счётчик нажатий")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("\(count)")
                .font(.system(size: 70, weight: .bold))
                .foregroundColor(.blue)
            
            Button(action: {
                count += 1
            }) {
                Text("Нажми меня")
                    .font(.title2)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Button(action: {
                count = 0
            }) {
                Text("Сбросить")
                    .font(.title2)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
