// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension BeMatch {
  class ActiveInvitationCampaignQuery: GraphQLQuery {
    public static let operationName: String = "ActiveInvitationCampaign"
    public static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query ActiveInvitationCampaign { activeInvitationCampaign { __typename id } }"#
      ))

    public init() {}

    public struct Data: BeMatch.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { BeMatch.Objects.Query }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("activeInvitationCampaign", ActiveInvitationCampaign?.self),
      ] }

      /// 招待キャンペーンを取得
      public var activeInvitationCampaign: ActiveInvitationCampaign? { __data["activeInvitationCampaign"] }

      /// ActiveInvitationCampaign
      ///
      /// Parent Type: `InvitationCampaign`
      public struct ActiveInvitationCampaign: BeMatch.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { BeMatch.Objects.InvitationCampaign }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", BeMatch.ID.self),
        ] }

        public var id: BeMatch.ID { __data["id"] }
      }
    }
  }
}
