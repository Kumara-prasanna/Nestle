CREATE PROCEDURE [DataSync].[CD_Facebook_Ads_Age_Gender_dss_deletemetadata]
	@P_5 BigInt,
	@P_9 BigInt,
	@P_13 BigInt,
	@P_17 NVarChar(200),
	@P_30 BigInt,
	@P_32 Date,
	@P_33 NVarChar(200),
	@sync_check_concurrency Int,
	@sync_row_timestamp BigInt,
	@sync_row_count Int OUTPUT
AS
BEGIN
SET @sync_row_count = 0; DELETE [side] FROM [DataSync].[CD_Facebook_Ads_Age_Gender_dss_tracking] [side] WHERE [campaign_id] = @P_5 AND [ad_id] = @P_9 AND [adset_id] = @P_13 AND [age_ag] = @P_17 AND [account_id] = @P_30 AND [date_start] = @P_32 AND [gender_ag] = @P_33 AND (@sync_check_concurrency = 0 or [local_update_peer_timestamp] = @sync_row_timestamp);SET @sync_row_count = 1 ;

END