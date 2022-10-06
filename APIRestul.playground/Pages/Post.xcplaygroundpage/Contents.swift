import UIKit
import Foundation

struct PostResponse: Codable {
    let body: String
    let id: Int
    let title: String
    let userId: Int
}

let baseUrl: String = "https://jsonplaceholder.typicode.com"

func post(withCompletion completion: @escaping (PostResponse) -> Void) -> Void {
    guard let url = URL(string: "\(baseUrl)/posts") else {
        print("Error")
        return
    }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let body: [String:AnyHashable] = [
        "userId": 1,
        "title": "Hello World",
        "body": "Uchiha is Here!"
    ]
    request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        guard let data = data, error == nil else {
            return
        }
        do {
            let jsonDecoder = JSONDecoder()
            let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            let result = try jsonDecoder.decode(PostResponse.self, from: data)
            print(response)
            completion(result)
        } catch {
            print(error)
        }
    }
    task.resume()
}

post { response in
    print("Post Response: \(response)")
}
