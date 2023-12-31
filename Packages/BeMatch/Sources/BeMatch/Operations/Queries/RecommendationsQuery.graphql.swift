// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension BeMatch {
  class RecommendationsQuery: GraphQLQuery {
    public static let operationName: String = "Recommendations"
    public static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query Recommendations { recommendations { __typename ...SwipeCard } }"#,
        fragments: [PictureSliderImage.self, SwipeCard.self]
      ))

    public init() {}

    public struct Data: BeMatch.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { BeMatch.Objects.Query }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("recommendations", [Recommendation].self),
      ] }

      /// ユーザー一覧
      public var recommendations: [Recommendation] { __data["recommendations"] }

      /// Recommendation
      ///
      /// Parent Type: `User`
      public struct Recommendation: BeMatch.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { BeMatch.Objects.User }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .fragment(SwipeCard.self),
        ] }

        /// user id
        public var id: BeMatch.ID { __data["id"] }
        /// ユーザーの画像一覧
        public var images: [Image] { __data["images"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var swipeCard: SwipeCard { _toFragment() }
        }

        /// Recommendation.Image
        ///
        /// Parent Type: `UserImage`
        public struct Image: BeMatch.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { BeMatch.Objects.UserImage }

          public var id: BeMatch.ID { __data["id"] }
          public var imageUrl: String { __data["imageUrl"] }

          public struct Fragments: FragmentContainer {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public var pictureSliderImage: PictureSliderImage { _toFragment() }
          }
        }
      }
    }
  }
}
