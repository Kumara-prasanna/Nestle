CREATE PROCEDURE [DataSync].[CD_Google_AdWords_dss_delete_86428056-fea2-4062-8e10-5f42d853c559]
	@P_4 BigInt,
	@P_9 NVarChar(200),
	@P_13 BigInt,
	@P_22 Date,
	@P_23 NVarChar(200),
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
WHERE [object_id] = 14479676 
 AND [owner_scope_local_id] = 0

DECLARE @marker_update_scope_local_id INT
DECLARE @marker_scope_update_peer_timestamp BIGINT
DECLARE @marker_scope_update_peer_key INT
DECLARE @marker_local_update_peer_timestamp BIGINT
DECLARE @marker_local_update_peer_key INT
SELECT TOP 1 @marker_update_scope_local_id = [provision_scope_local_id], @marker_local_update_peer_timestamp = [provision_timestamp], @marker_local_update_peer_key = [provision_local_peer_key], @marker_scope_update_peer_timestamp = [provision_scope_peer_timestamp], @marker_scope_update_peer_key = [provision_scope_peer_key]
FROM [DataSync].[provision_marker_dss]
WHERE [object_id] = 14479676 
 AND [owner_scope_local_id] = 1
SET @sync_row_count = 0; DELETE [dbo].[CD_Google_AdWords] FROM [dbo].[CD_Google_AdWords] [base] LEFT JOIN [DataSync].[CD_Google_AdWords_dss_tracking] [side] ON [base].[client_customer_id] = [side].[client_customer_id] AND [base].[network_w_search_partners] = [side].[network_w_search_partners] AND [base].[campaign_id] = [side].[campaign_id] AND [base].[day] = [side].[day] AND [base].[deviceseg] = [side].[deviceseg] WHERE ((CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL AND [side].[local_update_peer_timestamp] > @marker_local_update_peer_timestamp 
THEN [side].[local_update_peer_timestamp]
ELSE @marker_local_update_peer_timestamp
 END)  <= @sync_min_timestamp OR @sync_force_write = 1) AND ([base].[client_customer_id] = @P_4 AND [base].[network_w_search_partners] = @P_9 AND [base].[campaign_id] = @P_13 AND [base].[day] = @P_22 AND [base].[deviceseg] = @P_23); SET @sync_row_count = @@ROWCOUNT;
END