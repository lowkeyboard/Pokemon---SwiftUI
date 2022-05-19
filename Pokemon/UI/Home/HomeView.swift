//
//  HomeScreen.swift
//  Pokemon
//
//  Created by cagla copuroglu on 17.05.2022.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    @State private var  pokemon = [Pokemon]()
    
    var columns = Array(repeating: GridItem(.flexible()), count: 2)
    @State var categoryIndex = 0
    @State var text = ""
    var categories = ["Category1", "Category2", "Category3", "Category4"]
    
    var body: some View {

        NavigationView {
            ZStack {

                VStack (alignment: .leading){
                    
                    Text(" Pokemon Library")
                        .font(.title)
                        .foregroundColor(.cyan)
                        .padding(.top, 10)
                    
                    SearchBar(text: $searchText)
                        .padding(.top, 20)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 30){
                            ForEach(0..<categories.count, id: \.self){ data in
                                
                                CategoriesView(data: data, index: $categoryIndex)
                            }
                        }
                    }.padding(.top, 30)
                    

                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(searchText == ""
                                    ? pokemon: pokemon.filter({$0.name.lowercased().contains(searchText.lowercased())})
                                    , id:\.self ) {
                                pok in
                                    //SpriteRow(url: pok.url)
    //DetailsView(detailPokemon: pok, index: getIndexOf(pok))

//                                PokemonCell(url: pok.url, name: pok.name, index: self.getIndexOf(pok)).onTapGesture {
//                                    print("Tapped")
//                                }
                                                                
                                NavigationLink(destination:DetailsView(detailPokemon: pok, index: getIndexOf(pok))) {
                                
                                    PokemonCell(url: pok.url, name: pok.name, index: self.getIndexOf(pok))

                                }


                                }
                                }
                        
                            }
                            
                        }
                        
                    }
                
            
            .onAppear {
                NetworkingProvider.share.getPokemons { pokemon in
                    //print(pokemon)
                    self.pokemon = pokemon
                } failure: { error in
                    print(error)
                }
                
        }.padding(.horizontal, 20)
        }
        
        
    }
    
    func getIndexOf(_ pokemonMember: Pokemon) -> Int {
        if let ndx = pokemon.firstIndex(of: pokemonMember) {
            return Int(ndx)
        } else {
            return -1
        }
    }
    
    
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
        
    }
}


