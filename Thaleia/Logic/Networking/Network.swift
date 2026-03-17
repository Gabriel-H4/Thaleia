//
//  Network.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 3/13/26.
//

import Foundation

struct Network {

    private init() {}

    static func getData<T: Decodable>(request: Network.Request, as type: T.Type)
        async throws(ThaleiaError) -> T
    {
        do {
            let (data, response) = try await Network.Session.session.data(
                for: request.urlRequest
            )
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode)
            else {
                throw ThaleiaError(
                    using: Network.Error.invalidResponse.template
                )
            }

            guard let data = try? Network.parse(data: data, as: type) else {
                throw ThaleiaError(
                    using: Network.Error.responseParsingFailure.template
                )
            }

            return data
        } catch {
            throw ThaleiaError(
                using: Network.Error.other.template
            )
        }
    }

    static func sendData(request: Network.Request, data: Data)
        async throws(ThaleiaError)
        -> Data
    {
        do {
            let (data, response) = try await Network.Session.session.upload(
                for: request.urlRequest,
                from: data
            )
            guard let response = response as? HTTPURLResponse,
                (200...300).contains(response.statusCode)
            else {
                throw ThaleiaError(
                    using: Network.Error.invalidResponse.template
                )
            }

            return data
        } catch {
            throw ThaleiaError(using: Network.Error.other.template)
        }
    }

    private static func parse<T: Decodable>(data: Data, as: T.Type) throws -> T
    {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
