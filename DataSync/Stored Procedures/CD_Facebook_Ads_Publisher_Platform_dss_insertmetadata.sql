CREATE PROCEDURE [DataSync].[CD_Facebook_Ads_Publisher_Platform_dss_insertmetadata]
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
SET @sync_row_count = 0; UPDATE [DataSync].[CD_Facebook_Ads_Publisher_Platform_dss_tracking] SET [create_scope_local_id] = @sync_scope_local_id, [scope_create_peer_key] = @sync_create_peer_key, [scope_create_peer_timestamp] = @sync_create_peer_timestamp, [local_create_peer_key] = 0, [local_create_peer_timestamp] = CAST(@@DBTS AS BIGINT) + 1, [update_scope_local_id] = @sync_scope_local_id, [scope_update_peer_key] = @sync_update_peer_key, [scope_update_peer_timestamp] = @sync_update_peer_timestamp, [local_update_peer_key] = 0, [sync_row_is_tombstone] = @sync_row_is_tombstone WHERE ([campaign_id] = @P_5 AND [ad_id] = @P_9 AND [adset_id] = @P_13 AND [publisher_platform_pp] = @P_19 AND [platform_position_pp] = @P_21 AND [account_id] = @P_31 AND [date_start] = @P_33) AND (@sync_check_concurrency = 0 or [local_update_peer_timestamp] = @sync_row_timestamp);SET @sync_row_count = @@ROWCOUNT;IF (@sync_row_count = 0) BEGIN INSERT INTO [DataSync].[CD_Facebook_Ads_Publisher_Platform_dss_tracking] ([campaign_id], [ad_id], [adset_id], [publisher_platform_pp], [platform_position_pp], [account_id], [date_start], [create_scope_local_id], [scope_create_peer_key], [scope_create_peer_timestamp], [local_create_peer_key], [local_create_peer_timestamp], [update_scope_local_id], [scope_update_peer_key], [scope_update_peer_timestamp], [local_update_peer_key], [sync_row_is_tombstone], [last_change_datetime]) VALUES (@P_5, @P_9, @P_13, @P_19, @P_21, @P_31, @P_33, @sync_scope_local_id, @sync_create_peer_key, @sync_create_peer_timestamp, 0, CAST(@@DBTS AS BIGINT) + 1, @sync_scope_local_id, @sync_update_peer_key, @sync_update_peer_timestamp, 0, @sync_row_is_tombstone, GETDATE());SET @sync_row_count = @@ROWCOUNT; END;
END