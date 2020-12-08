//
//  APIClient.swift
//  FetchRewardsEvents
//
//  Created by Angela Garrovillas on 12/5/20.
//  Copyright © 2020 Angela Garrovillas. All rights reserved.
//

import Foundation

struct APIClient {
    func getEvents(query: String, completion: @escaping (Result<[Event],Error>) -> ()) {
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let stringURL = "https://api.seatgeek.com/2/events?client_id=\(Secrets.clientId)&q=\(query)"
        guard let url = URL(string: stringURL) else {
            print("url error")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data else {
                print("data error")
                return
            }
            do {
                let eventWrapper = try JSONDecoder().decode(EventWrapper.self, from: data)
                return completion(.success(eventWrapper.events))
            } catch {
                print(error)
            }
        }.resume()
    }
    func getEventBy(id: Int, completion: @escaping (Result<Event,Error>) -> ()) {
        let urlString = "https://api.seatgeek.com/2/events/\(id)?client_id=\(Secrets.clientId)"
        guard let url = URL(string: urlString) else {
            print("id url error")
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data else {
                print("id data error")
            }
            do {
                let event = try JSONDecoder().decode(Event.self, from: data)
                completion(.success(event))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getImageData(urlString: String, completion: @escaping (Result<Data,Error>) ->()) {
        guard let url = URL(string: urlString) else {
            print("bad url")
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                completion(.success(data))
            }
        }.resume()
    }
}
