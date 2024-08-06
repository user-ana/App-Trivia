import SwiftUI

struct QuestionView: View {
    let question: Question
    let onAnswerSelected: (String) -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text(question.question)
                .font(.title)
            
                .padding()
            Button(action: {
                onAnswerSelected(question.optionA)
            }) {
                Text(question.optionA)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            Button(action: {
                onAnswerSelected(question.optionB)
            }) {
                Text(question.optionB)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            Button(action: {
                onAnswerSelected(question.optionC)
            }) {
                Text(question.optionC)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
      
    }
}
