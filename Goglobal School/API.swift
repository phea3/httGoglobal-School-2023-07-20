// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class LoginMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation Login($email: String!, $password: String!) {
      login(email: $email, password: $password) {
        __typename
        token
        user {
          __typename
          _id
          email
          password
          profileImage
          parentId {
            __typename
            _id
            role
            permanentProvince
            firstName
            lastName
            englishName
            gender
            tel
            nationality
            village
            commune
            district
            province
            dob
            createdAt
          }
        }
      }
    }
    """

  public let operationName: String = "Login"

  public var email: String
  public var password: String

  public init(email: String, password: String) {
    self.email = email
    self.password = password
  }

  public var variables: GraphQLMap? {
    return ["email": email, "password": password]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("login", arguments: ["email": GraphQLVariable("email"), "password": GraphQLVariable("password")], type: .object(Login.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(login: Login? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "login": login.flatMap { (value: Login) -> ResultMap in value.resultMap }])
    }

    public var login: Login? {
      get {
        return (resultMap["login"] as? ResultMap).flatMap { Login(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "login")
      }
    }

    public struct Login: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["LoginResponse"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("token", type: .scalar(String.self)),
          GraphQLField("user", type: .object(User.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(token: String? = nil, user: User? = nil) {
        self.init(unsafeResultMap: ["__typename": "LoginResponse", "token": token, "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var token: String? {
        get {
          return resultMap["token"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "token")
        }
      }

      public var user: User? {
        get {
          return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "user")
        }
      }

      public struct User: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["MobileUser"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("_id", type: .scalar(GraphQLID.self)),
            GraphQLField("email", type: .scalar(String.self)),
            GraphQLField("password", type: .scalar(String.self)),
            GraphQLField("profileImage", type: .scalar(String.self)),
            GraphQLField("parentId", type: .object(ParentId.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(_id: GraphQLID? = nil, email: String? = nil, password: String? = nil, profileImage: String? = nil, parentId: ParentId? = nil) {
          self.init(unsafeResultMap: ["__typename": "MobileUser", "_id": _id, "email": email, "password": password, "profileImage": profileImage, "parentId": parentId.flatMap { (value: ParentId) -> ResultMap in value.resultMap }])
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

        public var email: String? {
          get {
            return resultMap["email"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "email")
          }
        }

        public var password: String? {
          get {
            return resultMap["password"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "password")
          }
        }

        public var profileImage: String? {
          get {
            return resultMap["profileImage"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "profileImage")
          }
        }

        public var parentId: ParentId? {
          get {
            return (resultMap["parentId"] as? ResultMap).flatMap { ParentId(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "parentId")
          }
        }

        public struct ParentId: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["PersonalInfo"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("_id", type: .scalar(GraphQLID.self)),
              GraphQLField("role", type: .scalar(String.self)),
              GraphQLField("permanentProvince", type: .scalar(String.self)),
              GraphQLField("firstName", type: .scalar(String.self)),
              GraphQLField("lastName", type: .scalar(String.self)),
              GraphQLField("englishName", type: .scalar(String.self)),
              GraphQLField("gender", type: .scalar(String.self)),
              GraphQLField("tel", type: .scalar(String.self)),
              GraphQLField("nationality", type: .scalar(String.self)),
              GraphQLField("village", type: .scalar(String.self)),
              GraphQLField("commune", type: .scalar(String.self)),
              GraphQLField("district", type: .scalar(String.self)),
              GraphQLField("province", type: .scalar(String.self)),
              GraphQLField("dob", type: .scalar(String.self)),
              GraphQLField("createdAt", type: .scalar(String.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(_id: GraphQLID? = nil, role: String? = nil, permanentProvince: String? = nil, firstName: String? = nil, lastName: String? = nil, englishName: String? = nil, gender: String? = nil, tel: String? = nil, nationality: String? = nil, village: String? = nil, commune: String? = nil, district: String? = nil, province: String? = nil, dob: String? = nil, createdAt: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "PersonalInfo", "_id": _id, "role": role, "permanentProvince": permanentProvince, "firstName": firstName, "lastName": lastName, "englishName": englishName, "gender": gender, "tel": tel, "nationality": nationality, "village": village, "commune": commune, "district": district, "province": province, "dob": dob, "createdAt": createdAt])
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

          public var role: String? {
            get {
              return resultMap["role"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "role")
            }
          }

          public var permanentProvince: String? {
            get {
              return resultMap["permanentProvince"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "permanentProvince")
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

          public var gender: String? {
            get {
              return resultMap["gender"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "gender")
            }
          }

          public var tel: String? {
            get {
              return resultMap["tel"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "tel")
            }
          }

          public var nationality: String? {
            get {
              return resultMap["nationality"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "nationality")
            }
          }

          public var village: String? {
            get {
              return resultMap["village"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "village")
            }
          }

          public var commune: String? {
            get {
              return resultMap["commune"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "commune")
            }
          }

          public var district: String? {
            get {
              return resultMap["district"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "district")
            }
          }

          public var province: String? {
            get {
              return resultMap["province"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "province")
            }
          }

          public var dob: String? {
            get {
              return resultMap["dob"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "dob")
            }
          }

          public var createdAt: String? {
            get {
              return resultMap["createdAt"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "createdAt")
            }
          }
        }
      }
    }
  }
}

public final class GetEventsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetEvents($academicYearId: ID) {
      getEvents(academicYearId: $academicYearId) {
        __typename
        _id
        eventName
        eventNameKhmer
        eventDate
        endEventDate
        academicYearId {
          __typename
          _id
          academicYear
        }
      }
    }
    """

  public let operationName: String = "GetEvents"

  public var academicYearId: GraphQLID?

  public init(academicYearId: GraphQLID? = nil) {
    self.academicYearId = academicYearId
  }

  public var variables: GraphQLMap? {
    return ["academicYearId": academicYearId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("getEvents", arguments: ["academicYearId": GraphQLVariable("academicYearId")], type: .nonNull(.list(.nonNull(.object(GetEvent.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getEvents: [GetEvent]) {
      self.init(unsafeResultMap: ["__typename": "Query", "getEvents": getEvents.map { (value: GetEvent) -> ResultMap in value.resultMap }])
    }

    public var getEvents: [GetEvent] {
      get {
        return (resultMap["getEvents"] as! [ResultMap]).map { (value: ResultMap) -> GetEvent in GetEvent(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: GetEvent) -> ResultMap in value.resultMap }, forKey: "getEvents")
      }
    }

    public struct GetEvent: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Event"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("_id", type: .scalar(GraphQLID.self)),
          GraphQLField("eventName", type: .scalar(String.self)),
          GraphQLField("eventNameKhmer", type: .scalar(String.self)),
          GraphQLField("eventDate", type: .scalar(String.self)),
          GraphQLField("endEventDate", type: .scalar(String.self)),
          GraphQLField("academicYearId", type: .object(AcademicYearId.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(_id: GraphQLID? = nil, eventName: String? = nil, eventNameKhmer: String? = nil, eventDate: String? = nil, endEventDate: String? = nil, academicYearId: AcademicYearId? = nil) {
        self.init(unsafeResultMap: ["__typename": "Event", "_id": _id, "eventName": eventName, "eventNameKhmer": eventNameKhmer, "eventDate": eventDate, "endEventDate": endEventDate, "academicYearId": academicYearId.flatMap { (value: AcademicYearId) -> ResultMap in value.resultMap }])
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

      public var eventName: String? {
        get {
          return resultMap["eventName"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "eventName")
        }
      }

      public var eventNameKhmer: String? {
        get {
          return resultMap["eventNameKhmer"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "eventNameKhmer")
        }
      }

      public var eventDate: String? {
        get {
          return resultMap["eventDate"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "eventDate")
        }
      }

      public var endEventDate: String? {
        get {
          return resultMap["endEventDate"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "endEventDate")
        }
      }

      public var academicYearId: AcademicYearId? {
        get {
          return (resultMap["academicYearId"] as? ResultMap).flatMap { AcademicYearId(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "academicYearId")
        }
      }

      public struct AcademicYearId: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["AcademicYear"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("_id", type: .scalar(GraphQLID.self)),
            GraphQLField("academicYear", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(_id: GraphQLID? = nil, academicYear: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "AcademicYear", "_id": _id, "academicYear": academicYear])
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

        public var academicYear: String? {
          get {
            return resultMap["academicYear"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "academicYear")
          }
        }
      }
    }
  }
}

public final class GetActiveAcademicYearQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetActiveAcademicYear {
      getActiveAcademicYear {
        __typename
        _id
        academicYear
      }
    }
    """

  public let operationName: String = "GetActiveAcademicYear"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("getActiveAcademicYear", type: .list(.object(GetActiveAcademicYear.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getActiveAcademicYear: [GetActiveAcademicYear?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getActiveAcademicYear": getActiveAcademicYear.flatMap { (value: [GetActiveAcademicYear?]) -> [ResultMap?] in value.map { (value: GetActiveAcademicYear?) -> ResultMap? in value.flatMap { (value: GetActiveAcademicYear) -> ResultMap in value.resultMap } } }])
    }

    public var getActiveAcademicYear: [GetActiveAcademicYear?]? {
      get {
        return (resultMap["getActiveAcademicYear"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [GetActiveAcademicYear?] in value.map { (value: ResultMap?) -> GetActiveAcademicYear? in value.flatMap { (value: ResultMap) -> GetActiveAcademicYear in GetActiveAcademicYear(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [GetActiveAcademicYear?]) -> [ResultMap?] in value.map { (value: GetActiveAcademicYear?) -> ResultMap? in value.flatMap { (value: GetActiveAcademicYear) -> ResultMap in value.resultMap } } }, forKey: "getActiveAcademicYear")
      }
    }

    public struct GetActiveAcademicYear: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["AcademicYear"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("_id", type: .scalar(GraphQLID.self)),
          GraphQLField("academicYear", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(_id: GraphQLID? = nil, academicYear: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "AcademicYear", "_id": _id, "academicYear": academicYear])
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

      public var academicYear: String? {
        get {
          return resultMap["academicYear"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "academicYear")
        }
      }
    }
  }
}

public final class GetStudentsByParentsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetStudentsByParents($parentId: ID) {
      getStudentsByParents(parentId: $parentId) {
        __typename
        _id
        firstName
        lastName
        enrollments {
          __typename
          _id
          programId {
            __typename
            _id
            programmName
          }
          academicYearId {
            __typename
            _id
            academicYear
          }
          gradeId {
            __typename
            _id
            gradeName
          }
          startDate
          endDate
          classId {
            __typename
            _id
            className
          }
          className
        }
        profileImg
      }
    }
    """

  public let operationName: String = "GetStudentsByParents"

  public var parentId: GraphQLID?

  public init(parentId: GraphQLID? = nil) {
    self.parentId = parentId
  }

  public var variables: GraphQLMap? {
    return ["parentId": parentId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("getStudentsByParents", arguments: ["parentId": GraphQLVariable("parentId")], type: .list(.object(GetStudentsByParent.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getStudentsByParents: [GetStudentsByParent?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getStudentsByParents": getStudentsByParents.flatMap { (value: [GetStudentsByParent?]) -> [ResultMap?] in value.map { (value: GetStudentsByParent?) -> ResultMap? in value.flatMap { (value: GetStudentsByParent) -> ResultMap in value.resultMap } } }])
    }

    public var getStudentsByParents: [GetStudentsByParent?]? {
      get {
        return (resultMap["getStudentsByParents"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [GetStudentsByParent?] in value.map { (value: ResultMap?) -> GetStudentsByParent? in value.flatMap { (value: ResultMap) -> GetStudentsByParent in GetStudentsByParent(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [GetStudentsByParent?]) -> [ResultMap?] in value.map { (value: GetStudentsByParent?) -> ResultMap? in value.flatMap { (value: GetStudentsByParent) -> ResultMap in value.resultMap } } }, forKey: "getStudentsByParents")
      }
    }

    public struct GetStudentsByParent: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["PersonalInfo"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("_id", type: .scalar(GraphQLID.self)),
          GraphQLField("firstName", type: .scalar(String.self)),
          GraphQLField("lastName", type: .scalar(String.self)),
          GraphQLField("enrollments", type: .list(.object(Enrollment.selections))),
          GraphQLField("profileImg", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(_id: GraphQLID? = nil, firstName: String? = nil, lastName: String? = nil, enrollments: [Enrollment?]? = nil, profileImg: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "PersonalInfo", "_id": _id, "firstName": firstName, "lastName": lastName, "enrollments": enrollments.flatMap { (value: [Enrollment?]) -> [ResultMap?] in value.map { (value: Enrollment?) -> ResultMap? in value.flatMap { (value: Enrollment) -> ResultMap in value.resultMap } } }, "profileImg": profileImg])
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

      public var enrollments: [Enrollment?]? {
        get {
          return (resultMap["enrollments"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Enrollment?] in value.map { (value: ResultMap?) -> Enrollment? in value.flatMap { (value: ResultMap) -> Enrollment in Enrollment(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Enrollment?]) -> [ResultMap?] in value.map { (value: Enrollment?) -> ResultMap? in value.flatMap { (value: Enrollment) -> ResultMap in value.resultMap } } }, forKey: "enrollments")
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

      public struct Enrollment: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Enrollment"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("_id", type: .scalar(GraphQLID.self)),
            GraphQLField("programId", type: .object(ProgramId.selections)),
            GraphQLField("academicYearId", type: .object(AcademicYearId.selections)),
            GraphQLField("gradeId", type: .object(GradeId.selections)),
            GraphQLField("startDate", type: .scalar(String.self)),
            GraphQLField("endDate", type: .scalar(String.self)),
            GraphQLField("classId", type: .object(ClassId.selections)),
            GraphQLField("className", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(_id: GraphQLID? = nil, programId: ProgramId? = nil, academicYearId: AcademicYearId? = nil, gradeId: GradeId? = nil, startDate: String? = nil, endDate: String? = nil, classId: ClassId? = nil, className: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "Enrollment", "_id": _id, "programId": programId.flatMap { (value: ProgramId) -> ResultMap in value.resultMap }, "academicYearId": academicYearId.flatMap { (value: AcademicYearId) -> ResultMap in value.resultMap }, "gradeId": gradeId.flatMap { (value: GradeId) -> ResultMap in value.resultMap }, "startDate": startDate, "endDate": endDate, "classId": classId.flatMap { (value: ClassId) -> ResultMap in value.resultMap }, "className": className])
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

        public var programId: ProgramId? {
          get {
            return (resultMap["programId"] as? ResultMap).flatMap { ProgramId(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "programId")
          }
        }

        public var academicYearId: AcademicYearId? {
          get {
            return (resultMap["academicYearId"] as? ResultMap).flatMap { AcademicYearId(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "academicYearId")
          }
        }

        public var gradeId: GradeId? {
          get {
            return (resultMap["gradeId"] as? ResultMap).flatMap { GradeId(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "gradeId")
          }
        }

        public var startDate: String? {
          get {
            return resultMap["startDate"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "startDate")
          }
        }

        public var endDate: String? {
          get {
            return resultMap["endDate"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "endDate")
          }
        }

        public var classId: ClassId? {
          get {
            return (resultMap["classId"] as? ResultMap).flatMap { ClassId(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "classId")
          }
        }

        public var className: String? {
          get {
            return resultMap["className"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "className")
          }
        }

        public struct ProgramId: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Program"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("_id", type: .nonNull(.scalar(GraphQLID.self))),
              GraphQLField("programmName", type: .scalar(String.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(_id: GraphQLID, programmName: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "Program", "_id": _id, "programmName": programmName])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var _id: GraphQLID {
            get {
              return resultMap["_id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "_id")
            }
          }

          public var programmName: String? {
            get {
              return resultMap["programmName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "programmName")
            }
          }
        }

        public struct AcademicYearId: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["AcademicYear"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("_id", type: .scalar(GraphQLID.self)),
              GraphQLField("academicYear", type: .scalar(String.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(_id: GraphQLID? = nil, academicYear: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "AcademicYear", "_id": _id, "academicYear": academicYear])
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

          public var academicYear: String? {
            get {
              return resultMap["academicYear"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "academicYear")
            }
          }
        }

        public struct GradeId: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Grade"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("_id", type: .scalar(GraphQLID.self)),
              GraphQLField("gradeName", type: .scalar(String.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(_id: GraphQLID? = nil, gradeName: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "Grade", "_id": _id, "gradeName": gradeName])
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

          public var gradeName: String? {
            get {
              return resultMap["gradeName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "gradeName")
            }
          }
        }

        public struct ClassId: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Classes"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("_id", type: .scalar(GraphQLID.self)),
              GraphQLField("className", type: .scalar(String.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(_id: GraphQLID? = nil, className: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "Classes", "_id": _id, "className": className])
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

          public var className: String? {
            get {
              return resultMap["className"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "className")
            }
          }
        }
      }
    }
  }
}

public final class GetAttendanceByStudentIdQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetAttendanceByStudentId($studentId: ID!) {
      getAttendanceByStudentId(studentId: $studentId) {
        __typename
        attendanceId
        attendanceDate
        status
      }
    }
    """

  public let operationName: String = "GetAttendanceByStudentId"

  public var studentId: GraphQLID

  public init(studentId: GraphQLID) {
    self.studentId = studentId
  }

  public var variables: GraphQLMap? {
    return ["studentId": studentId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("getAttendanceByStudentId", arguments: ["studentId": GraphQLVariable("studentId")], type: .nonNull(.list(.nonNull(.object(GetAttendanceByStudentId.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getAttendanceByStudentId: [GetAttendanceByStudentId]) {
      self.init(unsafeResultMap: ["__typename": "Query", "getAttendanceByStudentId": getAttendanceByStudentId.map { (value: GetAttendanceByStudentId) -> ResultMap in value.resultMap }])
    }

    public var getAttendanceByStudentId: [GetAttendanceByStudentId] {
      get {
        return (resultMap["getAttendanceByStudentId"] as! [ResultMap]).map { (value: ResultMap) -> GetAttendanceByStudentId in GetAttendanceByStudentId(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: GetAttendanceByStudentId) -> ResultMap in value.resultMap }, forKey: "getAttendanceByStudentId")
      }
    }

    public struct GetAttendanceByStudentId: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["StudentAttendance"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("attendanceId", type: .scalar(GraphQLID.self)),
          GraphQLField("attendanceDate", type: .scalar(String.self)),
          GraphQLField("status", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(attendanceId: GraphQLID? = nil, attendanceDate: String? = nil, status: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "StudentAttendance", "attendanceId": attendanceId, "attendanceDate": attendanceDate, "status": status])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var attendanceId: GraphQLID? {
        get {
          return resultMap["attendanceId"] as? GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "attendanceId")
        }
      }

      public var attendanceDate: String? {
        get {
          return resultMap["attendanceDate"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "attendanceDate")
        }
      }

      public var status: String? {
        get {
          return resultMap["status"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }
    }
  }
}

public final class GetMobileUserByIdQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetMobileUserById($mobileUserId: ID) {
      getMobileUserById(mobileUserId: $mobileUserId) {
        __typename
        _id
        email
        password
        profileImage
      }
    }
    """

  public let operationName: String = "GetMobileUserById"

  public var mobileUserId: GraphQLID?

  public init(mobileUserId: GraphQLID? = nil) {
    self.mobileUserId = mobileUserId
  }

  public var variables: GraphQLMap? {
    return ["mobileUserId": mobileUserId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("getMobileUserById", arguments: ["mobileUserId": GraphQLVariable("mobileUserId")], type: .object(GetMobileUserById.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getMobileUserById: GetMobileUserById? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getMobileUserById": getMobileUserById.flatMap { (value: GetMobileUserById) -> ResultMap in value.resultMap }])
    }

    public var getMobileUserById: GetMobileUserById? {
      get {
        return (resultMap["getMobileUserById"] as? ResultMap).flatMap { GetMobileUserById(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getMobileUserById")
      }
    }

    public struct GetMobileUserById: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["MobileUser"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("_id", type: .scalar(GraphQLID.self)),
          GraphQLField("email", type: .scalar(String.self)),
          GraphQLField("password", type: .scalar(String.self)),
          GraphQLField("profileImage", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(_id: GraphQLID? = nil, email: String? = nil, password: String? = nil, profileImage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "MobileUser", "_id": _id, "email": email, "password": password, "profileImage": profileImage])
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

      public var email: String? {
        get {
          return resultMap["email"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "email")
        }
      }

      public var password: String? {
        get {
          return resultMap["password"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "password")
        }
      }

      public var profileImage: String? {
        get {
          return resultMap["profileImage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "profileImage")
        }
      }
    }
  }
}

public final class GetAnnouncementQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetAnnouncement {
      getAnnouncement {
        __typename
        _id
        title
        description
        picture
        date
      }
    }
    """

  public let operationName: String = "GetAnnouncement"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("getAnnouncement", type: .list(.object(GetAnnouncement.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getAnnouncement: [GetAnnouncement?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getAnnouncement": getAnnouncement.flatMap { (value: [GetAnnouncement?]) -> [ResultMap?] in value.map { (value: GetAnnouncement?) -> ResultMap? in value.flatMap { (value: GetAnnouncement) -> ResultMap in value.resultMap } } }])
    }

    public var getAnnouncement: [GetAnnouncement?]? {
      get {
        return (resultMap["getAnnouncement"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [GetAnnouncement?] in value.map { (value: ResultMap?) -> GetAnnouncement? in value.flatMap { (value: ResultMap) -> GetAnnouncement in GetAnnouncement(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [GetAnnouncement?]) -> [ResultMap?] in value.map { (value: GetAnnouncement?) -> ResultMap? in value.flatMap { (value: GetAnnouncement) -> ResultMap in value.resultMap } } }, forKey: "getAnnouncement")
      }
    }

    public struct GetAnnouncement: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Announcement"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("_id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("title", type: .scalar(String.self)),
          GraphQLField("description", type: .scalar(String.self)),
          GraphQLField("picture", type: .scalar(String.self)),
          GraphQLField("date", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(_id: GraphQLID, title: String? = nil, description: String? = nil, picture: String? = nil, date: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Announcement", "_id": _id, "title": title, "description": description, "picture": picture, "date": date])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var _id: GraphQLID {
        get {
          return resultMap["_id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "_id")
        }
      }

      public var title: String? {
        get {
          return resultMap["title"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "title")
        }
      }

      public var description: String? {
        get {
          return resultMap["description"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }

      public var picture: String? {
        get {
          return resultMap["picture"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "picture")
        }
      }

      public var date: String? {
        get {
          return resultMap["date"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "date")
        }
      }
    }
  }
}

public final class GetSectionShiftByClassIdQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetSectionShiftByClassId($classId: ID, $academicYearId: ID, $programId: ID) {
      getSectionShiftByClassId(
        classId: $classId
        academicYearId: $academicYearId
        programId: $programId
      ) {
        __typename
        _id
        sectionShiftName
        schoolId {
          __typename
          _id
        }
        academicYearId {
          __typename
          _id
          academicYear
        }
        programId {
          __typename
          _id
          programmName
        }
        classId {
          __typename
          _id
          className
        }
        sections {
          __typename
          _id
          subjectId {
            __typename
            _id
            subjectName
          }
          leadTeacherId {
            __typename
            _id
            firstName
            lastName
            englishName
          }
          duration
          startTime
          endTime
          breakTime
          dayOfWeek
          teacherAssistantId {
            __typename
            _id
            firstName
            lastName
          }
        }
      }
    }
    """

  public let operationName: String = "GetSectionShiftByClassId"

  public var classId: GraphQLID?
  public var academicYearId: GraphQLID?
  public var programId: GraphQLID?

  public init(classId: GraphQLID? = nil, academicYearId: GraphQLID? = nil, programId: GraphQLID? = nil) {
    self.classId = classId
    self.academicYearId = academicYearId
    self.programId = programId
  }

  public var variables: GraphQLMap? {
    return ["classId": classId, "academicYearId": academicYearId, "programId": programId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("getSectionShiftByClassId", arguments: ["classId": GraphQLVariable("classId"), "academicYearId": GraphQLVariable("academicYearId"), "programId": GraphQLVariable("programId")], type: .object(GetSectionShiftByClassId.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getSectionShiftByClassId: GetSectionShiftByClassId? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getSectionShiftByClassId": getSectionShiftByClassId.flatMap { (value: GetSectionShiftByClassId) -> ResultMap in value.resultMap }])
    }

    public var getSectionShiftByClassId: GetSectionShiftByClassId? {
      get {
        return (resultMap["getSectionShiftByClassId"] as? ResultMap).flatMap { GetSectionShiftByClassId(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getSectionShiftByClassId")
      }
    }

    public struct GetSectionShiftByClassId: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["SectionShift"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("_id", type: .scalar(GraphQLID.self)),
          GraphQLField("sectionShiftName", type: .scalar(String.self)),
          GraphQLField("schoolId", type: .object(SchoolId.selections)),
          GraphQLField("academicYearId", type: .object(AcademicYearId.selections)),
          GraphQLField("programId", type: .object(ProgramId.selections)),
          GraphQLField("classId", type: .object(ClassId.selections)),
          GraphQLField("sections", type: .list(.object(Section.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(_id: GraphQLID? = nil, sectionShiftName: String? = nil, schoolId: SchoolId? = nil, academicYearId: AcademicYearId? = nil, programId: ProgramId? = nil, classId: ClassId? = nil, sections: [Section?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "SectionShift", "_id": _id, "sectionShiftName": sectionShiftName, "schoolId": schoolId.flatMap { (value: SchoolId) -> ResultMap in value.resultMap }, "academicYearId": academicYearId.flatMap { (value: AcademicYearId) -> ResultMap in value.resultMap }, "programId": programId.flatMap { (value: ProgramId) -> ResultMap in value.resultMap }, "classId": classId.flatMap { (value: ClassId) -> ResultMap in value.resultMap }, "sections": sections.flatMap { (value: [Section?]) -> [ResultMap?] in value.map { (value: Section?) -> ResultMap? in value.flatMap { (value: Section) -> ResultMap in value.resultMap } } }])
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

      public var sectionShiftName: String? {
        get {
          return resultMap["sectionShiftName"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "sectionShiftName")
        }
      }

      public var schoolId: SchoolId? {
        get {
          return (resultMap["schoolId"] as? ResultMap).flatMap { SchoolId(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "schoolId")
        }
      }

      public var academicYearId: AcademicYearId? {
        get {
          return (resultMap["academicYearId"] as? ResultMap).flatMap { AcademicYearId(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "academicYearId")
        }
      }

      public var programId: ProgramId? {
        get {
          return (resultMap["programId"] as? ResultMap).flatMap { ProgramId(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "programId")
        }
      }

      public var classId: ClassId? {
        get {
          return (resultMap["classId"] as? ResultMap).flatMap { ClassId(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "classId")
        }
      }

      public var sections: [Section?]? {
        get {
          return (resultMap["sections"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Section?] in value.map { (value: ResultMap?) -> Section? in value.flatMap { (value: ResultMap) -> Section in Section(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Section?]) -> [ResultMap?] in value.map { (value: Section?) -> ResultMap? in value.flatMap { (value: Section) -> ResultMap in value.resultMap } } }, forKey: "sections")
        }
      }

      public struct SchoolId: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["School"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("_id", type: .nonNull(.scalar(GraphQLID.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(_id: GraphQLID) {
          self.init(unsafeResultMap: ["__typename": "School", "_id": _id])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var _id: GraphQLID {
          get {
            return resultMap["_id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "_id")
          }
        }
      }

      public struct AcademicYearId: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["AcademicYear"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("_id", type: .scalar(GraphQLID.self)),
            GraphQLField("academicYear", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(_id: GraphQLID? = nil, academicYear: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "AcademicYear", "_id": _id, "academicYear": academicYear])
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

        public var academicYear: String? {
          get {
            return resultMap["academicYear"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "academicYear")
          }
        }
      }

      public struct ProgramId: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Program"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("_id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("programmName", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(_id: GraphQLID, programmName: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "Program", "_id": _id, "programmName": programmName])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var _id: GraphQLID {
          get {
            return resultMap["_id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "_id")
          }
        }

        public var programmName: String? {
          get {
            return resultMap["programmName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "programmName")
          }
        }
      }

      public struct ClassId: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Classes"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("_id", type: .scalar(GraphQLID.self)),
            GraphQLField("className", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(_id: GraphQLID? = nil, className: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "Classes", "_id": _id, "className": className])
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

        public var className: String? {
          get {
            return resultMap["className"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "className")
          }
        }
      }

      public struct Section: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Section"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("_id", type: .scalar(GraphQLID.self)),
            GraphQLField("subjectId", type: .object(SubjectId.selections)),
            GraphQLField("leadTeacherId", type: .object(LeadTeacherId.selections)),
            GraphQLField("duration", type: .scalar(Double.self)),
            GraphQLField("startTime", type: .scalar(Double.self)),
            GraphQLField("endTime", type: .scalar(Double.self)),
            GraphQLField("breakTime", type: .scalar(Bool.self)),
            GraphQLField("dayOfWeek", type: .scalar(String.self)),
            GraphQLField("teacherAssistantId", type: .object(TeacherAssistantId.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(_id: GraphQLID? = nil, subjectId: SubjectId? = nil, leadTeacherId: LeadTeacherId? = nil, duration: Double? = nil, startTime: Double? = nil, endTime: Double? = nil, breakTime: Bool? = nil, dayOfWeek: String? = nil, teacherAssistantId: TeacherAssistantId? = nil) {
          self.init(unsafeResultMap: ["__typename": "Section", "_id": _id, "subjectId": subjectId.flatMap { (value: SubjectId) -> ResultMap in value.resultMap }, "leadTeacherId": leadTeacherId.flatMap { (value: LeadTeacherId) -> ResultMap in value.resultMap }, "duration": duration, "startTime": startTime, "endTime": endTime, "breakTime": breakTime, "dayOfWeek": dayOfWeek, "teacherAssistantId": teacherAssistantId.flatMap { (value: TeacherAssistantId) -> ResultMap in value.resultMap }])
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

        public var subjectId: SubjectId? {
          get {
            return (resultMap["subjectId"] as? ResultMap).flatMap { SubjectId(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "subjectId")
          }
        }

        public var leadTeacherId: LeadTeacherId? {
          get {
            return (resultMap["leadTeacherId"] as? ResultMap).flatMap { LeadTeacherId(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "leadTeacherId")
          }
        }

        public var duration: Double? {
          get {
            return resultMap["duration"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "duration")
          }
        }

        public var startTime: Double? {
          get {
            return resultMap["startTime"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "startTime")
          }
        }

        public var endTime: Double? {
          get {
            return resultMap["endTime"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "endTime")
          }
        }

        public var breakTime: Bool? {
          get {
            return resultMap["breakTime"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "breakTime")
          }
        }

        public var dayOfWeek: String? {
          get {
            return resultMap["dayOfWeek"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "dayOfWeek")
          }
        }

        public var teacherAssistantId: TeacherAssistantId? {
          get {
            return (resultMap["teacherAssistantId"] as? ResultMap).flatMap { TeacherAssistantId(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "teacherAssistantId")
          }
        }

        public struct SubjectId: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Subject"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("_id", type: .nonNull(.scalar(GraphQLID.self))),
              GraphQLField("subjectName", type: .scalar(String.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(_id: GraphQLID, subjectName: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "Subject", "_id": _id, "subjectName": subjectName])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var _id: GraphQLID {
            get {
              return resultMap["_id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "_id")
            }
          }

          public var subjectName: String? {
            get {
              return resultMap["subjectName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "subjectName")
            }
          }
        }

        public struct LeadTeacherId: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["PersonalInfo"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("_id", type: .scalar(GraphQLID.self)),
              GraphQLField("firstName", type: .scalar(String.self)),
              GraphQLField("lastName", type: .scalar(String.self)),
              GraphQLField("englishName", type: .scalar(String.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(_id: GraphQLID? = nil, firstName: String? = nil, lastName: String? = nil, englishName: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "PersonalInfo", "_id": _id, "firstName": firstName, "lastName": lastName, "englishName": englishName])
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
        }

        public struct TeacherAssistantId: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["PersonalInfo"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("_id", type: .scalar(GraphQLID.self)),
              GraphQLField("firstName", type: .scalar(String.self)),
              GraphQLField("lastName", type: .scalar(String.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(_id: GraphQLID? = nil, firstName: String? = nil, lastName: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "PersonalInfo", "_id": _id, "firstName": firstName, "lastName": lastName])
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
        }
      }
    }
  }
}

public final class GetEnrollmentByStudentsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetEnrollmentByStudents($studentId: ID) {
      getEnrollmentByStudents(studentId: $studentId) {
        __typename
        enrollmentId
        firstName
        lastName
        englishName
        programName
        programId
        gradeName
        gradeId
        shiftName
        shiftId
        className
        classId
        academicYearName
        academicYearId
        status
      }
    }
    """

  public let operationName: String = "GetEnrollmentByStudents"

  public var studentId: GraphQLID?

  public init(studentId: GraphQLID? = nil) {
    self.studentId = studentId
  }

  public var variables: GraphQLMap? {
    return ["studentId": studentId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("getEnrollmentByStudents", arguments: ["studentId": GraphQLVariable("studentId")], type: .list(.object(GetEnrollmentByStudent.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getEnrollmentByStudents: [GetEnrollmentByStudent?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getEnrollmentByStudents": getEnrollmentByStudents.flatMap { (value: [GetEnrollmentByStudent?]) -> [ResultMap?] in value.map { (value: GetEnrollmentByStudent?) -> ResultMap? in value.flatMap { (value: GetEnrollmentByStudent) -> ResultMap in value.resultMap } } }])
    }

    public var getEnrollmentByStudents: [GetEnrollmentByStudent?]? {
      get {
        return (resultMap["getEnrollmentByStudents"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [GetEnrollmentByStudent?] in value.map { (value: ResultMap?) -> GetEnrollmentByStudent? in value.flatMap { (value: ResultMap) -> GetEnrollmentByStudent in GetEnrollmentByStudent(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [GetEnrollmentByStudent?]) -> [ResultMap?] in value.map { (value: GetEnrollmentByStudent?) -> ResultMap? in value.flatMap { (value: GetEnrollmentByStudent) -> ResultMap in value.resultMap } } }, forKey: "getEnrollmentByStudents")
      }
    }

    public struct GetEnrollmentByStudent: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["GetEnrollmentDataActiveYear"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("enrollmentId", type: .scalar(GraphQLID.self)),
          GraphQLField("firstName", type: .scalar(String.self)),
          GraphQLField("lastName", type: .scalar(String.self)),
          GraphQLField("englishName", type: .scalar(String.self)),
          GraphQLField("programName", type: .scalar(String.self)),
          GraphQLField("programId", type: .scalar(GraphQLID.self)),
          GraphQLField("gradeName", type: .scalar(String.self)),
          GraphQLField("gradeId", type: .scalar(GraphQLID.self)),
          GraphQLField("shiftName", type: .scalar(String.self)),
          GraphQLField("shiftId", type: .scalar(GraphQLID.self)),
          GraphQLField("className", type: .scalar(String.self)),
          GraphQLField("classId", type: .scalar(GraphQLID.self)),
          GraphQLField("academicYearName", type: .scalar(String.self)),
          GraphQLField("academicYearId", type: .scalar(GraphQLID.self)),
          GraphQLField("status", type: .scalar(Bool.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(enrollmentId: GraphQLID? = nil, firstName: String? = nil, lastName: String? = nil, englishName: String? = nil, programName: String? = nil, programId: GraphQLID? = nil, gradeName: String? = nil, gradeId: GraphQLID? = nil, shiftName: String? = nil, shiftId: GraphQLID? = nil, className: String? = nil, classId: GraphQLID? = nil, academicYearName: String? = nil, academicYearId: GraphQLID? = nil, status: Bool? = nil) {
        self.init(unsafeResultMap: ["__typename": "GetEnrollmentDataActiveYear", "enrollmentId": enrollmentId, "firstName": firstName, "lastName": lastName, "englishName": englishName, "programName": programName, "programId": programId, "gradeName": gradeName, "gradeId": gradeId, "shiftName": shiftName, "shiftId": shiftId, "className": className, "classId": classId, "academicYearName": academicYearName, "academicYearId": academicYearId, "status": status])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var enrollmentId: GraphQLID? {
        get {
          return resultMap["enrollmentId"] as? GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "enrollmentId")
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

      public var programName: String? {
        get {
          return resultMap["programName"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "programName")
        }
      }

      public var programId: GraphQLID? {
        get {
          return resultMap["programId"] as? GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "programId")
        }
      }

      public var gradeName: String? {
        get {
          return resultMap["gradeName"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "gradeName")
        }
      }

      public var gradeId: GraphQLID? {
        get {
          return resultMap["gradeId"] as? GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "gradeId")
        }
      }

      public var shiftName: String? {
        get {
          return resultMap["shiftName"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "shiftName")
        }
      }

      public var shiftId: GraphQLID? {
        get {
          return resultMap["shiftId"] as? GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "shiftId")
        }
      }

      public var className: String? {
        get {
          return resultMap["className"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "className")
        }
      }

      public var classId: GraphQLID? {
        get {
          return resultMap["classId"] as? GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "classId")
        }
      }

      public var academicYearName: String? {
        get {
          return resultMap["academicYearName"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "academicYearName")
        }
      }

      public var academicYearId: GraphQLID? {
        get {
          return resultMap["academicYearId"] as? GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "academicYearId")
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
    }
  }
}

public final class GetInvoiceBystudentIdWithPaginationQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetInvoiceBystudentIdWithPagination($studentId: ID) {
      getInvoiceBystudentIdWithPagination(studentId: $studentId) {
        __typename
        invoices {
          __typename
          _id
          Amount
          createdAt
        }
      }
    }
    """

  public let operationName: String = "GetInvoiceBystudentIdWithPagination"

  public var studentId: GraphQLID?

  public init(studentId: GraphQLID? = nil) {
    self.studentId = studentId
  }

  public var variables: GraphQLMap? {
    return ["studentId": studentId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("getInvoiceBystudentIdWithPagination", arguments: ["studentId": GraphQLVariable("studentId")], type: .nonNull(.object(GetInvoiceBystudentIdWithPagination.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getInvoiceBystudentIdWithPagination: GetInvoiceBystudentIdWithPagination) {
      self.init(unsafeResultMap: ["__typename": "Query", "getInvoiceBystudentIdWithPagination": getInvoiceBystudentIdWithPagination.resultMap])
    }

    public var getInvoiceBystudentIdWithPagination: GetInvoiceBystudentIdWithPagination {
      get {
        return GetInvoiceBystudentIdWithPagination(unsafeResultMap: resultMap["getInvoiceBystudentIdWithPagination"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "getInvoiceBystudentIdWithPagination")
      }
    }

    public struct GetInvoiceBystudentIdWithPagination: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["InvoicePaginator"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("invoices", type: .nonNull(.list(.nonNull(.object(Invoice.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(invoices: [Invoice]) {
        self.init(unsafeResultMap: ["__typename": "InvoicePaginator", "invoices": invoices.map { (value: Invoice) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var invoices: [Invoice] {
        get {
          return (resultMap["invoices"] as! [ResultMap]).map { (value: ResultMap) -> Invoice in Invoice(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Invoice) -> ResultMap in value.resultMap }, forKey: "invoices")
        }
      }

      public struct Invoice: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Invoice"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("_id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("Amount", type: .scalar(Double.self)),
            GraphQLField("createdAt", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(_id: GraphQLID, amount: Double? = nil, createdAt: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "Invoice", "_id": _id, "Amount": amount, "createdAt": createdAt])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var _id: GraphQLID {
          get {
            return resultMap["_id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "_id")
          }
        }

        public var amount: Double? {
          get {
            return resultMap["Amount"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "Amount")
          }
        }

        public var createdAt: String? {
          get {
            return resultMap["createdAt"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "createdAt")
          }
        }
      }
    }
  }
}

public final class UpdateMobileUserProfileImgMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation UpdateMobileUserProfileImg($mobileUserId: ID, $profileImage: String) {
      updateMobileUserProfileImg(
        mobileUserId: $mobileUserId
        profileImage: $profileImage
      ) {
        __typename
        success
        message
      }
    }
    """

  public let operationName: String = "UpdateMobileUserProfileImg"

  public var mobileUserId: GraphQLID?
  public var profileImage: String?

  public init(mobileUserId: GraphQLID? = nil, profileImage: String? = nil) {
    self.mobileUserId = mobileUserId
    self.profileImage = profileImage
  }

  public var variables: GraphQLMap? {
    return ["mobileUserId": mobileUserId, "profileImage": profileImage]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("updateMobileUserProfileImg", arguments: ["mobileUserId": GraphQLVariable("mobileUserId"), "profileImage": GraphQLVariable("profileImage")], type: .nonNull(.object(UpdateMobileUserProfileImg.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(updateMobileUserProfileImg: UpdateMobileUserProfileImg) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "updateMobileUserProfileImg": updateMobileUserProfileImg.resultMap])
    }

    public var updateMobileUserProfileImg: UpdateMobileUserProfileImg {
      get {
        return UpdateMobileUserProfileImg(unsafeResultMap: resultMap["updateMobileUserProfileImg"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "updateMobileUserProfileImg")
      }
    }

    public struct UpdateMobileUserProfileImg: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["MobileUserResponse"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("success", type: .scalar(Bool.self)),
          GraphQLField("message", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(success: Bool? = nil, message: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "MobileUserResponse", "success": success, "message": message])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var success: Bool? {
        get {
          return resultMap["success"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "success")
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
