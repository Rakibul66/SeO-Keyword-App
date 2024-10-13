import SwiftUI

struct SEOKeywordView: View {
    @StateObject private var viewModel = SEOKeywordViewModel()
    @State private var keyword: String = "" // State variable for user input

    var body: some View {
        VStack {
            // Search Field
            TextField("Enter a keyword...", text: $keyword)
                .padding()
                .background(Color.white) // Background for the text field
                .cornerRadius(10)
                .padding(.horizontal)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(hex: "902227"), lineWidth: 2) // Border color
                )

            // Search Button
            Button(action: {
                viewModel.fetchKeywords(for: keyword) // Use the input keyword to fetch keywords
            }) {
                Text("Search")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(hex: "902227"))
                    .cornerRadius(10)
            }
            .padding(.horizontal)

            // Progress Indicator or Results
            if viewModel.keywords.isEmpty {
                ProgressView()
                    .onAppear {
                        viewModel.fetchKeywords(for: keyword) // Fetch initial keywords if needed
                    }
            } else {
                ScrollView {
                    ForEach(viewModel.keywords) { keyword in
                        VStack(alignment: .leading) {
                            Text("Keyword: \(keyword.text)")
                                .font(.headline)
                                .foregroundColor(Color(hex: "F5EDC8"))
                            Text("CPC: \(keyword.cpc)")
                                .foregroundColor(.white)
                            Text("Volume: \(keyword.vol)")
                                .foregroundColor(.white)
                            Text("Competition: \(keyword.competition)")
                                .foregroundColor(.white)
                            Text("Score: \(keyword.score, specifier: "%.2f")")
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color(hex: "0E151B"))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    }
                }
                .padding(.top)
            }
        }
        .background(Color(hex: "0E151B").edgesIgnoringSafeArea(.all))
    }
}

struct SEOKeywordView_Previews: PreviewProvider {
    static var previews: some View {
        SEOKeywordView()
    }
}
