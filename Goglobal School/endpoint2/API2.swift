// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class AddMobilUserTokenMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation AddMobilUserToken($user: String!, $token: String, $osType: String) {
      addMobilUserToken(user: $user, token: $token, osType: $osType) {
        __typename
        status
        message
      }
    }
    """

  public let operationName: String = "AddMobilUserToken"

  public var user: String
  public var token: String?
  public var osType: String?

  public init(user: String, token: String? = nil, osType: String? = nil) {
    self.user = user
    self.token = token
    self.osType = osType
  }

  public var variables: GraphQLMap? {
    return ["user": user, "token": token, "osType": osType]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("addMobilUserToken", arguments: ["user": GraphQLVariable("user"), "token": GraphQLVariable("token"), "osType": GraphQLVariable("osType")], type: .nonNull(.object(AddMobilUserToken.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(addMobilUserToken: AddMobilUserToken) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "addMobilUserToken": addMobilUserToken.resultMap])
    }

    public var addMobilUserToken: AddMobilUserToken {
      get {
        return AddMobilUserToken(unsafeResultMap: resultMap["addMobilUserToken"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "addMobilUserToken")
      }
    }

    public struct AddMobilUserToken: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["ResponseMessage"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("status", type: .scalar(Bool.self)),
          GraphQLField("message", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: Bool? = nil, message: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "ResponseMessage", "status": status, "message": message])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: Bool? {
        get {
          return resultMap["status"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var message: String? {
        get {
          return resultMap["message"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "message")
        }
      }
    }
  }
}

public final class GetStudentTransportationByMobileUserQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetStudentTransportationByMobileUser($id: String!) {
      getStudentTransportationByMobileUser(_id: $id) {
        __typename
        _id
        firstName
        lastName
        englishName
        profileImg
      }
    }
    """

  public let operationName: String = "GetStudentTransportationByMobileUser"

  public var id: String

  public init(id: String) {
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("getStudentTransportationByMobileUser", arguments: ["_id": GraphQLVariable("id")], type: .nonNull(.list(.object(GetStudentTransportationByMobileUser.selections)))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getStudentTransportationByMobileUser: [GetStudentTransportationByMobileUser?]) {
      self.init(unsafeResultMap: ["__typename": "Query", "getStudentTransportationByMobileUser": getStudentTransportationByMobileUser.map { (value: GetStudentTransportationByMobileUser?) -> ResultMap? in value.flatMap { (value: GetStudentTransportationByMobileUser) -> ResultMap in value.resultMap } }])
    }

    public var getStudentTransportationByMobileUser: [GetStudentTransportationByMobileUser?] {
      get {
        return (resultMap["getStudentTransportationByMobileUser"] as! [ResultMap?]).map { (value: ResultMap?) -> GetStudentTransportationByMobileUser? in value.flatMap { (value: ResultMap) -> GetStudentTransportationByMobileUser in GetStudentTransportationByMobileUser(unsafeResultMap: value) } }
      }
      set {
        resultMap.updateValue(newValue.map { (value: GetStudentTransportationByMobileUser?) -> ResultMap? in value.flatMap { (value: GetStudentTransportationByMobileUser) -> ResultMap in value.resultMap } }, forKey: "getStudentTransportationByMobileUser")
      }
    }

    public struct GetStudentTransportationByMobileUser: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["PersonalInfo"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("_id", type: .scalar(GraphQLID.self)),
          GraphQLField("firstName", type: .scalar(String.self)),
          GraphQLField("lastName", type: .scalar(String.self)),
          GraphQLField("englishName", type: .scalar(String.self)),
          GraphQLField("profileImg", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(_id: GraphQLID? = nil, firstName: String? = nil, lastName: String? = nil, englishName: String? = nil, profileImg: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "PersonalInfo", "_id": _id, "firstName": firstName, "lastName": lastName, "englishName": englishName, "profileImg": profileImg])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var _id: GraphQLID? {
        get {
          return resultMap["_id"] as? GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "_id")
        }
      }

      public var firstName: String? {
        get {
          return resultMap["firstName"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "firstName")
        }
      }

      public var lastName: String? {
        get {
          return resultMap["lastName"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "lastName")
        }
      }

      public var englishName: String? {
        get {
          return resultMap["englishName"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "englishName")
        }
      }

      public var profileImg: String? {
        get {
          return resultMap["profileImg"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "profileImg")
        }
      }
    }
  }
}

public final class RemoveMobilUserTokenMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation RemoveMobilUserToken($user: String!, $osType: String) {
      removeMobilUserToken(user: $user, osType: $osType) {
        __typename
        status
        message
      }
    }
    """

  public let operationName: String = "RemoveMobilUserToken"

  public var user: String
  public var osType: String?

  public init(user: String, osType: String? = nil) {
    self.user = user
    self.osType = osType
  }

  public var variables: GraphQLMap? {
    return ["user": user, "osType": osType]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("removeMobilUserToken", arguments: ["user": GraphQLVariable("user"), "osType": GraphQLVariable("osType")], type: .nonNull(.object(RemoveMobilUserToken.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(removeMobilUserToken: RemoveMobilUserToken) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "removeMobilUserToken": removeMobilUserToken.resultMap])
    }

    public var removeMobilUserToken: RemoveMobilUserToken {
      get {
        return RemoveMobilUserToken(unsafeResultMap: resultMap["removeMobilUserToken"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "removeMobilUserToken")
      }
    }

    public struct RemoveMobilUserToken: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["ResponseMessage"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("status", type: .scalar(Bool.self)),
          GraphQLField("message", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: Bool? = nil, message: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "ResponseMessage", "status": status, "message": message])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: Bool? {
        get {
          return resultMap["status"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var message: String? {
        get {
          return resultMap["message"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "message")
        }
      }
    }
  }
}