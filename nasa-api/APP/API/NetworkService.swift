//
//  NetworkService.swift
//  nasa-api
//
//  Created by Денис Наумов on 18.08.2022.
//

import Foundation

class NetworkService {

    func request(from: String, completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = URL(string: from) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
            }
        }.resume()
    }

    func requestJson<T: Decodable>(from urlString: String, using type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        request(from: urlString) { (result) in
            switch(result) {
            case .success(let data):
                do {
                    let data = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(data))
                }
                catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
