CREATE TABLE [DataSync].[CD_Facebook_Ads_Publisher_Platform_dss_tracking] (
    [campaign_id]                 BIGINT         NOT NULL,
    [ad_id]                       BIGINT         NOT NULL,
    [adset_id]                    BIGINT         NOT NULL,
    [publisher_platform_pp]       NVARCHAR (200) NOT NULL,
    [platform_position_pp]        NVARCHAR (200) NOT NULL,
    [account_id]                  BIGINT         NOT NULL,
    [date_start]                  DATE           NOT NULL,
    [update_scope_local_id]       INT            NULL,
    [scope_update_peer_key]       INT            NULL,
    [scope_update_peer_timestamp] BIGINT         NULL,
    [local_update_peer_key]       INT            NOT NULL,
    [local_update_peer_timestamp] ROWVERSION     NOT NULL,
    [create_scope_local_id]       INT            NULL,
    [scope_create_peer_key]       INT            NULL,
    [scope_create_peer_timestamp] BIGINT         NULL,
    [local_create_peer_key]       INT            NOT NULL,
    [local_create_peer_timestamp] BIGINT         NOT NULL,
    [sync_row_is_tombstone]       INT            NOT NULL,
    [last_change_datetime]        DATETIME       NULL,
    CONSTRAINT [PK_DataSync.CD_Facebook_Ads_Publisher_Platform_dss_tracking] PRIMARY KEY CLUSTERED ([campaign_id] ASC, [ad_id] ASC, [adset_id] ASC, [publisher_platform_pp] ASC, [platform_position_pp] ASC, [account_id] ASC, [date_start] ASC)
);


GO
CREATE NONCLUSTERED INDEX [tombstone_index]
    ON [DataSync].[CD_Facebook_Ads_Publisher_Platform_dss_tracking]([sync_row_is_tombstone] ASC, [local_update_peer_timestamp] ASC)
    INCLUDE([last_change_datetime]);


GO
CREATE NONCLUSTERED INDEX [local_update_peer_timestamp_index]
    ON [DataSync].[CD_Facebook_Ads_Publisher_Platform_dss_tracking]([local_update_peer_timestamp] ASC, [campaign_id] ASC, [ad_id] ASC, [adset_id] ASC, [publisher_platform_pp] ASC, [platform_position_pp] ASC, [account_id] ASC, [date_start] ASC);

