CREATE PROCEDURE [DataSync].[CD_Facebook_Ads_Reach_ToDate_dss_updatemetadata]
	@P_5 BigInt,
	@P_9 BigInt,
	@sync_scope_local_id Int,
	@sync_row_is_tombstone Int,
	@sync_create_peer_key Int,
	@sync_create_peer_timestamp BigInt,
	@sync_update_peer_key Int,
	@sync_update_peer_timestamp BigInt,
	@sync_check_concurrency Int,
	@sync_row_timestamp BigInt,
	@sync_row_count Int OUTPUT
AS
BEGIN
SET @sync_row_count = 0; DECLARE @was_tombstone int; SELECT @was_tombstone = [sync_row_is_tombstone] FROM [DataSync].[CD_Facebook_Ads_Reach_ToDate_dss_tracking] WHERE ([campaign_id] = @P_5 AND [account_id] = @P_9);IF (@was_tombstone IS NOT NULL AND @was_tombstone = 1 AND @sync_row_is_tombstone = 0) BEGIN UPDATE [DataSync].[CD_Facebook_Ads_Reach_ToDate_dss_tracking] SET [create_scope_local_id] = @sync_scope_local_id, [scope_create_peer_key] = @sync_create_peer_key, [scope_create_peer_timestamp] = @sync_create_peer_timestamp, [local_create_peer_key] = 0, [local_create_peer_timestamp] = CAST(@@DBTS AS BIGINT) + 1, [update_scope_local_id] = @sync_scope_local_id, [scope_update_peer_key] = @sync_update_peer_key, [scope_update_peer_timestamp] = @sync_update_peer_timestamp, [local_update_peer_key] = 0, [sync_row_is_tombstone] = @sync_row_is_tombstone WHERE ([campaign_id] = @P_5 AND [account_id] = @P_9) AND (@sync_check_concurrency = 0 or [local_update_peer_timestamp] = @sync_row_timestamp); END ELSE BEGIN DECLARE @marker_create_scope_local_id INT
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
USING (SELECT [campaign_id], [account_id]
 FROM [dbo].[CD_Facebook_Ads_Reach_ToDate]
 WHERE [campaign_id] = @P_5 AND [account_id] = @P_9
) AS source([campaign_id], [account_id])
ON ([target].[campaign_id] = [source].[campaign_id] AND [target].[account_id] = [source].[account_id])
WHEN NOT MATCHED THEN
INSERT (
[campaign_id], [account_id] ,
[create_scope_local_id], [scope_create_peer_key], [scope_create_peer_timestamp], [local_create_peer_key], [local_create_peer_timestamp], [update_scope_local_id], [scope_update_peer_key], [scope_update_peer_timestamp], [local_update_peer_key], [sync_row_is_tombstone], [last_change_datetime]) 
VALUES (
[source].[campaign_id], [source].[account_id],NULL, @marker_scope_create_peer_key, @marker_scope_create_peer_timestamp, 0, @marker_local_create_peer_timestamp , @sync_scope_local_id, @sync_update_peer_key, @sync_update_peer_timestamp, 0, 0, GETDATE() );

SET @sync_row_count = @@ROWCOUNT
IF @sync_row_count = 0 
BEGIN
UPDATE [DataSync].[CD_Facebook_Ads_Reach_ToDate_dss_tracking] SET [update_scope_local_id] = @sync_scope_local_id, [scope_update_peer_key] = @sync_update_peer_key, [scope_update_peer_timestamp] = @sync_update_peer_timestamp, [local_update_peer_key] = 0, [sync_row_is_tombstone] = @sync_row_is_tombstone WHERE ([campaign_id] = @P_5 AND [account_id] = @P_9) AND (@sync_check_concurrency = 0 or [local_update_peer_timestamp] = @sync_row_timestamp);SET @sync_row_count = @@ROWCOUNT;
END
 END;
END