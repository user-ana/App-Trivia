
import SwiftUI
import Supabase

struct SignUpView: View {
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isPasswordVisible = false
    @State private var isConfirmPasswordVisible = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    let client = SupabaseClient(supabaseURL: URL(string: "https://ygwygryvqmhzvlfyzufc.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlnd3lncnl2cW1oenZsZnl6dWZjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjI1NDA4ODcsImV4cCI6MjAzODExNjg4N30.lX9cldydOiUzXG5URPK98vYaQFAZbi9StT8K77wZfmg")

    var body: some View {
        NavigationStack {
            ZStack {
                Image("fondo1")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    VStack(spacing: 20) {
                        HStack {
                            Spacer() // This spacer pushes the button to the right
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .padding(.top)
                            }
                            .padding(.trailing, 20) // Add padding to align the button inside the form
                        }
                        
                        Image(systemName: "person.crop.circle.fill.badge.plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.orange)
                            .padding(.bottom, 20)

                        Text("Crear cuenta")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)

                        Text("Únete y comienza a explorar hoy")
                            .font(.title3)
                            .foregroundColor(.gray)
                            .padding(.bottom, 20)

                        TextField("Correo Electrónico", text: $email)
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(10)
                            .foregroundColor(.white)

                        TextField("Nombre de Usuario", text: $username)
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(10)
                            .foregroundColor(.white)

                        passwordField("Contraseña", text: $password, isVisible: $isPasswordVisible)
                        passwordField("Confirmar Contraseña", text: $confirmPassword, isVisible: $isConfirmPasswordVisible)

                        Button(action: {
                            handleRegistration()
                        }) {
                            Text("Crear Cuenta")
                                .font(.title2)
                                .bold()
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    .background(Color.black.opacity(0.6))
                    .cornerRadius(20)
                    .padding()
                    .frame(height: 600)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }
                }
            }
        }
    }

    func passwordField(_ label: String, text: Binding<String>, isVisible: Binding<Bool>) -> some View {
        ZStack(alignment: .trailing) {
            if isVisible.wrappedValue {
                TextField(label, text: text)
                    .padding()
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(10)
                    .foregroundColor(.white)
            } else {
                SecureField(label, text: text)
                    .padding()
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }

            Button(action: {
                isVisible.wrappedValue.toggle()
            }) {
                Image(systemName: isVisible.wrappedValue ? "eye.slash.fill" : "eye.fill")
                    .foregroundColor(.white)
                    .padding()
            }
        }
    }

    func handleRegistration() {
        if password == confirmPassword {
            registerUser(username: username, email: email, password: password)
        } else {
            alertMessage = "Las contraseñas no coinciden. Inténtalo de nuevo."
            showAlert = true
        }
    }

    func registerUser(username: String, email: String, password: String) {
        Task {
            do {
                let response = try await client
                    .from("users")
                    .insert([
                        "username": username,
                        "email": email,
                        "password": password
                    ])
                    .execute()

                if response.status == 201 {
                    DispatchQueue.main.async {
                        presentationMode.wrappedValue.dismiss()
                    }
                } else {
                    DispatchQueue.main.async {
                        alertMessage = "Error al registrar el usuario. Inténtalo de nuevo."
                        showAlert = true
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    alertMessage = "Error al registrar el usuario. Inténtalo de nuevo."
                    showAlert = true
                }
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
