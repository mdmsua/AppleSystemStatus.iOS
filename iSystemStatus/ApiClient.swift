
import Foundation

class ApiClient {
    
    private static let decoder = JSONDecoder()
    
    private static let host = Bundle.main.object(forInfoDictionaryKey: "Service host") as! String
    
    private static let code = Bundle.main.object(forInfoDictionaryKey: "Service code") as! String
    
    fileprivate static func load<T: Decodable>(_ url: URL?, _ completion: @escaping (T?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else {
                completion(nil, nil)
                return
            }
            do {
                let object = try decoder.decode(T.self, from: data)
                completion(object, nil)
            } catch let e {
                completion(nil, e)
            }
        }.resume()
    }
    
    static func getCountries<T: Decodable>(completion: @escaping (T?, Error?) -> ()){
        let url = URL(string: "\(host)/countries?code=\(code)")
        load(url, completion)
        
    }
    
    static func getServices(for country: String, completion: @escaping ([Service]?, Error?) -> ()) {
        let url = URL(string: "\(host)/countries/\(country)/services?code=\(code)")
        load(url, completion)
    }
    
    static func getEvents(for service: String, completion: @escaping ([Event]?, Error?) -> ()) {
        let url = URL(string: "\(host)/services/\(service)/events?code=\(code)")
        load(url, completion)
    }
}
