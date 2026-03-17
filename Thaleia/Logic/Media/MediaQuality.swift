//
//  MediaQuality.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 3/15/26.
//

extension Media {
    enum Quality {
        case HD
        case FHD
        case QHD
        case UHD
        case other(width: Int, height: Int)

        var width: Int {
            switch self {
            case .HD: return 1280
            case .FHD: return 1920
            case .QHD: return 2560
            case .UHD: return 3840
            case .other(let width, height: _): return width
            }
        }

        var height: Int {
            switch self {
            case .HD: return 720
            case .FHD: return 1080
            case .QHD: return 1440
            case .UHD: return 2160
            case .other(width: _, let height): return height
            }
        }
        
        var description: String {
            switch self {
                case .HD:
                    return String(localized: "Media.Quality.HD")
                case .FHD:
                    return String(localized: "Media.Quality.FHD")
                case .QHD:
                    return String(localized: "Media.Quality.QHD")
                case .UHD:
                    return String(localized: "Media.Quality.UHD")
                case .other(let width, let height):
                    return String(localized: "Media.Quality.other.\(width).x.\(height)")
            }
        }
    }
}
