CREATE TABLE [dbo].[CD_Facebook_Ads_Reach_ToDate] (
    [dt_created]          DATETIME        NULL,
    [dt_updated]          DATETIME        NULL,
    [dt_filename]         NVARCHAR (255)  NULL,
    [impressions]         BIGINT          NULL,
    [campaign_id]         BIGINT          NOT NULL,
    [reach]               BIGINT          NULL,
    [inline_link_clicks]  BIGINT          NULL,
    [campaign_name]       NVARCHAR (MAX)  NULL,
    [account_id]          BIGINT          NOT NULL,
    [date_start]          DATE            NULL,
    [account_name]        NVARCHAR (MAX)  NULL,
    [frequency]           NUMERIC (20, 4) NULL,
    [spend]               NUMERIC (20, 4) NULL,
    [campaign_stop_time]  DATETIME        NULL,
    [campaign_start_time] DATETIME        NULL,
    PRIMARY KEY CLUSTERED ([campaign_id] ASC, [account_id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [ix_CD_Facebook_Ads_Reach_ToDate_dt_filename]
    ON [dbo].[CD_Facebook_Ads_Reach_ToDate]([dt_filename] ASC);


GO
CREATE TRIGGER [dbo].[CD_Facebook_Ads_Reach_ToDate_dss_delete_trigger] ON [dbo].[CD_Facebook_Ads_Reach_ToDate] FOR DELETE AS
SET NOCOUNT ON
DECLARE @marker_create_scope_local_id INT
DECLARE @marker_scope_create_peer_timestamp BIGINT
DECLARE @marker_scope_create_peer_key INT
DECLARE @marker_local_create_peer_timestamp BIGINT
DECLARE @marker_local_create_peer_key INT
DECLARE @marker_state INT
SELECT TOP 1 @marker_create_scope_local_id = [provision_scope_local_id], @marker_local_create_peer_timestamp = [provision_timestamp], @marker_local_create_peer_key = [provision_local_peer_key], @marker_scope_create_peer_timestamp = [provision_scope_peer_timestamp], @marker_scope_create_peer_key = [provision_scope_peer_key], @marker_state = [state]
FROM [DataSync].[provision_marker_dss]
WHERE [object_id] = 312908732 
 AND [owner_scope_local_id] = 0

MERGE [DataSync].[CD_Facebook_Ads_Reach_ToDate_dss_tracking] AS [target] 
USING (SELECT [i].[campaign_id], [i].[account_id] FROM DELETED AS [i]) AS source([campaign_id], [account_id]) 
ON ([target].[campaign_id] = [source].[campaign_id] AND [target].[account_id] = [source].[account_id])
WHEN MATCHED THEN
UPDATE SET [sync_row_is_tombstone] = 1, 
[local_update_peer_key] = 0, 
[update_scope_local_id] = NULL, [last_change_datetime] = GETDATE()
WHEN NOT MATCHED THEN
INSERT (
[campaign_id], [account_id] ,
[create_scope_local_id], [scope_create_peer_key], [scope_create_peer_timestamp], [local_create_peer_key], [local_create_peer_timestamp], [update_scope_local_id], [local_update_peer_key], [sync_row_is_tombstone], [last_change_datetime]) 
VALUES (
[source].[campaign_id], [source].[account_id],@marker_create_scope_local_id, @marker_scope_create_peer_key, @marker_scope_create_peer_timestamp, 0, @marker_local_create_peer_timestamp , NULL, 0, 1, GETDATE() );
GO
CREATE TRIGGER [dbo].[CD_Facebook_Ads_Reach_ToDate_dss_update_trigger] ON [dbo].[CD_Facebook_Ads_Reach_ToDate] FOR UPDATE AS
SET NOCOUNT ON
DECLARE @marker_create_scope_local_id INT
DECLARE @marker_scope_create_peer_timestamp BIGINT
DECLARE @marker_scope_create_peer_key INT
DECLARE @marker_local_create_peer_timestamp BIGINT
DECLARE @marker_local_create_peer_key INT
DECLARE @marker_state INT
SELECT TOP 1 @marker_create_scope_local_id = [provision_scope_local_id], @marker_local_create_peer_timestamp = [provision_timestamp], @marker_local_create_peer_key = [provision_local_peer_key], @marker_scope_create_peer_timestamp = [provision_scope_peer_timestamp], @marker_scope_create_peer_key = [provision_scope_peer_key], @marker_state = [state]
FROM [DataSync].[provision_marker_dss]
WHERE [object_id] = 312908732 
 AND [owner_scope_local_id] = 0

MERGE [DataSync].[CD_Facebook_Ads_Reach_ToDate_dss_tracking] AS [target] 
USING (SELECT [i].[campaign_id], [i].[account_id] FROM INSERTED AS [i]) AS source([campaign_id], [account_id]) 
ON ([target].[campaign_id] = [source].[campaign_id] AND [target].[account_id] = [source].[account_id])
WHEN MATCHED THEN
UPDATE SET [sync_row_is_tombstone] = 0, 
[local_update_peer_key] = 0, 
[update_scope_local_id] = NULL, [last_change_datetime] = GETDATE()
WHEN NOT MATCHED THEN
INSERT (
[campaign_id], [account_id] ,
[create_scope_local_id], [scope_create_peer_key], [scope_create_peer_timestamp], [local_create_peer_key], [local_create_peer_timestamp], [update_scope_local_id], [local_update_peer_key], [sync_row_is_tombstone], [last_change_datetime]) 
VALUES (
[source].[campaign_id], [source].[account_id],@marker_create_scope_local_id, @marker_scope_create_peer_key, @marker_scope_create_peer_timestamp, 0, @marker_local_create_peer_timestamp , NULL, 0, 0, GETDATE() );
GO
CREATE TRIGGER [dbo].[CD_Facebook_Ads_Reach_ToDate_dss_insert_trigger] ON [dbo].[CD_Facebook_Ads_Reach_ToDate] FOR INSERT AS
SET NOCOUNT ON
DECLARE @marker_create_scope_local_id INT
DECLARE @marker_scope_create_peer_timestamp BIGINT
DECLARE @marker_scope_create_peer_key INT
DECLARE @marker_local_create_peer_timestamp BIGINT
DECLARE @marker_local_create_peer_key INT
DECLARE @marker_state INT
SELECT TOP 1 @marker_create_scope_local_id = [provision_scope_local_id], @marker_local_create_peer_timestamp = [provision_timestamp], @marker_local_create_peer_key = [provision_local_peer_key], @marker_scope_create_peer_timestamp = [provision_scope_peer_timestamp], @marker_scope_create_peer_key = [provision_scope_peer_key], @marker_state = [state]
FROM [DataSync].[provision_marker_dss]
WHERE [object_id] = 312908732 
 AND [owner_scope_local_id] = 0

MERGE [DataSync].[CD_Facebook_Ads_Reach_ToDate_dss_tracking] AS [target] 
USING (SELECT [i].[campaign_id], [i].[account_id] FROM INSERTED AS [i]) AS source([campaign_id], [account_id]) 
ON ([target].[campaign_id] = [source].[campaign_id] AND [target].[account_id] = [source].[account_id])
WHEN MATCHED THEN
UPDATE SET [sync_row_is_tombstone] = 0, 
[local_update_peer_key] = 0, 
[update_scope_local_id] = NULL, [last_change_datetime] = GETDATE()
WHEN NOT MATCHED THEN
INSERT (
[campaign_id], [account_id] ,
[create_scope_local_id], [scope_create_peer_key], [scope_create_peer_timestamp], [local_create_peer_key], [local_create_peer_timestamp], [update_scope_local_id], [local_update_peer_key], [sync_row_is_tombstone], [last_change_datetime]) 
VALUES (
[source].[campaign_id], [source].[account_id],NULL, NULL, NULL, 0, CAST(@@DBTS AS BIGINT) + 1, NULL, 0, 0, GETDATE() );