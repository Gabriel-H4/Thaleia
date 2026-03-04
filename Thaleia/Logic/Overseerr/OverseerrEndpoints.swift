//
//  OverseerrEndpoints.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 2/5/26.
//

import RequestSpec

extension OverseerrServer {
    struct Endpoints {
        struct Status: Codable {
            let version: String
            let updateAvailable: Bool

            enum CodingKeys: String, CodingKey {
                case version
                case updateAvailable
            }
        }

        struct GetStatusRequest: RequestSpec {
            let token: String

            var request: Get<Status> {
                Get("/status-overseerr.json")
                    .headers {
                        Accept("application/json")
                        XApiKey(token)
                    }
                    .timeout(30)
            }
        }
    }
}
