//
//  ContentView.swift
//  SwiftUI Tutorial: Programmatic Scrolling with ScrollViewReader
//
//  Created by Alvin Sosangyo on 03/05/23.
//


import SwiftUI

struct Collections: Identifiable {
    var id = UUID()
    var name: String
    var image: String
}

struct ContentView: View {
    
    let collections = [
        Collections(name: "Humanity", image: "person.fill"),
        Collections(name: "Wild Life", image: "pawprint.fill"),
        Collections(name: "Global", image: "globe.asia.australia.fill"),
        Collections(name: "Energy", image: "bolt.fill"),
        Collections(name: "Nature", image: "leaf.fill"),
        Collections(name: "Weather", image: "cloud.drizzle.fill"),
        Collections(name: "Travel", image: "airplane"),
        Collections(name: "Video Games", image: "gamecontroller.fill"),
        Collections(name: "Health", image: "heart.fill"),
        Collections(name: "Home", image: "house.fill"),
        Collections(name: "Fitness", image: "figure.run"),
        Collections(name: "Commerce", image: "cart"),
        Collections(name: "Time", image: "timer"),
        Collections(name: "Devices", image: "display")
    ]
    
    @State private var goToName: String = ""
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ScrollViewReader { scrollValue in
                gotoBar(scrollValue)
                scrollView()
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    // MARK: - View methods
    
    @ViewBuilder
    private func gotoBar(_ scrollValue: ScrollViewProxy) -> some View {
        HStack {
            TextField("Go to", text: $goToName, onCommit: {
                scrollTo(scrollValue)
            })
            .padding(10)
            .background(Color.white)
            .border(.black)
            Button(action: {
                scrollTo(scrollValue)
            }) {
                Text("Go")
                    .font(.title3)
                    .foregroundColor(Color.white)
                    .padding(10)
            }
            .background(Color.blue)
            .cornerRadius(5)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
    
    @ViewBuilder
    private func scrollView() -> some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                Divider()
                ForEach(collections) { index in
                    itemView(
                        systemName: index.image,
                        text: index.name
                    )
                    .id(index.name)
                    Divider()
                }
            }
        }
    }
    
    @ViewBuilder
    private func itemView(systemName: String, text: String) -> some View {
        HStack {
            Image(systemName: systemName)
                .font(.system(size: 150))
                .padding()
            Text(text)
                .font(.system(.title, design: .rounded))
                .fontWeight(.black)
            Spacer()
        }
    }
    
    // MARK: - Method
    
    private func scrollTo(_ scrollValue: ScrollViewProxy) {
        withAnimation {
            scrollValue.scrollTo(goToName, anchor: .center)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
