import Foundation
let baseUrl: String = "https://jsonplaceholder.typicode.com"

func delete(completion: @escaping (Int) -> Void) -> Void {
    let url = URL(string: "\(baseUrl)/posts/1")!
    var urlRequest: URLRequest = URLRequest(url: url)
    urlRequest.httpMethod = "DELETE"
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
        guard let data = data, error == nil else {
            print("Request Error")
             return
        }
        let result = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
        if let httpResponse = response as? HTTPURLResponse {
            completion(httpResponse.statusCode)
        }
    }
    task.resume()
}

delete { result in
    print("Delete Result: \(result)")
}
