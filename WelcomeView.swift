import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
               
                Image("fondo_welcome")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Spacer(minLength: 80)
                    
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250 , height: 250)
                        .padding(.top, 20)

                   
                    VStack {
                        Text("Bienvenidos a Trivia HN")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding([.horizontal, .top])
                        
                        Text("Explora y aprende diferentes categorias de nuestro quiz")
                            .font(.title3)
                            .fontWeight(.medium)
                            .foregroundColor(.orange)
                            .multilineTextAlignment(.center)
                            .padding([.leading, .trailing, .bottom], 20)
                    }

                  
                    NavigationLink(destination: LoginView()) {
                        Text("Empezar juego")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding()
                            .frame(width: 220, height: 55)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.orange]), startPoint: .leading, endPoint: .trailing))
                            .foregroundColor(.white)
                            .cornerRadius(27.5)
                            .shadow(radius: 10)
                    }
                    .padding(.bottom, 40)

                    Spacer(minLength: 50) 
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
