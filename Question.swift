import Foundation

struct Question: Identifiable, Decodable {
    let id: Int
    let question: String
    let optionA: String
    let optionB: String
    let optionC: String
    let optionD: String?
    let answer: String

    private enum CodingKeys: String, CodingKey {
        case id
        case question
        case optionA = "option_a"
        case optionB = "option_b"
        case optionC = "option_c"
        case optionD = "option_d"
        case answer
    }
}

