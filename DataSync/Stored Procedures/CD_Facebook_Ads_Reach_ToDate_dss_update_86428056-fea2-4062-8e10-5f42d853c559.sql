CREATE PROCEDURE [DataSync].[CD_Facebook_Ads_Reach_ToDate_dss_update_86428056-fea2-4062-8e10-5f42d853c559]
	@P_1 DateTime,
	@P_2 DateTime,
	@P_3 NVarChar(255),
	@P_4 BigInt,
	@P_5 BigInt,
	@P_6 BigInt,
	@P_7 BigInt,
	@P_8 NVarChar(max),
	@P_9 BigInt,
	@P_10 Date,
	@P_11 NVarChar(max),
	@P_12 Decimal(20,4),
	@P_13 Decimal(20,4),
	@P_14 DateTime,
	@P_15 DateTime,
	@sync_force_write Int,
	@sync_min_timestamp BigInt,
	@sync_row_count Int OUTPUT
AS
BEGIN
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

DECLARE @marker_update_scope_local_id INT
DECLARE @marker_scope_update_peer_timestamp BIGINT
DECLARE @marker_scope_update_peer_key INT
DECLARE @marker_local_update_peer_timestamp BIGINT
DECLARE @marker_local_update_peer_key INT
SELECT TOP 1 @marker_update_scope_local_id = [provision_scope_local_id], @marker_local_update_peer_timestamp = [provision_timestamp], @marker_local_update_peer_key = [provision_local_peer_key], @marker_scope_update_peer_timestamp = [provision_scope_peer_timestamp], @marker_scope_update_peer_key = [provision_scope_peer_key]
FROM [DataSync].[provision_marker_dss]
WHERE [object_id] = 312908732 
 AND [owner_scope_local_id] = 1
SET @sync_row_count = 0; UPDATE [dbo].[CD_Facebook_Ads_Reach_ToDate] SET [dt_created] = @P_1, [dt_updated] = @P_2, [dt_filename] = @P_3, [impressions] = @P_4, [reach] = @P_6, [inline_link_clicks] = @P_7, [campaign_name] = @P_8, [date_start] = @P_10, [account_name] = @P_11, [frequency] = @P_12, [spend] = @P_13, [campaign_stop_time] = @P_14, [campaign_start_time] = @P_15 FROM [dbo].[CD_Facebook_Ads_Reach_ToDate] [base] LEFT JOIN [DataSync].[CD_Facebook_Ads_Reach_ToDate_dss_tracking] [side] ON [base].[campaign_id] = [side].[campaign_id] AND [base].[account_id] = [side].[account_id] WHERE ((CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL AND [side].[local_update_peer_timestamp] > @marker_local_update_peer_timestamp 
THEN [side].[local_update_peer_timestamp]
ELSE @marker_local_update_peer_timestamp
 END)  <= @sync_min_timestamp OR @sync_force_write = 1) AND ([base].[campaign_id] = @P_5 AND [base].[account_id] = @P_9); SET @sync_row_count = @@ROWCOUNT;
END