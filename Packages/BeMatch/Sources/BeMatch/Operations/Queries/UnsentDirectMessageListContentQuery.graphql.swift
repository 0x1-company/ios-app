// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension BeMatch {
  class UnsentDirectMessageListContentQuery: GraphQLQuery {
    public static let operationName: String = "UnsentDirectMessageListContent"
    public static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query UnsentDirectMessageListContent($first: Int!, $after: String) { matches(first: $first, after: $after) { __typename pageInfo { __typename hasNextPage endCursor } edges { __typename node { __typename ...UnsentDirectMessageListContentRow } } } }"#,
        fragments: [UnsentDirectMessageListContentRow.self]
      ))

    public var first: Int
    public var after: GraphQLNullable<String>

    public init(
      first: Int,
      after: GraphQLNullable<String>
    ) {
      self.first = first
      self.after = after
    }

    public var __variables: Variables? { [
      "first": first,
      "after": after,
    ] }

    public struct Data: BeMatch.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { BeMatch.Objects.Query }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("matches", Matches.self, arguments: [
          "first": .variable("first"),
          "after": .variable("after"),
        ]),
      ] }

      /// マッチ一覧
      public var matches: Matches { __data["matches"] }

      /// Matches
      ///
      /// Parent Type: `MatchConnection`
      public struct Matches: BeMatch.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { BeMatch.Objects.MatchConnection }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("pageInfo", PageInfo.self),
          .field("edges", [Edge].self),
        ] }

        public var pageInfo: PageInfo { __data["pageInfo"] }
        public var edges: [Edge] { __data["edges"] }

        /// Matches.PageInfo
        ///
        /// Parent Type: `PageInfo`
        public struct PageInfo: BeMatch.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { BeMatch.Objects.PageInfo }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("hasNextPage", Bool.self),
            .field("endCursor", String?.self),
          ] }

          /// 次のページがあるかどうか
          public var hasNextPage: Bool { __data["hasNextPage"] }
          /// 最後のedgeのカーソル
          public var endCursor: String? { __data["endCursor"] }
        }

        /// Matches.Edge
        ///
        /// Parent Type: `MatchEdge`
        public struct Edge: BeMatch.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { BeMatch.Objects.MatchEdge }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("node", Node.self),
          ] }

          public var node: Node { __data["node"] }

          /// Matches.Edge.Node
          ///
          /// Parent Type: `Match`
          public struct Node: BeMatch.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { BeMatch.Objects.Match }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .fragment(UnsentDirectMessageListContentRow.self),
            ] }

            /// match id
            public var id: BeMatch.ID { __data["id"] }
            /// 既読かどうか
            public var isRead: Bool { __data["isRead"] }
            public var createdAt: BeMatch.Date { __data["createdAt"] }
            /// マッチした相手
            public var targetUser: TargetUser { __data["targetUser"] }

            public struct Fragments: FragmentContainer {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public var unsentDirectMessageListContentRow: UnsentDirectMessageListContentRow { _toFragment() }
            }

            public typealias TargetUser = UnsentDirectMessageListContentRow.TargetUser
          }
        }
      }
    }
  }
}
