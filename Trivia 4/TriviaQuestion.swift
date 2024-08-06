import Foundation
import SwiftUI

struct TriviaQuestion: Identifiable, Decodable {
    let id: Int
    let question: String
    let optionA: String
    let optionB: String
    let optionC: String
    let answer: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case question
        case optionA = "option_a"
        case optionB = "option_b"
        case optionC = "option_c"
        case answer
    }
}

class TriviaViewModel: ObservableObject {
    @Published var questions: [TriviaQuestion] = []

    func fetchQuestions() {
        let client = SupabaseManager.shared.client
        client
            .database
            .from("trivia_questions")
            .select()
            .execute { result in
                switch result {
                case let .success(response):
                    do {
                        let data = try response.decoded(to: [TriviaQuestion].self)
                        DispatchQueue.main.async {
                            self.questions = data
                        }
                    } catch {
                        print("Error decoding data: \(error)")
                    }
                case let .failure(error):
                    print("Error fetching data: \(error)")
                }
            }
    }
}
