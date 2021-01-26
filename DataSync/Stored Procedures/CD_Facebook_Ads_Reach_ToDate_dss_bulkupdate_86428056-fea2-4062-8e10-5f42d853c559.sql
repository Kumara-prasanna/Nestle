﻿CREATE PROCEDURE [DataSync].[CD_Facebook_Ads_Reach_ToDate_dss_bulkupdate_86428056-fea2-4062-8e10-5f42d853c559]
	@sync_min_timestamp BigInt,
	@sync_scope_local_id Int,
	@changeTable [DataSync].[CD_Facebook_Ads_Reach_ToDate_dss_BulkType_86428056-fea2-4062-8e10-5f42d853c559] READONLY
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
-- use a temp table to store the list of PKs that successfully got updated
declare @changed TABLE ([campaign_id] bigint, [account_id] bigint, PRIMARY KEY ([campaign_id], [account_id]));

-- update the base table
MERGE [dbo].[CD_Facebook_Ads_Reach_ToDate] AS base USING
-- join done here against the side table to get the local timestamp for concurrency check
(SELECT p.*, t.update_scope_local_id, t.scope_update_peer_key, t.local_update_peer_timestamp FROM @changeTable p LEFT JOIN [DataSync].[CD_Facebook_Ads_Reach_ToDate_dss_tracking] t ON p.[campaign_id] = t.[campaign_id] AND p.[account_id] = t.[account_id]) as changes ON changes.[campaign_id] = base.[campaign_id] AND changes.[account_id] = base.[account_id]
WHEN MATCHED AND (changes.update_scope_local_id = @sync_scope_local_id AND changes.scope_update_peer_key = changes.sync_update_peer_key) OR changes.local_update_peer_timestamp <= @sync_min_timestamp-- No tracking record exists
OR (changes.update_scope_local_id IS NULL AND changes.scope_update_peer_key IS NULL AND changes.local_update_peer_timestamp IS NULL) 
 THEN
UPDATE SET [dt_created] = changes.[dt_created], [dt_updated] = changes.[dt_updated], [dt_filename] = changes.[dt_filename], [impressions] = changes.[impressions], [reach] = changes.[reach], [inline_link_clicks] = changes.[inline_link_clicks], [campaign_name] = changes.[campaign_name], [date_start] = changes.[date_start], [account_name] = changes.[account_name], [frequency] = changes.[frequency], [spend] = changes.[spend], [campaign_stop_time] = changes.[campaign_stop_time], [campaign_start_time] = changes.[campaign_start_time]
OUTPUT INSERTED.[campaign_id], INSERTED.[account_id] into @changed; -- populates the temp table with successful PKs

UPDATE side SET
update_scope_local_id = @sync_scope_local_id, 
scope_update_peer_key = changes.sync_update_peer_key, 
scope_update_peer_timestamp = changes.sync_update_peer_timestamp,
local_update_peer_key = 0
FROM 
[DataSync].[CD_Facebook_Ads_Reach_ToDate_dss_tracking] side JOIN 
(SELECT p.[campaign_id], p.[account_id], p.sync_update_peer_timestamp, p.sync_update_peer_key, p.sync_create_peer_key, p.sync_create_peer_timestamp FROM @changed t JOIN @changeTable p ON p.[campaign_id] = t.[campaign_id] AND p.[account_id] = t.[account_id]) as changes ON changes.[campaign_id] = side.[campaign_id] AND changes.[account_id] = side.[account_id]
SELECT [campaign_id], [account_id] FROM @changeTable t WHERE NOT EXISTS (SELECT [campaign_id], [account_id] from @changed i WHERE t.[campaign_id] = i.[campaign_id] AND t.[account_id] = i.[account_id])
END