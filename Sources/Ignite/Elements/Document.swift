//
// HTML.swift
// Ignite
// https://www.github.com/twostraws/Ignite
// See LICENSE for license information.
//

public struct Document: HTML {
    /// The content and behavior of this HTML.
    public var body: some HTML { self }

    /// The unique identifier of this HTML.
    public var id = UUID().uuidString

    /// Whether this HTML belongs to the framework.
    public var isPrimitive: Bool { true }

    private let language: Language
    private let contents: [any DocumentElement]

    public init(language: Language = .english, @DocumentElementBuilder contents: () -> [any DocumentElement]) {
        self.language = language
        self.contents = contents()
    }

    public func render() -> String {
        var attributes = attributes
        attributes.append(customAttributes: .init(name: "lang", value: language.rawValue))
        attributes.append(customAttributes: .init(name: "data-bs-theme", value: "auto"))
        var output = "<!doctype html>"
        output += "<html\(attributes.description())>"
        output += contents.map { $0.render() }.joined()
        output += "</html>"
        return output
    }
}
