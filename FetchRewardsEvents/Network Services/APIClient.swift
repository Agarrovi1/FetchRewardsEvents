//
//  APIClient.swift
//  FetchRewardsEvents
//
//  Created by Angela Garrovillas on 12/5/20.
//  Copyright © 2020 Angela Garrovillas. All rights reserved.
//

import Foundation
enum AppError: Error {
    case imageError
    case urlError
    case dataError
    case errorFound
    case decodingError
    case favError
    case noFavError
}

struct APIClient {
    func getEvents(query: String, completion: @escaping (Result<[Event],AppError>) -> ()) {
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let stringURL = "https://api.seatgeek.com/2/events?client_id=\(Secrets.clientId)&q=\(query)"
        guard let url = URL(string: stringURL) else {
            return completion(.failure(.urlError))
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure(.errorFound))
            }
            guard let data = data else {
                return completion(.failure(.dataError))
            }
            do {
                let eventWrapper = try JSONDecoder().decode(EventWrapper.self, from: data)
                return completion(.success(eventWrapper.events))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    func getEventsBy(ids: String, completion: @escaping (Result<[Event],AppError>) -> ()) {
        let urlString = "https://api.seatgeek.com/2/events?client_id=\(Secrets.clientId)&id=\(ids)"
        guard let url = URL(string: urlString) else {
            return completion(.failure(AppError.urlError))
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure(.errorFound))
            }
            guard let data = data else {
                return completion(.failure(.dataError))
            }
            do {
                let events = try JSONDecoder().decode(EventWrapper.self, from: data)
                completion(.success(events.events))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func getImageData(urlString: String, completion: @escaping (Result<Data,AppError>) ->()) {
        guard let url = URL(string: urlString) else {
            return completion(.failure(.imageError))
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure(.imageError))
            }
            if let data = data {
                completion(.success(data))
            }
        }.resume()
    }
}
