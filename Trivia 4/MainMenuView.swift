import SwiftUI

struct MainMenuView: View {
    var body: some View {
        VStack {
            // Header
            VStack {
                Text("¡Bienvenido a Trivia Quiz HN!")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.top, 40)
                
                Text("Pon a prueba tus conocimientos y compite con otros jugadores en diversas categorías.")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
            }
            
            // TabView
            TabView {
                CategoriesView()
                    .tabItem {
                        Image(systemName: "list.dash")
                        Text("Categorías")
                       
                    }
                userProfileView()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Perfil")
                    }
                UserManualView()
                    .tabItem {
                        Image(systemName: "book.fill")
                        Text("Manual")
                    }
                CreatorsView()
                    .tabItem {
                        Image(systemName: "info.circle.fill")
                        Text("Creadores")
                    }
                settingsView()
                    .tabItem {
                        Image(systemName: "gearshape.fill")
                        Text("Ajustes")
                    }
            }
            .accentColor(.purple) // Color de acento para los elementos seleccionados
            .foregroundColor(.orange)
        }
        .background(Color.black.ignoresSafeArea())
    }
}

struct CategoriesView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack {
                    Text("Categorías")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                    Spacer()
                    // Añadir más contenido aquí
                    NavigationLink(destination: GameView()) {
                        Text("Ir al Juego")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.purple)
                            .cornerRadius(10)
                    }
                    Spacer()
                }
            }
        }
    }
}
struct userProfileView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Spacer()
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.purple)
                    .padding()
                Text("Nombre Apellido")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                Text("username@example.com")
                    .font(.title2)
                    .foregroundColor(.gray)
                Spacer()
                // Añadir más contenido aquí
            }
        }
    }
}

struct UserManualView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Text("Manual de Usuario")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                Spacer()
                // Añadir más contenido aquí
            }
        }
    }
}

struct CreatorsView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Text("Creadores de la App")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                Spacer()
                // Añadir más contenido aquí
            }
        }
    }
}

struct settingsView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Text("Ajustes")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                Spacer()
                // Añadir más contenido aquí
            }
        }
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
