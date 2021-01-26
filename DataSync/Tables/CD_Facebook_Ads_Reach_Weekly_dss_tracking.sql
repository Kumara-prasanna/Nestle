CREATE TABLE [DataSync].[CD_Facebook_Ads_Reach_Weekly_dss_tracking] (
    [date_stop]                   DATE       NOT NULL,
    [campaign_id]                 BIGINT     NOT NULL,
    [account_id]                  BIGINT     NOT NULL,
    [date_start]                  DATE       NOT NULL,
    [update_scope_local_id]       INT        NULL,
    [scope_update_peer_key]       INT        NULL,
    [scope_update_peer_timestamp] BIGINT     NULL,
    [local_update_peer_key]       INT        NOT NULL,
    [local_update_peer_timestamp] ROWVERSION NOT NULL,
    [create_scope_local_id]       INT        NULL,
    [scope_create_peer_key]       INT        NULL,
    [scope_create_peer_timestamp] BIGINT     NULL,
    [local_create_peer_key]       INT        NOT NULL,
    [local_create_peer_timestamp] BIGINT     NOT NULL,
    [sync_row_is_tombstone]       INT        NOT NULL,
    [last_change_datetime]        DATETIME   NULL,
    CONSTRAINT [PK_DataSync.CD_Facebook_Ads_Reach_Weekly_dss_tracking] PRIMARY KEY CLUSTERED ([date_stop] ASC, [campaign_id] ASC, [account_id] ASC, [date_start] ASC)
);


GO
CREATE NONCLUSTERED INDEX [tombstone_index]
    ON [DataSync].[CD_Facebook_Ads_Reach_Weekly_dss_tracking]([sync_row_is_tombstone] ASC, [local_update_peer_timestamp] ASC)
    INCLUDE([last_change_datetime]);


GO
CREATE NONCLUSTERED INDEX [local_update_peer_timestamp_index]
    ON [DataSync].[CD_Facebook_Ads_Reach_Weekly_dss_tracking]([local_update_peer_timestamp] ASC, [date_stop] ASC, [campaign_id] ASC, [account_id] ASC, [date_start] ASC);

