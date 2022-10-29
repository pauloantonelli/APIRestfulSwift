//: [Previous](@previous)

import Foundation

struct GetResponse: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}

let baseUrl: String = "https://jsonplaceholder.typicode.com"

func getTodoList(withCompletion completion: @escaping ([GetResponse]) -> Void) -> Void {
    let url = URL(string: "\(baseUrl)/todos")!
    let task = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) -> Void in
        guard let data = data, error == nil else {
            print("Error task")
            return
        }
        do {
            let jsonDecoder = JSONDecoder()
            let result = try jsonDecoder.decode([GetResponse].self, from: data)
            completion(result)
        } catch {
            print("Error on decode")
        }
    }
    task.resume()
}

func getTodoWithId(withId id: Int, withCompletion completion: @escaping ([GetResponse]) -> Void) -> Void {
    var components = URLComponents(string: baseUrl)!
    components.path = "/todos"
    components.queryItems = [
        URLQueryItem(name: "id", value: String(id))
    ]
    let task = URLSession.shared.dataTask(with: components.url!) { (data, response, error) in
        guard let data = data, error == nil else {
            print("Error")
            return
        }
        do {
            let jsonDecoder = JSONDecoder()
            let result = try jsonDecoder.decode([GetResponse].self, from: data)
            completion(result)
        } catch {
            print("Decode Error")
        }
    }
    task.resume()
}

getTodoList { response in
    response.forEach { item in
        print("getTodoList: \(item)")
    }
}
getTodoWithId(withId: 3) { response in
    print("getTodoWithId: \(response)")
}
