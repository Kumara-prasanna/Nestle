CREATE PROCEDURE [DataSync].[CD_Facebook_Ads_Publisher_Platform_dss_delete_86428056-fea2-4062-8e10-5f42d853c559]
	@P_5 BigInt,
	@P_9 BigInt,
	@P_13 BigInt,
	@P_19 NVarChar(200),
	@P_21 NVarChar(200),
	@P_31 BigInt,
	@P_33 Date,
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
WHERE [object_id] = 184908276 
 AND [owner_scope_local_id] = 0

DECLARE @marker_update_scope_local_id INT
DECLARE @marker_scope_update_peer_timestamp BIGINT
DECLARE @marker_scope_update_peer_key INT
DECLARE @marker_local_update_peer_timestamp BIGINT
DECLARE @marker_local_update_peer_key INT
SELECT TOP 1 @marker_update_scope_local_id = [provision_scope_local_id], @marker_local_update_peer_timestamp = [provision_timestamp], @marker_local_update_peer_key = [provision_local_peer_key], @marker_scope_update_peer_timestamp = [provision_scope_peer_timestamp], @marker_scope_update_peer_key = [provision_scope_peer_key]
FROM [DataSync].[provision_marker_dss]
WHERE [object_id] = 184908276 
 AND [owner_scope_local_id] = 1
SET @sync_row_count = 0; DELETE [dbo].[CD_Facebook_Ads_Publisher_Platform] FROM [dbo].[CD_Facebook_Ads_Publisher_Platform] [base] LEFT JOIN [DataSync].[CD_Facebook_Ads_Publisher_Platform_dss_tracking] [side] ON [base].[campaign_id] = [side].[campaign_id] AND [base].[ad_id] = [side].[ad_id] AND [base].[adset_id] = [side].[adset_id] AND [base].[publisher_platform_pp] = [side].[publisher_platform_pp] AND [base].[platform_position_pp] = [side].[platform_position_pp] AND [base].[account_id] = [side].[account_id] AND [base].[date_start] = [side].[date_start] WHERE ((CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL AND [side].[local_update_peer_timestamp] > @marker_local_update_peer_timestamp 
THEN [side].[local_update_peer_timestamp]
ELSE @marker_local_update_peer_timestamp
 END)  <= @sync_min_timestamp OR @sync_force_write = 1) AND ([base].[campaign_id] = @P_5 AND [base].[ad_id] = @P_9 AND [base].[adset_id] = @P_13 AND [base].[publisher_platform_pp] = @P_19 AND [base].[platform_position_pp] = @P_21 AND [base].[account_id] = @P_31 AND [base].[date_start] = @P_33); SET @sync_row_count = @@ROWCOUNT;
END