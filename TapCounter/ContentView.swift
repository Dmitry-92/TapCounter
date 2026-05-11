import SwiftUI

struct ContentView: View {
    @State private var count = 0
    @State private var isAnimating = false
    @State private var buttonScale: CGFloat = 1.0
    @State private var rotationAngle: Double = 0
    @State private var backgroundColor = Color(.systemBackground)
    
    var body: some View {
        ZStack {
            // Фоновый цвет с анимацией
            backgroundColor
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 0.3), value: backgroundColor)
            
            VStack(spacing: 40) {
                Text("Счётчик нажатий")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                // Анимированное число счётчика
                Text("\(count)")
                    .font(.system(size: 100, weight: .bold, design: .rounded))
                    .foregroundColor(.blue)
                    .scaleEffect(isAnimating ? 1.3 : 1.0)
                    .rotationEffect(.degrees(rotationAngle))
                    .animation(.spring(response: 0.5, dampingFraction: 0.6), value: isAnimating)
                    .animation(.spring(response: 0.5, dampingFraction: 0.6), value: rotationAngle)
                
                // Кнопка "+1" с анимацией
                Button(action: {
                    incrementCount()
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                        Text("Нажми меня")
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                    .padding(.horizontal, 30)
                    .padding(.vertical, 15)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [.green, .mint]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .foregroundColor(.white)
                    .cornerRadius(25)
                    .shadow(color: .green.opacity(0.3), radius: 10, x: 0, y: 5)
                }
                .scaleEffect(buttonScale)
                .animation(.spring(response: 0.3, dampingFraction: 0.4), value: buttonScale)
                
                // Кнопка сброса с анимацией
                Button(action: {
                    resetCount()
                }) {
                    HStack {
                        Image(systemName: "arrow.counterclockwise.circle.fill")
                            .font(.title2)
                        Text("Сбросить")
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                    .padding(.horizontal, 30)
                    .padding(.vertical, 15)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [.red, .orange]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .foregroundColor(.white)
                    .cornerRadius(25)
                    .shadow(color: .red.opacity(0.3), radius: 10, x: 0, y: 5)
                }
                
                // Кнопка "-1" (дополнительная функция)
                Button(action: {
                    decrementCount()
                }) {
                    HStack {
                        Image(systemName: "minus.circle.fill")
                            .font(.title2)
                        Text("Убавить")
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                    .padding(.horizontal, 30)
                    .padding(.vertical, 15)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [.orange, .yellow]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .foregroundColor(.white)
                    .cornerRadius(25)
                    .shadow(color: .orange.opacity(0.3), radius: 10, x: 0, y: 5)
                }
            }
            .padding()
        }
    }
    
    // Функция увеличения счёта с анимацией
    private func incrementCount() {
        // Анимация нажатия кнопки
        buttonScale = 0.95
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            buttonScale = 1.0
        }
        
        // Анимация числа
        isAnimating = true
        count += 1
        
        // Вращение при достижении круглых чисел
        if count % 10 == 0 {
            rotationAngle += 360
        }
        
        // Изменение фона при нажатии
        backgroundColor = Color(.systemGray6)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            backgroundColor = Color(.systemBackground)
        }
        
        // Сброс анимации числа
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isAnimating = false
        }
        
        // Легкая вибрация (опционально, реальное устройство)
        #if os(iOS)
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        #endif
    }
    
    // Функция уменьшения счёта
    private func decrementCount() {
        guard count > 0 else { return }
        
        buttonScale = 0.95
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            buttonScale = 1.0
        }
        
        isAnimating = true
        count -= 1
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isAnimating = false
        }
        
        #if os(iOS)
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        #endif
    }
    
    // Функция сброса с анимацией
    private func resetCount() {
        withAnimation(.spring(response: 0.6, dampingFraction: 0.5)) {
            count = 0
            rotationAngle = 0
        }
        
        backgroundColor = Color(.systemGray5)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            backgroundColor = Color(.systemBackground)
        }
        
        #if os(iOS)
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        #endif
    }
}

#Preview {
    ContentView()
}
