import SwiftUI

struct BetterCallSaulQuote: Codable {
    let quote: String
    let author: String
}

struct BCSSelectionPage: View {
    @State private var randomQuote: BetterCallSaulQuote?
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        VStack {
            Text("Better Call Saul")
                .font(.custom("Avenir-Black", size: 34)) // Avenir-Black font for the title
                .padding()

            if let quote = randomQuote {
                VStack {
                    Text("\"\(quote.quote)\"")
                        .font(.custom("Avenir-Black", size: 24)) // Avenir-Black font for the headline
                        .multilineTextAlignment(.center)
                        .padding()
                    Text("- \(quote.author)")
                        .font(.custom("Avenir-Black", size: 18)) // Avenir-Black font for the subheadline
                        .foregroundColor(.secondary)
                }
            } else {
                Text("Tap the button to generate a quote")
                    .font(.custom("Avenir-Black", size: 18)) // Avenir-Black font for the text
                    .foregroundColor(.gray)
                    .padding()
            }

            Button("Generate Quote") {
                fetchRandomQuote()
            }
            .font(.custom("Avenir-Black", size: 18)) // Avenir-Black font for the button text
            .padding()
        }
    }

    func fetchRandomQuote() {
        guard let url = URL(string: "https://bcs-quotes.vercel.app/api/quotes") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                let quotes = try JSONDecoder().decode([BetterCallSaulQuote].self, from: data)
                if let quote = quotes.first {
                    DispatchQueue.main.async {
                        self.randomQuote = quote
                    }
                }
            } catch {
                print("Failed to decode response: \(error)")
            }
        }.resume()
    }
}

struct BCSSelectionPage_Previews: PreviewProvider {
    static var previews: some View {
        BCSSelectionPage()
    }
}

