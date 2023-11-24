//
//  NetworkService.swift
//  PlumbingTest
//
//  Created by Снытин Ростислав on 22.11.2023.
//

import Foundation
import Combine

class NetworkService {
    typealias Dict = [String: Any]

    func run<T: Decodable>(
        method: String,
        url: URL,
        parameters: [URLQueryItem]? = nil,
        headers: Dict? = nil,
        body: Dict? = nil
    ) -> AnyPublisher<T, Error> {
        var urlComp = URLComponents(url: url, resolvingAgainstBaseURL: true)
        if let parameters = parameters { urlComp?.queryItems = parameters }

        var urlRequest = URLRequest(url: urlComp?.url ?? url)
        urlRequest.httpMethod = method

        headers?.forEach { (key, value) in urlRequest.addValue("\(value)", forHTTPHeaderField: key) }
        if let body = body { urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body) }

        let placeholder: Data? = "NO BODY".data(using: .utf8)
        let str: String = String(decoding: urlRequest.httpBody ?? placeholder!, as: UTF8.self)
        print("METHOD: \(urlRequest.httpMethod ?? "")")
        print("HEADER: \(urlRequest.allHTTPHeaderFields ?? ["": ""])")
        print("REQUEST: \(urlRequest)")

        #if DEBUG
        print("REQUEST BODY:\n\(str)")
        #endif

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap({ try self.handleURLResponse(output: $0, url: url) })
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    private func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse
        else { throw NetworkError.badURLResponse(url) }

        #if DEBUG
        if let strResponse = String(data: output.data, encoding: .utf8) {
            print(strResponse)
        }
        #endif

        switch response.statusCode {
        case 200...299:
            return output.data
        case 400:
            throw NetworkError.errorInputData
        case 401:
            throw NetworkError.authError
        case 402...499:
            throw NetworkError.badStatusCode(response.statusCode)
        case 500...599:
            throw NetworkError.serverError
        default:
            throw NetworkError.unknown
        }
    }
}

enum HttpMethod: String {
    case post = "POST"
    case get = "GET"
}
