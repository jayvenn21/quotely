import SwiftUI

struct MainPage: View {
    @State private var isDarkMode = false // Default value for isDarkMode
    
    var body: some View {
        TabView {
            AboutView()
                .tabItem {
                    Image(systemName: "info.circle") // System name image for About
                    Text("About")
                }
            HomePage(isDarkMode: $isDarkMode) // Pass the binding variable
                .tabItem {
                    Image(systemName: "house") // System name image for Home
                    Text("Home")
                }
            DatabaseSelectionPage()
                .tabItem {
                    Image(systemName: "book") // System name image for Database
                    Text("Database")
                }
            SettingsPage()
                .tabItem {
                    Image(systemName: "gear") // System name image for Settings
                    Text("Settings")
                }
        }
    }
}

