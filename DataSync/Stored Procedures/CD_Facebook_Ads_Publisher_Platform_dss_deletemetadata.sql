CREATE PROCEDURE [DataSync].[CD_Facebook_Ads_Publisher_Platform_dss_deletemetadata]
	@P_5 BigInt,
	@P_9 BigInt,
	@P_13 BigInt,
	@P_19 NVarChar(200),
	@P_21 NVarChar(200),
	@P_31 BigInt,
	@P_33 Date,
	@sync_check_concurrency Int,
	@sync_row_timestamp BigInt,
	@sync_row_count Int OUTPUT
AS
BEGIN
SET @sync_row_count = 0; DELETE [side] FROM [DataSync].[CD_Facebook_Ads_Publisher_Platform_dss_tracking] [side] WHERE [campaign_id] = @P_5 AND [ad_id] = @P_9 AND [adset_id] = @P_13 AND [publisher_platform_pp] = @P_19 AND [platform_position_pp] = @P_21 AND [account_id] = @P_31 AND [date_start] = @P_33 AND (@sync_check_concurrency = 0 or [local_update_peer_timestamp] = @sync_row_timestamp);SET @sync_row_count = 1 ;

END