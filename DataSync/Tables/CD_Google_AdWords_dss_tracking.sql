CREATE TABLE [DataSync].[CD_Google_AdWords_dss_tracking] (
    [client_customer_id]          BIGINT         NOT NULL,
    [network_w_search_partners]   NVARCHAR (200) NOT NULL,
    [campaign_id]                 BIGINT         NOT NULL,
    [day]                         DATE           NOT NULL,
    [deviceseg]                   NVARCHAR (200) NOT NULL,
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
    CONSTRAINT [PK_DataSync.CD_Google_AdWords_dss_tracking] PRIMARY KEY CLUSTERED ([client_customer_id] ASC, [network_w_search_partners] ASC, [campaign_id] ASC, [day] ASC, [deviceseg] ASC)
);


GO
CREATE NONCLUSTERED INDEX [tombstone_index]
    ON [DataSync].[CD_Google_AdWords_dss_tracking]([sync_row_is_tombstone] ASC, [local_update_peer_timestamp] ASC)
    INCLUDE([last_change_datetime]);


GO
CREATE NONCLUSTERED INDEX [local_update_peer_timestamp_index]
    ON [DataSync].[CD_Google_AdWords_dss_tracking]([local_update_peer_timestamp] ASC, [client_customer_id] ASC, [network_w_search_partners] ASC, [campaign_id] ASC, [day] ASC, [deviceseg] ASC);

