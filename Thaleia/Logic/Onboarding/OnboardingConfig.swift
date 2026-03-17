//
//  OnboardingConfig.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 3/13/26.
//

import Foundation

extension Onboarding {
    
    @MainActor
    struct Config {
        var lastUpdated: Date = Date.now
        var plexURL: String = ""
        var seerrURL: String = ""

        var dictionary: [String: Any] {
            return [
                "lastUpdated": lastUpdated,
                "plexURL": plexURL,
                "seerrURL": seerrURL,
            ]
        }
        
        static let defaultConfig = Config()
        
        static var current: Config {
            return fetch()
        }
        
        static func registerDefaultConfig() {
            defaults.register(defaults: Config.defaultConfig.dictionary)
        }
        
        static func fetch() -> Config {
            return Config(
                lastUpdated: Onboarding.defaults.object(forKey: "lastUpdated") as? Date ?? Date.now,
                plexURL: Onboarding.defaults.string(forKey: "plexURL") ?? "",
                seerrURL: Onboarding.defaults.string(forKey: "seerrURL") ?? ""
            )
        }
        
        static func save(using config: Config) {
            if Date.now < fetch().lastUpdated {
                print("Woah -- we're saving an older config! (or time travelling?)")
            }
            Onboarding.defaults.set(config.lastUpdated, forKey: "lastUpdated")
            Onboarding.defaults.set(config.plexURL, forKey: "plexURL")
            Onboarding.defaults.set(config.seerrURL, forKey: "seerrURL")
        }
    }
}
