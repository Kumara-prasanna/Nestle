CREATE PROCEDURE [DataSync].[CD_Facebook_Ads_Reach_ToDate_dss_deletemetadata]
	@P_5 BigInt,
	@P_9 BigInt,
	@sync_check_concurrency Int,
	@sync_row_timestamp BigInt,
	@sync_row_count Int OUTPUT
AS
BEGIN
SET @sync_row_count = 0; DELETE [side] FROM [DataSync].[CD_Facebook_Ads_Reach_ToDate_dss_tracking] [side] WHERE [campaign_id] = @P_5 AND [account_id] = @P_9 AND (@sync_check_concurrency = 0 or [local_update_peer_timestamp] = @sync_row_timestamp);SET @sync_row_count = 1 ;

END