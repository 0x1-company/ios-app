// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension BeMatch {
  class DirectMessageQuery: GraphQLQuery {
    public static let operationName: String = "DirectMessage"
    public static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query DirectMessage($targetUserId: ID!, $first: Int!) { currentUser { __typename id berealUsername } messages(targetUserId: $targetUserId, first: $first) { __typename pageInfo { __typename hasNextPage endCursor } edges { __typename node { __typename ...MessageRow } } } }"#,
        fragments: [MessageRow.self]
      ))

    public var targetUserId: ID
    public var first: Int

    public init(
      targetUserId: ID,
      first: Int
    ) {
      self.targetUserId = targetUserId
      self.first = first
    }

    public var __variables: Variables? { [
      "targetUserId": targetUserId,
      "first": first,
    ] }

    public struct Data: BeMatch.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { BeMatch.Objects.Query }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("currentUser", CurrentUser.self),
        .field("messages", Messages.self, arguments: [
          "targetUserId": .variable("targetUserId"),
          "first": .variable("first"),
        ]),
      ] }

      /// ログイン中ユーザーを取得
      public var currentUser: CurrentUser { __data["currentUser"] }
      /// 特定のユーザーとのメッセージ一覧
      public var messages: Messages { __data["messages"] }

      /// CurrentUser
      ///
      /// Parent Type: `User`
      public struct CurrentUser: BeMatch.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { BeMatch.Objects.User }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", BeMatch.ID.self),
          .field("berealUsername", String.self),
        ] }

        /// user id
        public var id: BeMatch.ID { __data["id"] }
        /// BeRealのusername
        public var berealUsername: String { __data["berealUsername"] }
      }

      /// Messages
      ///
      /// Parent Type: `MessageConnection`
      public struct Messages: BeMatch.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { BeMatch.Objects.MessageConnection }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("pageInfo", PageInfo.self),
          .field("edges", [Edge].self),
        ] }

        public var pageInfo: PageInfo { __data["pageInfo"] }
        public var edges: [Edge] { __data["edges"] }

        /// Messages.PageInfo
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

        /// Messages.Edge
        ///
        /// Parent Type: `MessageEdge`
        public struct Edge: BeMatch.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { BeMatch.Objects.MessageEdge }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("node", Node.self),
          ] }

          public var node: Node { __data["node"] }

          /// Messages.Edge.Node
          ///
          /// Parent Type: `Message`
          public struct Node: BeMatch.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { BeMatch.Objects.Message }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .fragment(MessageRow.self),
            ] }

            public var id: BeMatch.ID { __data["id"] }
            public var text: String { __data["text"] }
            public var userId: BeMatch.ID { __data["userId"] }
            public var isAuthor: Bool { __data["isAuthor"] }
            public var createdAt: BeMatch.Date { __data["createdAt"] }

            public struct Fragments: FragmentContainer {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public var messageRow: MessageRow { _toFragment() }
            }
          }
        }
      }
    }
  }
}
