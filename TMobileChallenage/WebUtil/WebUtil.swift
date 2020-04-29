import Foundation

protocol URLSessionProtocol {
    func getData(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ())
}

extension URLSession: URLSessionProtocol {
    /*
     set authentication here when making web requests
     */
    func getData(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        var request = URLRequest.init(url: url)
        request.httpMethod = StringConstants.requestGet.rawValue
        request.setValue(StringConstants.requestHeadAcceptValue.rawValue, forHTTPHeaderField: StringConstants.requestHeadAcceptKey.rawValue)
        request.setValue("Basic NWY4NWU5MmY2NjAwYWJlZTg4YWZlN2JlOGRlOWViZGJlOTRhZDRjYQ==", forHTTPHeaderField: StringConstants.requestHeadAuthKey.rawValue)
        URLSession.shared.dataTask(with: request) { (data, resp, error) in
            completion(data, resp, error)
        }.resume()
    }
}


class WebUtil {
    
    let urlSession: URLSessionProtocol
    /*
     here to make it easier for mock url session in testing
     */
    init(urlSession : URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    /*
     get raw Data object from the url
     */
    func getData(urlString: String, completion: @escaping (Data?, Error?)->()) {
        guard let url = URL.init(string: urlString) else {completion(nil, APPError.InvalidURL); return }
        self.urlSession.getData(url: url) { (data, resp, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let httpResp = resp as? HTTPURLResponse, (200...299).contains(httpResp.statusCode) else {
                completion(nil, APPError.NILHTTPResponse)
                return
            }
            guard let data = data else{
                completion(nil, APPError.DataNIL)
                return
            }
            completion(data, nil)
        }
    }
    
    /*
    get decoded Data object from the url using generic
    */
    func getCodedData<T: Codable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
        self.getData(urlString: urlString) { (data, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else{
                completion(nil, APPError.DataNIL)
                return
            }
            guard let result = try? JSONDecoder().decode(T.self, from: data) else {
                completion(nil, APPError.DecodeError);
                return
            }
            completion(result, nil)
        }
    }
}

