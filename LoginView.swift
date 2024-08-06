import SwiftUI
import Supabase

struct User: Decodable {
    let email: String
    let password: String
}

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    @State private var showSignUp = false
    @State private var showGameView = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var playerName = ""
    
    let client = SupabaseClient(supabaseURL: URL(string: "https://ygwygryvqmhzvlfyzufc.supabase.co")!,
    supabaseKey:"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlnd3lncnl2cW1oenZsZnl6dWZjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjI1NDA4ODcsImV4cCI6MjAzODExNjg4N30.lX9cldydOiUzXG5URPK98vYaQFAZbi9StT8K77wZfmg")
    
    var body: some View {
        GeometryReader {
            geometry in
            
            NavigationStack {
                ZStack {
                    Image("fondo1")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        Spacer()
                        
                        // Header
                        Text("Bienvenido")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                            .padding(.bottom, 20)
                        
                        // Subtítulo
                        Text("Inicia sesion, y explora nuevos conocimientos")
                            .font(.title3)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                            .padding(.bottom, 20)
                        
                        
                        TextField("Email", text: $email)
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .padding(.bottom, 20)
                        
                        // Password field with show/hide functionality
                        ZStack(alignment: .trailing) {
                            if isPasswordVisible {
                                TextField("Password", text: $password)
                                    .padding()
                                    .background(Color.white.opacity(0.2))
                                    .cornerRadius(10)
                                    .foregroundColor(.white)
                            } else {
                                SecureField("Password", text: $password)
                                    .padding()
                                    .background(Color.white.opacity(0.2))
                                    .cornerRadius(10)
                                    .foregroundColor(.white)
                            }
                            
                            Button(action: {
                                isPasswordVisible.toggle()
                            }) {
                                Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(.white)
                                    .padding()
                            }
                        }
                        .padding(.bottom, 20)
                        
                        // Login button
                        Button(action: {
                            loginUser(email: email, password: password)
                        }) {
                            Text("Iniciar Sesión")
                                .font(.title2)
                                .bold()
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.bottom, 20)
                        
                        // Sign up link
                        HStack {
                            Text("¿No tienes cuenta?")
                                .foregroundColor(.gray)
                            Button(action: {
                                showSignUp = true
                            }) {
                                Text("Crear una")
                                    .foregroundColor(.orange)
                            }
                        }
                        .padding(.top, 20)
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color.black.opacity(0.6)) // Fondo negro semitransparente
                    .cornerRadius(20)
                    .padding()
                    .frame(height: 600) // para que el cuadro no tenga mucha altura
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
                .navigationDestination(isPresented: $showGameView) {
                    GameView()
                }
                .navigationDestination(isPresented: $showSignUp) {
                    SignUpView()
                }
            }
            .navigationBarHidden(true) // para que no se me pongan dos black
        }
        
    }
        func loginUser(email: String, password: String) {
            Task {
                do {
                    let response = try await client
                        .from("users") // el nombre que le tengo a la tabla en la db
                        .select()
                        .eq("email", value: email)
                        .eq("password", value: password)
                        .execute()
                    
                    // Decodificar la respuesta
                    do {
                        let users = try JSONDecoder().decode([User].self, from: response.data)
                        
                        if !users.isEmpty {
                            
                            DispatchQueue.main.async {
                                showGameView = true
                            }
                        } else {
                            
                            DispatchQueue.main.async {
                                alertMessage = "Credenciales incorrectas. Inténtalo de nuevo."
                                showAlert = true
                            }
                        }
                    } catch {
                        DispatchQueue.main.async {
                            alertMessage = "Error al decodificar los datos. Inténtalo de nuevo."
                            showAlert = true
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        alertMessage = "Error al iniciar sesión. Inténtalo de nuevo."
                        showAlert = true
                    }
                }
            }
        }
    }
    
    
    struct LoginView_Previews: PreviewProvider {
        static var previews: some View {
            LoginView()
        }
    }
    
