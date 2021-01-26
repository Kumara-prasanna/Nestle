CREATE PROCEDURE [DataSync].[CD_Google_AdWords_dss_bulkdelete_86428056-fea2-4062-8e10-5f42d853c559]
	@sync_min_timestamp BigInt,
	@sync_scope_local_id Int,
	@changeTable [DataSync].[CD_Google_AdWords_dss_BulkType_86428056-fea2-4062-8e10-5f42d853c559] READONLY
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
-- use a temp table to store the list of PKs that successfully got updated/inserted
declare @changed TABLE ([client_customer_id] bigint, [network_w_search_partners] nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS, [campaign_id] bigint, [day] date, [deviceseg] nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS, PRIMARY KEY ([client_customer_id], [network_w_search_partners], [campaign_id], [day], [deviceseg]));
DELETE [dbo].[CD_Google_AdWords] 
OUTPUT DELETED.[client_customer_id], DELETED.[network_w_search_partners], DELETED.[campaign_id], DELETED.[day], DELETED.[deviceseg] INTO @changed FROM [dbo].[CD_Google_AdWords] base JOIN
(SELECT p.*, t.update_scope_local_id, t.scope_update_peer_key, t.local_update_peer_timestamp FROM @changeTable p  LEFT JOIN [DataSync].[CD_Google_AdWords_dss_tracking] t ON p.[client_customer_id] = t.[client_customer_id] AND p.[network_w_search_partners] = t.[network_w_search_partners] AND p.[campaign_id] = t.[campaign_id] AND p.[day] = t.[day] AND p.[deviceseg] = t.[deviceseg]) as changes ON changes.[client_customer_id] = base.[client_customer_id] AND changes.[network_w_search_partners] = base.[network_w_search_partners] AND changes.[campaign_id] = base.[campaign_id] AND changes.[day] = base.[day] AND changes.[deviceseg] = base.[deviceseg] WHERE (changes.update_scope_local_id = @sync_scope_local_id AND changes.scope_update_peer_key = changes.sync_update_peer_key) OR changes.local_update_peer_timestamp <= @sync_min_timestamp

 -- No tracking record exists
OR (changes.update_scope_local_id IS NULL AND changes.scope_update_peer_key IS NULL AND changes.local_update_peer_timestamp IS NULL)
UPDATE side SET
sync_row_is_tombstone = 1, 
update_scope_local_id = @sync_scope_local_id, 
scope_update_peer_key = changes.sync_update_peer_key, 
scope_update_peer_timestamp = changes.sync_update_peer_timestamp,
local_update_peer_key = 0
FROM 
[DataSync].[CD_Google_AdWords_dss_tracking] side JOIN 
(SELECT p.[client_customer_id], p.[network_w_search_partners], p.[campaign_id], p.[day], p.[deviceseg], p.sync_update_peer_timestamp, p.sync_update_peer_key, p.sync_create_peer_key, p.sync_create_peer_timestamp FROM @changed t JOIN @changeTable p ON p.[client_customer_id] = t.[client_customer_id] AND p.[network_w_search_partners] = t.[network_w_search_partners] AND p.[campaign_id] = t.[campaign_id] AND p.[day] = t.[day] AND p.[deviceseg] = t.[deviceseg]) AS changes ON changes.[client_customer_id] = side.[client_customer_id] AND changes.[network_w_search_partners] = side.[network_w_search_partners] AND changes.[campaign_id] = side.[campaign_id] AND changes.[day] = side.[day] AND changes.[deviceseg] = side.[deviceseg]
SELECT [client_customer_id], [network_w_search_partners], [campaign_id], [day], [deviceseg] FROM @changeTable t WHERE NOT EXISTS (SELECT [client_customer_id], [network_w_search_partners], [campaign_id], [day], [deviceseg] from @changed i WHERE t.[client_customer_id] = i.[client_customer_id] AND t.[network_w_search_partners] = i.[network_w_search_partners] AND t.[campaign_id] = i.[campaign_id] AND t.[day] = i.[day] AND t.[deviceseg] = i.[deviceseg])
END