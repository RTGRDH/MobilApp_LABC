// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let parkering = try? newJSONDecoder().decode(Parkering.self, from: jsonData)

import Foundation

// MARK: - Parkering
struct PAutomatStruct: Codable {
    let type: String
    let features: [Feature]
    let totalFeatures, numberMatched, numberReturned: Int
    let timeStamp: String
    let crs: CRS
}

// MARK: - CRS
struct CRS: Codable {
    let type: String
    let properties: CRSProperties
}

// MARK: - CRSProperties
struct CRSProperties: Codable {
    let name: String
}

// MARK: - Feature
struct Feature: Codable {
    let type: FeatureType
    let id: String
    let geometry: Geometry
    let geometryName: GeometryName
    let properties: FeatureProperties

    enum CodingKeys: String, CodingKey {
        case type, id, geometry
        case geometryName = "geometry_name"
        case properties
    }
}

// MARK: - Geometry
struct Geometry: Codable {
    let type: GeometryType
    let coordinates: [Double]
}

enum GeometryType: String, Codable {
    case point = "Point"
}

enum GeometryName: String, Codable {
    case geometry = "GEOMETRY"
}

// MARK: - FeatureProperties
struct FeatureProperties: Codable {
    let objectID, versionID: Int
    let featureTypeName: FeatureTypeName
    let featureTypeObjectID, featureTypeVersionID: Int
    let mainAttributeName: MainAttributeName
    let mainAttributeValue, mainAttributeDescription, montagenummer: String
    let status: Status
    let adressbeskrivning: String
    let kort, mynt: JSONNull?
    let boendeknapp: Boendeknapp?
    let ångraknapp, myntslag, taxaTyp, multi: JSONNull?
    let validFrom: Int
    let validTo: JSONNull?
    let cid, extentNo, extentType, lateralPosition: Int
    let lateralDist, position: Double
    let trafficTypes: TrafficTypes
    let netElementObjectID, createDate, changeDate: Int

    enum CodingKeys: String, CodingKey {
        case objectID = "OBJECT_ID"
        case versionID = "VERSION_ID"
        case featureTypeName = "FEATURE_TYPE_NAME"
        case featureTypeObjectID = "FEATURE_TYPE_OBJECT_ID"
        case featureTypeVersionID = "FEATURE_TYPE_VERSION_ID"
        case mainAttributeName = "MAIN_ATTRIBUTE_NAME"
        case mainAttributeValue = "MAIN_ATTRIBUTE_VALUE"
        case mainAttributeDescription = "MAIN_ATTRIBUTE_DESCRIPTION"
        case montagenummer = "Montagenummer"
        case status = "Status"
        case adressbeskrivning = "Adressbeskrivning"
        case kort = "Kort"
        case mynt = "Mynt"
        case boendeknapp = "Boendeknapp"
        case ångraknapp = "Ångraknapp"
        case myntslag = "Myntslag"
        case taxaTyp = "Taxa_typ"
        case multi = "Multi"
        case validFrom = "VALID_FROM"
        case validTo = "VALID_TO"
        case cid = "CID"
        case extentNo = "EXTENT_NO"
        case extentType = "EXTENT_TYPE"
        case lateralPosition = "LATERAL_POSITION"
        case lateralDist = "LATERAL_DIST"
        case position = "POSITION"
        case trafficTypes = "TRAFFIC_TYPES"
        case netElementObjectID = "NET_ELEMENT_OBJECT_ID"
        case createDate = "CREATE_DATE"
        case changeDate = "CHANGE_DATE"
    }
}

enum Boendeknapp: String, Codable {
    case nej = "Nej"
}

enum FeatureTypeName: String, Codable {
    case parkeringsautomat = "Parkeringsautomat"
}

enum MainAttributeName: String, Codable {
    case montagenummer = "Montagenummer"
}

enum Status: String, Codable {
    case avstängd = "Avstängd"
    case felanmäld = "Felanmäld"
    case iDrift = "I Drift"
    case planerad = "Planerad"
}

enum TrafficTypes: String, Codable {
    case bilnät = "Bilnät"
    case bilnätGångnät = "Bilnät+Gångnät"
}

enum FeatureType: String, Codable {
    case feature = "Feature"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
