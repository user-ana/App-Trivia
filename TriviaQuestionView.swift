import SwiftUI

struct TriviaQuestionView: View {
    @State private var selectedOption: String? = nil
    let question: Question
    let currentQuestionIndex: Int
    let totalQuestions: Int
    let onAnswerSelected: (String) -> Void
    let onNext: () -> Void
    let onExit: () -> Void

    var body: some View {
       
        VStack {
            
          
            HStack {
                Spacer()
                Button(action: onExit) {
                    Text("Salir")
                        .foregroundColor(.orange)
                        .font(.headline)
                }
            }
            .padding(.bottom,5) //corregimos qui
            
            Text("\(currentQuestionIndex + 1)/\(totalQuestions)")
                .font(.largeTitle)
                .foregroundColor(.orange)
                .padding(.bottom,10) //aqui too

            Text(question.question)
                .font(.title2)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding()
                .background(Color.white) 

            ForEach([question.optionA, question.optionB, question.optionC, question.optionD ?? ""], id: \.self) { option in
                Button(action: {
                    selectedOption = option
                    onAnswerSelected(option)
                }) {
                    Text(option)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(selectedOption == option ? Color.orange : Color.white)
                        .foregroundColor(selectedOption == option ? Color.white : Color.black) // Texto en negro para visibilidad
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.purple, lineWidth: 2)
                        )
                }
                .padding(.horizontal)
            }

            Button(action: onNext) {
                Text("Siguiente")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
           
        }
        .padding()
        .background(Color(.white))
        .frame(height:600)
         .cornerRadius(20)
       
        .shadow(radius: 10)
        .padding()
    }
        
}
