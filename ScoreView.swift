import SwiftUI


struct ScoreView: View {
    let score: Int
    let totalQuestions: Int
    let onRetry: () -> Void

    var body: some View {
        ZStack{
            Image("fondo1")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Juego Terminado")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                Text("Tu puntuación es \(score)/\(totalQuestions)")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                Button(action: onRetry) {
                    Text("Jugar de Nuevo?")
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }
}
