// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension BeMatch {
  class UsersByLikerQuery: GraphQLQuery {
    public static let operationName: String = "UsersByLiker"
    public static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query UsersByLiker { usersByLiker { __typename ...SwipeCard } }"#,
        fragments: [PictureSlider.self, SwipeCard.self]
      ))

    public init() {}

    public struct Data: BeMatch.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { BeMatch.Objects.Query }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("usersByLiker", [UsersByLiker].self),
      ] }

      /// LIKEしてくれたユーザー一覧
      public var usersByLiker: [UsersByLiker] { __data["usersByLiker"] }

      /// UsersByLiker
      ///
      /// Parent Type: `User`
      public struct UsersByLiker: BeMatch.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { BeMatch.Objects.User }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .fragment(SwipeCard.self),
        ] }

        /// user id
        public var id: BeMatch.ID { __data["id"] }
        /// 一言コメント
        public var shortComment: ShortComment? { __data["shortComment"] }
        /// ユーザーの画像一覧
        public var images: [Image] { __data["images"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var swipeCard: SwipeCard { _toFragment() }
          public var pictureSlider: PictureSlider { _toFragment() }
        }

        /// UsersByLiker.ShortComment
        ///
        /// Parent Type: `ShortComment`
        public struct ShortComment: BeMatch.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { BeMatch.Objects.ShortComment }

          public var id: BeMatch.ID { __data["id"] }
          public var body: String { __data["body"] }
        }

        public typealias Image = PictureSlider.Image
      }
    }
  }
}
