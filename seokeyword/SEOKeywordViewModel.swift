import Foundation

class SEOKeywordViewModel: ObservableObject {
    @Published var keywords: [SEOKeyword] = []
    private let seoKeywordService = SEOKeywordService()
    
    // Fetch keywords with a specific keyword
    func fetchKeywords(for keyword: String) {
        seoKeywordService.fetchKeywords(for: keyword) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let keywords):
                    self?.keywords = keywords
                case .failure(let error):
                    print("Error fetching keywords: \(error.localizedDescription)")
                }
            }
        }
    }
}
