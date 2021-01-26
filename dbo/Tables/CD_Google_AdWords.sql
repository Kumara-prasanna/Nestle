CREATE TABLE [dbo].[CD_Google_AdWords] (
    [dt_created]                DATETIME        NULL,
    [dt_updated]                DATETIME        NULL,
    [dt_filename]               NVARCHAR (255)  NULL,
    [client_customer_id]        BIGINT          NOT NULL,
    [client_customer_name]      NVARCHAR (MAX)  NULL,
    [currency]                  NVARCHAR (MAX)  NULL,
    [account]                   NVARCHAR (MAX)  NULL,
    [network]                   NVARCHAR (MAX)  NULL,
    [network_w_search_partners] NVARCHAR (200)  NOT NULL,
    [all_conv]                  NUMERIC (20, 4) NULL,
    [all_conv_value]            NUMERIC (20, 4) NULL,
    [budget]                    NUMERIC (20, 4) NULL,
    [campaign_id]               BIGINT          NOT NULL,
    [campaign]                  NVARCHAR (MAX)  NULL,
    [clicks]                    BIGINT          NULL,
    [conv_rate]                 FLOAT (53)      NULL,
    [conversions]               NUMERIC (20, 4) NULL,
    [total_conv_value]          NUMERIC (20, 4) NULL,
    [cost]                      NUMERIC (20, 4) NULL,
    [crossdevice_conv]          NVARCHAR (MAX)  NULL,
    [client_name]               NVARCHAR (MAX)  NULL,
    [day]                       DATE            NOT NULL,
    [deviceseg]                 NVARCHAR (200)  NOT NULL,
    [end_date]                  NVARCHAR (MAX)  NULL,
    [engagement_rate]           FLOAT (53)      NULL,
    [engagements]               BIGINT          NULL,
    [customer_id]               BIGINT          NULL,
    [impressions]               BIGINT          NULL,
    [interactions]              BIGINT          NULL,
    [invalid_clicks]            BIGINT          NULL,
    [labels]                    NVARCHAR (MAX)  NULL,
    [search_impr_share]         NVARCHAR (MAX)  NULL,
    [start_date]                DATE            NULL,
    [video_played_to_100]       FLOAT (53)      NULL,
    [video_played_to_25]        FLOAT (53)      NULL,
    [video_played_to_50]        FLOAT (53)      NULL,
    [video_played_to_75]        FLOAT (53)      NULL,
    [view_rate]                 FLOAT (53)      NULL,
    [views]                     BIGINT          NULL,
    [viewthrough_conv]          BIGINT          NULL,
    PRIMARY KEY CLUSTERED ([client_customer_id] ASC, [network_w_search_partners] ASC, [campaign_id] ASC, [day] ASC, [deviceseg] ASC)
);


GO
CREATE NONCLUSTERED INDEX [ix_CD_Google_AdWords_dt_filename]
    ON [dbo].[CD_Google_AdWords]([dt_filename] ASC);


GO
CREATE TRIGGER [dbo].[CD_Google_AdWords_dss_delete_trigger] ON [dbo].[CD_Google_AdWords] FOR DELETE AS
SET NOCOUNT ON
DECLARE @marker_create_scope_local_id INT
DECLARE @marker_scope_create_peer_timestamp BIGINT
DECLARE @marker_scope_create_peer_key INT
DECLARE @marker_local_create_peer_timestamp BIGINT
DECLARE @marker_local_create_peer_key INT
DECLARE @marker_state INT
SELECT TOP 1 @marker_create_scope_local_id = [provision_scope_local_id], @marker_local_create_peer_timestamp = [provision_timestamp], @marker_local_create_peer_key = [provision_local_peer_key], @marker_scope_create_peer_timestamp = [provision_scope_peer_timestamp], @marker_scope_create_peer_key = [provision_scope_peer_key], @marker_state = [state]
FROM [DataSync].[provision_marker_dss]
WHERE [object_id] = 14479676 
 AND [owner_scope_local_id] = 0

MERGE [DataSync].[CD_Google_AdWords_dss_tracking] AS [target] 
USING (SELECT [i].[client_customer_id], [i].[network_w_search_partners], [i].[campaign_id], [i].[day], [i].[deviceseg] FROM DELETED AS [i]) AS source([client_customer_id], [network_w_search_partners], [campaign_id], [day], [deviceseg]) 
ON ([target].[client_customer_id] = [source].[client_customer_id] AND [target].[network_w_search_partners] = [source].[network_w_search_partners] AND [target].[campaign_id] = [source].[campaign_id] AND [target].[day] = [source].[day] AND [target].[deviceseg] = [source].[deviceseg])
WHEN MATCHED THEN
UPDATE SET [sync_row_is_tombstone] = 1, 
[local_update_peer_key] = 0, 
[update_scope_local_id] = NULL, [last_change_datetime] = GETDATE()
WHEN NOT MATCHED THEN
INSERT (
[client_customer_id], [network_w_search_partners], [campaign_id], [day], [deviceseg] ,
[create_scope_local_id], [scope_create_peer_key], [scope_create_peer_timestamp], [local_create_peer_key], [local_create_peer_timestamp], [update_scope_local_id], [local_update_peer_key], [sync_row_is_tombstone], [last_change_datetime]) 
VALUES (
[source].[client_customer_id], [source].[network_w_search_partners], [source].[campaign_id], [source].[day], [source].[deviceseg],@marker_create_scope_local_id, @marker_scope_create_peer_key, @marker_scope_create_peer_timestamp, 0, @marker_local_create_peer_timestamp , NULL, 0, 1, GETDATE() );
GO
CREATE TRIGGER [dbo].[CD_Google_AdWords_dss_update_trigger] ON [dbo].[CD_Google_AdWords] FOR UPDATE AS
SET NOCOUNT ON
DECLARE @marker_create_scope_local_id INT
DECLARE @marker_scope_create_peer_timestamp BIGINT
DECLARE @marker_scope_create_peer_key INT
DECLARE @marker_local_create_peer_timestamp BIGINT
DECLARE @marker_local_create_peer_key INT
DECLARE @marker_state INT
SELECT TOP 1 @marker_create_scope_local_id = [provision_scope_local_id], @marker_local_create_peer_timestamp = [provision_timestamp], @marker_local_create_peer_key = [provision_local_peer_key], @marker_scope_create_peer_timestamp = [provision_scope_peer_timestamp], @marker_scope_create_peer_key = [provision_scope_peer_key], @marker_state = [state]
FROM [DataSync].[provision_marker_dss]
WHERE [object_id] = 14479676 
 AND [owner_scope_local_id] = 0

MERGE [DataSync].[CD_Google_AdWords_dss_tracking] AS [target] 
USING (SELECT [i].[client_customer_id], [i].[network_w_search_partners], [i].[campaign_id], [i].[day], [i].[deviceseg] FROM INSERTED AS [i]) AS source([client_customer_id], [network_w_search_partners], [campaign_id], [day], [deviceseg]) 
ON ([target].[client_customer_id] = [source].[client_customer_id] AND [target].[network_w_search_partners] = [source].[network_w_search_partners] AND [target].[campaign_id] = [source].[campaign_id] AND [target].[day] = [source].[day] AND [target].[deviceseg] = [source].[deviceseg])
WHEN MATCHED THEN
UPDATE SET [sync_row_is_tombstone] = 0, 
[local_update_peer_key] = 0, 
[update_scope_local_id] = NULL, [last_change_datetime] = GETDATE()
WHEN NOT MATCHED THEN
INSERT (
[client_customer_id], [network_w_search_partners], [campaign_id], [day], [deviceseg] ,
[create_scope_local_id], [scope_create_peer_key], [scope_create_peer_timestamp], [local_create_peer_key], [local_create_peer_timestamp], [update_scope_local_id], [local_update_peer_key], [sync_row_is_tombstone], [last_change_datetime]) 
VALUES (
[source].[client_customer_id], [source].[network_w_search_partners], [source].[campaign_id], [source].[day], [source].[deviceseg],@marker_create_scope_local_id, @marker_scope_create_peer_key, @marker_scope_create_peer_timestamp, 0, @marker_local_create_peer_timestamp , NULL, 0, 0, GETDATE() );
GO
CREATE TRIGGER [dbo].[CD_Google_AdWords_dss_insert_trigger] ON [dbo].[CD_Google_AdWords] FOR INSERT AS
SET NOCOUNT ON
DECLARE @marker_create_scope_local_id INT
DECLARE @marker_scope_create_peer_timestamp BIGINT
DECLARE @marker_scope_create_peer_key INT
DECLARE @marker_local_create_peer_timestamp BIGINT
DECLARE @marker_local_create_peer_key INT
DECLARE @marker_state INT
SELECT TOP 1 @marker_create_scope_local_id = [provision_scope_local_id], @marker_local_create_peer_timestamp = [provision_timestamp], @marker_local_create_peer_key = [provision_local_peer_key], @marker_scope_create_peer_timestamp = [provision_scope_peer_timestamp], @marker_scope_create_peer_key = [provision_scope_peer_key], @marker_state = [state]
FROM [DataSync].[provision_marker_dss]
WHERE [object_id] = 14479676 
 AND [owner_scope_local_id] = 0

MERGE [DataSync].[CD_Google_AdWords_dss_tracking] AS [target] 
USING (SELECT [i].[client_customer_id], [i].[network_w_search_partners], [i].[campaign_id], [i].[day], [i].[deviceseg] FROM INSERTED AS [i]) AS source([client_customer_id], [network_w_search_partners], [campaign_id], [day], [deviceseg]) 
ON ([target].[client_customer_id] = [source].[client_customer_id] AND [target].[network_w_search_partners] = [source].[network_w_search_partners] AND [target].[campaign_id] = [source].[campaign_id] AND [target].[day] = [source].[day] AND [target].[deviceseg] = [source].[deviceseg])
WHEN MATCHED THEN
UPDATE SET [sync_row_is_tombstone] = 0, 
[local_update_peer_key] = 0, 
[update_scope_local_id] = NULL, [last_change_datetime] = GETDATE()
WHEN NOT MATCHED THEN
INSERT (
[client_customer_id], [network_w_search_partners], [campaign_id], [day], [deviceseg] ,
[create_scope_local_id], [scope_create_peer_key], [scope_create_peer_timestamp], [local_create_peer_key], [local_create_peer_timestamp], [update_scope_local_id], [local_update_peer_key], [sync_row_is_tombstone], [last_change_datetime]) 
VALUES (
[source].[client_customer_id], [source].[network_w_search_partners], [source].[campaign_id], [source].[day], [source].[deviceseg],NULL, NULL, NULL, 0, CAST(@@DBTS AS BIGINT) + 1, NULL, 0, 0, GETDATE() );