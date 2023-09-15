//
//  ContentView.swift
//  CustomTabView
//
//  Created by Avinash Muralidharan on 15/09/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        CustomTabView([
            TabBarItem(iconName:"house", name: "Home", screen: AnyView(HomeView())),
            TabBarItem(iconName:"magnifyingglass", name: "Search", screen: AnyView(SearchView())),
            TabBarItem(iconName:"person", name: "Profile", screen: AnyView(ProfileView()))
        ])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//
//  CustomTabView.swift
//  Project 5
//
//  Created by Avinash Muralidharan on 14/09/23.
//



struct TabBarItem : Identifiable, Equatable {
    var id = UUID()
    var iconName : String
    var name : String
    var screen : AnyView
  
    static func == (lhs: TabBarItem, rhs: TabBarItem) -> Bool {
        return lhs.id == rhs.id
    }
    
}

struct CustomTabView: View {
    @State private var xOffSet = 0.0
    @State var tabItems : [TabBarItem]
    @State var selected : String
  
    
    var body: some View {
        ZStack{
            VStack{
                ForEach(tabItems){
                    item in
                    if selected == item.name {
                        item.screen
                    }
                }

            }
            
            VStack{
                Spacer()
                HStack{
                    ForEach(tabItems){
                        item in
                        
                        Spacer()

                        Image(systemName: item.iconName)
                            .foregroundColor((Color(UIColor.systemBackground)))
                            .onTapGesture {
                                withAnimation(.spring()){
                                    selected = item.name
                                    xOffSet = CGFloat( tabItems.firstIndex(of:item) ?? 0) * 70.0
                                }
                            
                            }
                        Spacer()
                    }.frame(width: 23.3)
                }
                .frame(height: 70)
                .background(Color(UIColor.label),in:RoundedRectangle(cornerRadius: 20))
                .shadow(color:Color(UIColor.systemFill),radius: 5, x:10 ,y: 10)
                .foregroundColor(Color(UIColor.label))
                .overlay(alignment: .bottomLeading){
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 25,height: 4)
                        .offset(x:23 + xOffSet,y:-7)
                        .foregroundColor((Color(UIColor.systemBackground)))
                }
            }
        }
       
    }
    
    init(_ TabItems : [TabBarItem]){
        _tabItems = State(initialValue:TabItems)
        selected = TabItems[0].name
    }
    
}


struct HomeView : View{
    var body: some View{
        Text("Home")
    }
}

struct SearchView : View{
    var body: some View{
        Text("Search")
    }
}

struct ProfileView : View{
    var body: some View{
        Text("Profile")
    }
}
