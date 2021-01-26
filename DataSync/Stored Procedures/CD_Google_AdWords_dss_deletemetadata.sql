CREATE PROCEDURE [DataSync].[CD_Google_AdWords_dss_deletemetadata]
	@P_4 BigInt,
	@P_9 NVarChar(200),
	@P_13 BigInt,
	@P_22 Date,
	@P_23 NVarChar(200),
	@sync_check_concurrency Int,
	@sync_row_timestamp BigInt,
	@sync_row_count Int OUTPUT
AS
BEGIN
SET @sync_row_count = 0; DELETE [side] FROM [DataSync].[CD_Google_AdWords_dss_tracking] [side] WHERE [client_customer_id] = @P_4 AND [network_w_search_partners] = @P_9 AND [campaign_id] = @P_13 AND [day] = @P_22 AND [deviceseg] = @P_23 AND (@sync_check_concurrency = 0 or [local_update_peer_timestamp] = @sync_row_timestamp);SET @sync_row_count = 1 ;

END