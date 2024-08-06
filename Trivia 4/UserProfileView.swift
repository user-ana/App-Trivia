import SwiftUI
import Supabase

struct UserProfileView: View {
    @State private var username: String = "Angel Sara"
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack {
            Text("Welcome")
                .font(.title)
                .padding(.top, 20)
            
            VStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.purple)
                    .padding()
                
                Text(username)
                    .font(.title)
                    .padding(.top, 10)
                
                Button(action: {
                    showAlert = true
                }) {
                    Text("Configuración")
                        .padding(6)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.top, 10)
                .sheet(isPresented: $showAlert) {
                    SettingsView()
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 10)
            .padding()
        }
        .background(Image("fondo1").resizable().scaledToFill().ignoresSafeArea())
    }
}
