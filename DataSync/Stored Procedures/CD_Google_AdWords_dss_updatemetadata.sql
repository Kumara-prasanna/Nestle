CREATE PROCEDURE [DataSync].[CD_Google_AdWords_dss_updatemetadata]
	@P_4 BigInt,
	@P_9 NVarChar(200),
	@P_13 BigInt,
	@P_22 Date,
	@P_23 NVarChar(200),
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
SET @sync_row_count = 0; DECLARE @was_tombstone int; SELECT @was_tombstone = [sync_row_is_tombstone] FROM [DataSync].[CD_Google_AdWords_dss_tracking] WHERE ([client_customer_id] = @P_4 AND [network_w_search_partners] = @P_9 AND [campaign_id] = @P_13 AND [day] = @P_22 AND [deviceseg] = @P_23);IF (@was_tombstone IS NOT NULL AND @was_tombstone = 1 AND @sync_row_is_tombstone = 0) BEGIN UPDATE [DataSync].[CD_Google_AdWords_dss_tracking] SET [create_scope_local_id] = @sync_scope_local_id, [scope_create_peer_key] = @sync_create_peer_key, [scope_create_peer_timestamp] = @sync_create_peer_timestamp, [local_create_peer_key] = 0, [local_create_peer_timestamp] = CAST(@@DBTS AS BIGINT) + 1, [update_scope_local_id] = @sync_scope_local_id, [scope_update_peer_key] = @sync_update_peer_key, [scope_update_peer_timestamp] = @sync_update_peer_timestamp, [local_update_peer_key] = 0, [sync_row_is_tombstone] = @sync_row_is_tombstone WHERE ([client_customer_id] = @P_4 AND [network_w_search_partners] = @P_9 AND [campaign_id] = @P_13 AND [day] = @P_22 AND [deviceseg] = @P_23) AND (@sync_check_concurrency = 0 or [local_update_peer_timestamp] = @sync_row_timestamp); END ELSE BEGIN DECLARE @marker_create_scope_local_id INT
DECLARE @marker_scope_create_peer_timestamp BIGINT
DECLARE @marker_scope_create_peer_key INT
DECLARE @marker_local_create_peer_timestamp BIGINT
DECLARE @marker_local_create_peer_key INT
DECLARE @marker_state INT
SELECT TOP 1 @marker_create_scope_local_id = [provision_scope_local_id], @marker_local_create_peer_timestamp = [provision_timestamp], @marker_local_create_peer_key = [provision_local_peer_key], @marker_scope_create_peer_timestamp = [provision_scope_peer_timestamp], @marker_scope_create_peer_key = [provision_scope_peer_key], @marker_state = [state]
FROM [DataSync].[provision_marker_dss]
WHERE [object_id] = 14479676 
 AND [owner_scope_local_id] = 0

MERGE [DataSync].[CD_Google_AdWords_dss_tracking] AS [target] 
USING (SELECT [client_customer_id], [network_w_search_partners], [campaign_id], [day], [deviceseg]
 FROM [dbo].[CD_Google_AdWords]
 WHERE [client_customer_id] = @P_4 AND [network_w_search_partners] = @P_9 AND [campaign_id] = @P_13 AND [day] = @P_22 AND [deviceseg] = @P_23
) AS source([client_customer_id], [network_w_search_partners], [campaign_id], [day], [deviceseg])
ON ([target].[client_customer_id] = [source].[client_customer_id] AND [target].[network_w_search_partners] = [source].[network_w_search_partners] AND [target].[campaign_id] = [source].[campaign_id] AND [target].[day] = [source].[day] AND [target].[deviceseg] = [source].[deviceseg])
WHEN NOT MATCHED THEN
INSERT (
[client_customer_id], [network_w_search_partners], [campaign_id], [day], [deviceseg] ,
[create_scope_local_id], [scope_create_peer_key], [scope_create_peer_timestamp], [local_create_peer_key], [local_create_peer_timestamp], [update_scope_local_id], [scope_update_peer_key], [scope_update_peer_timestamp], [local_update_peer_key], [sync_row_is_tombstone], [last_change_datetime]) 
VALUES (
[source].[client_customer_id], [source].[network_w_search_partners], [source].[campaign_id], [source].[day], [source].[deviceseg],NULL, @marker_scope_create_peer_key, @marker_scope_create_peer_timestamp, 0, @marker_local_create_peer_timestamp , @sync_scope_local_id, @sync_update_peer_key, @sync_update_peer_timestamp, 0, 0, GETDATE() );

SET @sync_row_count = @@ROWCOUNT
IF @sync_row_count = 0 
BEGIN
UPDATE [DataSync].[CD_Google_AdWords_dss_tracking] SET [update_scope_local_id] = @sync_scope_local_id, [scope_update_peer_key] = @sync_update_peer_key, [scope_update_peer_timestamp] = @sync_update_peer_timestamp, [local_update_peer_key] = 0, [sync_row_is_tombstone] = @sync_row_is_tombstone WHERE ([client_customer_id] = @P_4 AND [network_w_search_partners] = @P_9 AND [campaign_id] = @P_13 AND [day] = @P_22 AND [deviceseg] = @P_23) AND (@sync_check_concurrency = 0 or [local_update_peer_timestamp] = @sync_row_timestamp);SET @sync_row_count = @@ROWCOUNT;
END
 END;
END