//
//  PlexEndpoints.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 2/4/26.
//

import RequestSpec

extension PlexServer {
    struct Endpoints {

        struct Status: Codable {
            let mediaContainer: MediaContainer

            enum CodingKeys: String, CodingKey {
                case mediaContainer = "MediaContainer"
            }
        }

        struct MediaContainer: Codable {
            let version: String
            let name: String
            let mediaProviders: Bool

            enum CodingKeys: String, CodingKey {
                case version
                case name = "friendlyName"
                case mediaProviders
            }
        }

        struct GetStatusRequest: RequestSpec {
            let token: String

            var request: Get<Status> {
                Get("/status-plex.json")
                    .headers {
                        Accept("application/json")
                        Header("X-Plex-Token", value: token)
                    }
                    .timeout(30)
            }
        }
    }
}
