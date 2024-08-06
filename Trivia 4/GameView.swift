import SwiftUI
import Supabase

struct GameView: View {
    @State private var questions: [Question] = []
    @State private var currentQuestionIndex: Int = 0
    @State private var score: Int = 0
    @State private var showScore = false
    @State private var loading = true
    @State private var selectedCategory: String? = nil
    @State private var categories: [String] = []
    @State private var categoriesPlayed: [String] = []
    @State private var level: Int = 1
    @State private var showCategories: Bool = true

    var body: some View {
        NavigationView {
            
            VStack {
                if showCategories {
                    if loading {
                        Text("Cargando categorías...")
                            .onAppear {
                                Task {
                                    await loadCategories()
                                }
                            }
                    } else {
                        CategoryView(categories: categories, onCategorySelected: { category in
                            selectedCategory = category
                            loading = true
                            categoriesPlayed.append(category)
                            showCategories = false
                            Task {
                                await loadQuestions(for: category)
                            }
                        })
                    }
                } else if loading {
                    Text("Cargando preguntas...")
                        .onAppear {
                            Task {
                                await loadQuestions(for: selectedCategory!)
                            }
                        }
                } else if showScore {
                    ScoreView(score: score, totalQuestions: questions.count, onRetry: resetGame)
                } else if !questions.isEmpty {
                    VStack {
                        HStack {
                            Text("Puntuación: \(score)")
                                .font(.headline)
                            Spacer()
                            Text("Nivel: \(level)")
                                .font(.headline)
                            Spacer()
                            Text("Jugadas: \(categoriesPlayed.joined(separator: ", "))")
                                .font(.headline)
                            Spacer()
                        }
                        .padding()
                        .background(Color.orange.opacity(0.7))
                        .cornerRadius(10)
                        .padding([.leading, .trailing, .top])

                        TriviaQuestionView(
                            question: questions[currentQuestionIndex],
                            currentQuestionIndex: currentQuestionIndex,
                            totalQuestions: questions.count,
                            onAnswerSelected: handleAnswer,
                            onNext: nextQuestion,
                            onExit: exitToCategories
                        )
                    }
                  
                 .background(Image("fondo1") .resizable()
                        .scaledToFill()
                       .edgesIgnoringSafeArea(.all))
                } else {
                    Text("No hay preguntas disponibles.")
                }
            }
            
           
            .padding()
           .navigationBarHidden(true)  // Ocultar la barra de navegación 
        }
    }

    func loadCategories() async {
        guard let supabaseUrl = URL(string: "https://ygwygryvqmhzvlfyzufc.supabase.co") else {
            print("URL inválida")
            return
        }
        let supabaseKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlnd3lncnl2cW1oenZsZnl6dWZjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjI1NDA4ODcsImV4cCI6MjAzODExNjg4N30.lX9cldydOiUzXG5URPK98vYaQFAZbi9StT8K77wZfmg"

        let client = SupabaseClient(supabaseURL: supabaseUrl, supabaseKey: supabaseKey)

        do {
            let response = try await client
                .from("questions")
                .select("category")
                .execute()

            let data = response.data
            let decoder = JSONDecoder()
            do {
                let categoriesData = try decoder.decode([[String: String]].self, from: data)
                self.categories = Array(Set(categoriesData.compactMap { $0["category"] })).sorted()
                self.loading = false
            } catch {
                print("Error al decodificar JSON: \(error)")
                self.loading = false
            }
        } catch {
            print("Error al cargar categorías: \(error)")
            self.loading = false
        }
    }

    func loadQuestions(for category: String) async {
        guard let supabaseUrl = URL(string: "https://ygwygryvqmhzvlfyzufc.supabase.co") else {
            print("URL inválida")
            return
        }
        let supabaseKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlnd3lncnl2cW1oenZsZnl6dWZjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjI1NDA4ODcsImV4cCI6MjAzODExNjg4N30.lX9cldydOiUzXG5URPK98vYaQFAZbi9StT8K77wZfmg"

        let client = SupabaseClient(supabaseURL: supabaseUrl, supabaseKey: supabaseKey)

        do {
            let response = try await client
                .from("questions")
                .select()
                .eq("category", value: category)
                .execute()

            let data = response.data
            let decoder = JSONDecoder()
            do {
                self.questions = try decoder.decode([Question].self, from: data)
                self.loading = false
            } catch {
                print("Error al decodificar JSON: \(error)")
                self.loading = false
            }
        } catch {
            print("Error al cargar preguntas: \(error)")
            self.loading = false
        }
    }

    func handleAnswer(_ answer: String) {
        if answer == questions[currentQuestionIndex].answer {
            score += 1
            if score % 10 == 0 {
                level += 1
            }
        }
    }

    func nextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
        } else {
            showScore = true
        }
    }

    func resetGame() {
        currentQuestionIndex = 0
        score = 0
        showScore = false
        selectedCategory = nil
        showCategories = true
    }

    func exitToCategories() {
        showCategories = true
        questions = []  // Limpiar las preguntas actuales
    }
}
