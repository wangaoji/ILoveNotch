// SPDX-License-Identifier: MIT
import Foundation

/// Language selection shared by the app and its feature modules.
public enum AppLanguage {
    public static let defaultsKey = "appLanguage"

    public static func locale(for selection: String) -> Locale {
        switch selection {
        case "zh-Hans": Locale(identifier: "zh-Hans")
        case "en": Locale(identifier: "en")
        default: .current
        }
    }

    public static func localized(_ key: String) -> String {
        switch UserDefaults.standard.string(forKey: defaultsKey) ?? "system" {
        case "en": return key
        case "zh-Hans":
            guard let path = Bundle.main.path(forResource: "zh-Hans", ofType: "lproj"),
                  let bundle = Bundle(path: path) else { return key }
            return bundle.localizedString(forKey: key, value: key, table: nil)
        default:
            return Bundle.main.localizedString(forKey: key, value: key, table: nil)
        }
    }

    public static func localizedFormat(_ key: String, _ arguments: CVarArg...) -> String {
        String(format: localized(key), locale: locale(for: UserDefaults.standard.string(forKey: defaultsKey) ?? "system"), arguments: arguments)
    }
}
