CREATE PROCEDURE [DataSync].[CD_Facebook_Ads_Reach_Weekly_dss_deletemetadata]
	@P_5 Date,
	@P_6 BigInt,
	@P_10 BigInt,
	@P_11 Date,
	@sync_check_concurrency Int,
	@sync_row_timestamp BigInt,
	@sync_row_count Int OUTPUT
AS
BEGIN
SET @sync_row_count = 0; DELETE [side] FROM [DataSync].[CD_Facebook_Ads_Reach_Weekly_dss_tracking] [side] WHERE [date_stop] = @P_5 AND [campaign_id] = @P_6 AND [account_id] = @P_10 AND [date_start] = @P_11 AND (@sync_check_concurrency = 0 or [local_update_peer_timestamp] = @sync_row_timestamp);SET @sync_row_count = 1 ;

END