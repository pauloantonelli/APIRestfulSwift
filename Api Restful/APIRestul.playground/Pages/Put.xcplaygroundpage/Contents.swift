//: [Previous](@previous)

import Foundation
let baseUrl: String = "https://jsonplaceholder.typicode.com"

struct PutResponse: Decodable {
    let id: Int
    let title: String
    let body: String
    let userId: Int
}

func put(withCompletion: @escaping (PutResponse) -> Void) -> Void {
    let url = URL(string: "\(baseUrl)/posts/1")!
    var urlRequest: URLRequest = URLRequest(url: url)
    urlRequest.httpMethod = "PUT"
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let body: [String:AnyHashable] = [
        "id": 1,
        "title": "foo",
        "body": "bar",
        "userId": 1,
    ]
    urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
    let task = URLSession.shared.dataTask(with: urlRequest.url!) { (data, response, error) in
        guard let data = data, error == nil else {
            print("Request Error")
             return
        }
        do {
            let result = try JSONDecoder().decode(PutResponse.self, from: data)
            withCompletion(result)
        } catch {
            print("Decode Error")
        }
    }
    task.resume()
}

put { response in
    print("Put response: \(response)")
}
