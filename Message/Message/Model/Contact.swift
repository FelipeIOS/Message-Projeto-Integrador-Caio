//
//  Contact.swift
//  Message
//
//  Created by Caio on 24/02/21.
//

// ContactElement.swift

import Foundation

// MARK: - ContactElement
class ContactElement: Codable {
    var id, nome, email, urlImagem: String?

    init(id: String?, nome: String?, email: String?, urlImagem: String?) {
        self.id = id
        self.nome = nome
        self.email = email
        self.urlImagem = urlImagem
    }
}

// MARK: ContactElement convenience initializers and mutators

extension ContactElement {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(ContactElement.self, from: data)
        self.init(id: me.id, nome: me.nome, email: me.email, urlImagem: me.urlImagem)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: String?? = nil,
        nome: String?? = nil,
        email: String?? = nil,
        urlImagem: String?? = nil
    ) -> ContactElement {
        return ContactElement(
            id: id ?? self.id,
            nome: nome ?? self.nome,
            email: email ?? self.email,
            urlImagem: urlImagem ?? self.urlImagem
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}



typealias Contact = [ContactElement]

extension Array where Element == Contact.Element {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Contact.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

