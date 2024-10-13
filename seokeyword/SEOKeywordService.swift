import Foundation

class SEOKeywordService {
    private let headers = [
        "x-rapidapi-key": "8ec235d2f6mshbffe97c67b86260p1a6cb8jsna608fd681823",
        "x-rapidapi-host": "seo-keyword-research.p.rapidapi.com"
    ]
    
    // Fetch keywords for a specific keyword
    func fetchKeywords(for keyword: String, completion: @escaping (Result<[SEOKeyword], Error>) -> Void) {
        // Create the URL with the user-provided keyword
        let encodedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: "https://seo-keyword-research.p.rapidapi.com/keynew.php?keyword=\(encodedKeyword)&country=in") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: nil)))
                return
            }
            
            do {
                // Decode JSON into an array of SEOKeyword
                let keywords = try JSONDecoder().decode([SEOKeyword].self, from: data)
                completion(.success(keywords))
            } catch {
                completion(.failure(error))
            }
        }
        
        dataTask.resume()
    }
}
