import SwiftUI

struct CategoryView: View {
    let categories: [String]
 
    let onCategorySelected: (String) -> Void
    @State private var expanded = false // Controla si se muestran todas las categorías o no
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
     
        GeometryReader { geometry in
            ZStack {
                Image("fondo1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Spacer(minLength: 50) // Espacio en la parte superior

                    Text("Explora las Categorías")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top)
                    
                  
                                   
                                 

                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(expanded ? categories : Array(categories.prefix(6)), id: \.self) { category in
                                Button(action: {
                                    onCategorySelected(category)
                                }) {
                                    VStack {
                                        if category == "Honduras" {
                                            Image("bandera")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 50, height: 50)
                                                .padding()
                                        } else {
                                            Image(systemName: getCategoryIcon(category))
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 50, height: 50)
                                                .padding()
                                        }
                                        Text(category)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue.opacity(0.3)) // Fondo semi-transparente para cada botón
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                                }
                            }
                        }
                        .padding()
                    }

                    // Botón para alternar la vista de categorías
                    Button(action: {
                        expanded.toggle()
                    }) {
                        HStack(spacing: 5) {
                            Image(systemName: expanded ? "chevron.up" : "chevron.down")
                            Text(expanded ? "Ver menos" : "Ver más")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                    }
                    .padding(.bottom, 20)
                    
                    Spacer() // Empuja todo hacia arriba
                }
                .padding(.horizontal)
            }
        }
        .edgesIgnoringSafeArea(.all) // Asegurarse de que cubra todos los bordes
    }
    
    func getCategoryIcon(_ category: String) -> String {
        switch category {
        case "Geografía":
            return "globe"
        case "Matemáticas":
            return "sum"
        case "Literatura":
            return "book"
        case "Historia":
            return "clock"
        case "Música":
            return "music.note"
        case "Ciencia":
            return "flask"
        case "Informática":
            return "desktopcomputer"
        case "Bases de Datos":
            return "server.rack"
        case "Programación Web":
            return "globe"
        case "Arte":
            return "paintbrush"
        case "Deportes":
            return "sportscourt"
        case "Cultura":
            return "person.3.fill"
        case "Economía":
            return "banknote"
        default:
            return "questionmark"
        }
    }
}

