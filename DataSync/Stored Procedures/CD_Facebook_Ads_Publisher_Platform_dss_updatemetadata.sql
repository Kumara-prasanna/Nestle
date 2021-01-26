CREATE PROCEDURE [DataSync].[CD_Facebook_Ads_Publisher_Platform_dss_updatemetadata]
	@P_5 BigInt,
	@P_9 BigInt,
	@P_13 BigInt,
	@P_19 NVarChar(200),
	@P_21 NVarChar(200),
	@P_31 BigInt,
	@P_33 Date,
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
SET @sync_row_count = 0; DECLARE @was_tombstone int; SELECT @was_tombstone = [sync_row_is_tombstone] FROM [DataSync].[CD_Facebook_Ads_Publisher_Platform_dss_tracking] WHERE ([campaign_id] = @P_5 AND [ad_id] = @P_9 AND [adset_id] = @P_13 AND [publisher_platform_pp] = @P_19 AND [platform_position_pp] = @P_21 AND [account_id] = @P_31 AND [date_start] = @P_33);IF (@was_tombstone IS NOT NULL AND @was_tombstone = 1 AND @sync_row_is_tombstone = 0) BEGIN UPDATE [DataSync].[CD_Facebook_Ads_Publisher_Platform_dss_tracking] SET [create_scope_local_id] = @sync_scope_local_id, [scope_create_peer_key] = @sync_create_peer_key, [scope_create_peer_timestamp] = @sync_create_peer_timestamp, [local_create_peer_key] = 0, [local_create_peer_timestamp] = CAST(@@DBTS AS BIGINT) + 1, [update_scope_local_id] = @sync_scope_local_id, [scope_update_peer_key] = @sync_update_peer_key, [scope_update_peer_timestamp] = @sync_update_peer_timestamp, [local_update_peer_key] = 0, [sync_row_is_tombstone] = @sync_row_is_tombstone WHERE ([campaign_id] = @P_5 AND [ad_id] = @P_9 AND [adset_id] = @P_13 AND [publisher_platform_pp] = @P_19 AND [platform_position_pp] = @P_21 AND [account_id] = @P_31 AND [date_start] = @P_33) AND (@sync_check_concurrency = 0 or [local_update_peer_timestamp] = @sync_row_timestamp); END ELSE BEGIN DECLARE @marker_create_scope_local_id INT
DECLARE @marker_scope_create_peer_timestamp BIGINT
DECLARE @marker_scope_create_peer_key INT
DECLARE @marker_local_create_peer_timestamp BIGINT
DECLARE @marker_local_create_peer_key INT
DECLARE @marker_state INT
SELECT TOP 1 @marker_create_scope_local_id = [provision_scope_local_id], @marker_local_create_peer_timestamp = [provision_timestamp], @marker_local_create_peer_key = [provision_local_peer_key], @marker_scope_create_peer_timestamp = [provision_scope_peer_timestamp], @marker_scope_create_peer_key = [provision_scope_peer_key], @marker_state = [state]
FROM [DataSync].[provision_marker_dss]
WHERE [object_id] = 184908276 
 AND [owner_scope_local_id] = 0

MERGE [DataSync].[CD_Facebook_Ads_Publisher_Platform_dss_tracking] AS [target] 
USING (SELECT [campaign_id], [ad_id], [adset_id], [publisher_platform_pp], [platform_position_pp], [account_id], [date_start]
 FROM [dbo].[CD_Facebook_Ads_Publisher_Platform]
 WHERE [campaign_id] = @P_5 AND [ad_id] = @P_9 AND [adset_id] = @P_13 AND [publisher_platform_pp] = @P_19 AND [platform_position_pp] = @P_21 AND [account_id] = @P_31 AND [date_start] = @P_33
) AS source([campaign_id], [ad_id], [adset_id], [publisher_platform_pp], [platform_position_pp], [account_id], [date_start])
ON ([target].[campaign_id] = [source].[campaign_id] AND [target].[ad_id] = [source].[ad_id] AND [target].[adset_id] = [source].[adset_id] AND [target].[publisher_platform_pp] = [source].[publisher_platform_pp] AND [target].[platform_position_pp] = [source].[platform_position_pp] AND [target].[account_id] = [source].[account_id] AND [target].[date_start] = [source].[date_start])
WHEN NOT MATCHED THEN
INSERT (
[campaign_id], [ad_id], [adset_id], [publisher_platform_pp], [platform_position_pp], [account_id], [date_start] ,
[create_scope_local_id], [scope_create_peer_key], [scope_create_peer_timestamp], [local_create_peer_key], [local_create_peer_timestamp], [update_scope_local_id], [scope_update_peer_key], [scope_update_peer_timestamp], [local_update_peer_key], [sync_row_is_tombstone], [last_change_datetime]) 
VALUES (
[source].[campaign_id], [source].[ad_id], [source].[adset_id], [source].[publisher_platform_pp], [source].[platform_position_pp], [source].[account_id], [source].[date_start],NULL, @marker_scope_create_peer_key, @marker_scope_create_peer_timestamp, 0, @marker_local_create_peer_timestamp , @sync_scope_local_id, @sync_update_peer_key, @sync_update_peer_timestamp, 0, 0, GETDATE() );

SET @sync_row_count = @@ROWCOUNT
IF @sync_row_count = 0 
BEGIN
UPDATE [DataSync].[CD_Facebook_Ads_Publisher_Platform_dss_tracking] SET [update_scope_local_id] = @sync_scope_local_id, [scope_update_peer_key] = @sync_update_peer_key, [scope_update_peer_timestamp] = @sync_update_peer_timestamp, [local_update_peer_key] = 0, [sync_row_is_tombstone] = @sync_row_is_tombstone WHERE ([campaign_id] = @P_5 AND [ad_id] = @P_9 AND [adset_id] = @P_13 AND [publisher_platform_pp] = @P_19 AND [platform_position_pp] = @P_21 AND [account_id] = @P_31 AND [date_start] = @P_33) AND (@sync_check_concurrency = 0 or [local_update_peer_timestamp] = @sync_row_timestamp);SET @sync_row_count = @@ROWCOUNT;
END
 END;
END