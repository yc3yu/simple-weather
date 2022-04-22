//
//  NetworkClient.swift
//  simple-weather
//
//  Created by Cindy Yu on 2022-04-22.
//

import Foundation

protocol Request {
    associatedtype Data: Decodable
    
    var scheme: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
    var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy { get }
}

extension Request {
    var scheme: String { "https" }
    var path: String { "" }
    var queryItems: [URLQueryItem] { [] }
    
    var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy {
        .convertFromSnakeCase
    }
}

enum NetworkClientError: Error {
    case malformedUrl
    case unknown
    case failureCode(Int)
}

class WeatherNetworkClient: NetworkClient {
    init(session: URLSession = .shared) {
        super.init(host: "api.openweathermap.org", session: session)
        
        self.queryItems = [
            URLQueryItem(name: "appid", value: "b0f60695417b64ddcc04592c711007e5")
        ]
    }
}

class NetworkClient {
    private let session: URLSession
    private let host: String
    
    /// Global query items applied to every request
    var queryItems: [URLQueryItem] = []
    
    init(host: String, session: URLSession = .shared) {
        self.host = host
        self.session = session
    }
    
    func fetch<R: Request>(from request: R) async throws -> R.Data {
        var components = URLComponents()
        components.host = self.host
        components.scheme = request.scheme
        components.path = request.path
        components.queryItems = request.queryItems + self.queryItems
        
        guard let url = components.url else {
            throw NetworkClientError.malformedUrl
        }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await session.data(for: urlRequest, delegate: nil)
        
        if let response = response as? HTTPURLResponse {
            if (200..<300).contains(response.statusCode) == false {
                // invalid code
                throw NetworkClientError.failureCode(response.statusCode)
            }
        }
        
        // parse the data
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = request.keyDecodingStrategy
        
        return try decoder.decode(R.Data.self, from: data)
    }
    
    /// Makes a network `Request` and parses using `JSONDecoder` to get data back
    func fetch<R: Request>(from request: R, completionHandler: @escaping (Result<R.Data, Error>) -> Void) {
        var components = URLComponents()
        components.host = self.host
        components.scheme = request.scheme
        components.path = request.path
        components.queryItems = request.queryItems + self.queryItems
        
        guard let url = components.url else {
            completionHandler(.failure(NetworkClientError.malformedUrl))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let response = response as? HTTPURLResponse {
                if (200..<300).contains(response.statusCode) == false {
                    // invalid code
                    completionHandler(.failure(NetworkClientError.failureCode(response.statusCode)))
                    return
                }
            }
            
            if let data = data {
                // parse the data
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = request.keyDecodingStrategy
                
                do {
                    let object = try decoder.decode(R.Data.self, from: data)
                    
                    completionHandler(.success(object))
                }
                catch {
                    completionHandler(.failure(error))
                }
            }
            else {
                // some sort of failure
                completionHandler(.failure(error ?? NetworkClientError.unknown))
            }
        }
        
        // begin the request
        task.resume()
    }
}

struct WeatherRequest: Request {
    typealias Data = Weather
    
    let path = "/data/2.5/weather"
    
    var queryItems: [URLQueryItem] {
        [
            URLQueryItem(name: "lat", value: "\(latitude)"),
            URLQueryItem(name: "lon", value: "\(longitude)"),
        ]
    }
    
    let latitude: Float
    let longitude: Float
}

struct Weather: Decodable {
    struct Temperature: Decodable {
        let temp: Double
        let feelsLike: Double
        let tempMin: Double
        let tempMax: Double
        let pressure: Double
        let humidity: Int
    }
    
    struct Wind: Decodable {
        let speed: Double
        let degree: Double
        
        enum CodingKeys: String, CodingKey {
            case speed
            case degree = "deg"
        }
    }
    
    let main: Temperature
    let name: String
    let wind: Wind
}

/*
{
  "coord": {
    "lon": -122.08,
    "lat": 37.39
  },
  "weather": [
    {
      "id": 800,
      "main": "Clear",
      "description": "clear sky",
      "icon": "01d"
    }
  ],
  "base": "stations",
  "main": {
    "temp": 282.55,
    "feels_like": 281.86,// feelsLike
    "temp_min": 280.37,
    "temp_max": 284.26,
    "pressure": 1023,
    "humidity": 100
  },
  "visibility": 10000,
  "wind": {
    "speed": 1.5,
    "deg": 350
  },
  "clouds": {
    "all": 1
  },
  "dt": 1560350645,
  "sys": {
    "type": 1,
    "id": 5122,
    "message": 0.0139,
    "country": "US",
    "sunrise": 1560343627,
    "sunset": 1560396563
  },
  "timezone": -25200,
  "id": 420006353,
  "name": "Mountain View",
  "cod": 200
} */
