CREATE PROCEDURE [DataSync].[CD_Facebook_Ads_Reach_Weekly_dss_bulkinsert_86428056-fea2-4062-8e10-5f42d853c559]
	@sync_min_timestamp BigInt,
	@sync_scope_local_id Int,
	@changeTable [DataSync].[CD_Facebook_Ads_Reach_Weekly_dss_BulkType_86428056-fea2-4062-8e10-5f42d853c559] READONLY
AS
BEGIN
-- use a temp table to store the list of PKs that successfully got updated/inserted
DECLARE @changed TABLE ([date_stop] date, [campaign_id] bigint, [account_id] bigint, [date_start] date, PRIMARY KEY ([date_stop], [campaign_id], [account_id], [date_start]));

-- update/insert into the base table
MERGE [dbo].[CD_Facebook_Ads_Reach_Weekly] AS base USING
-- join done here against the side table to get the local timestamp for concurrency check
(SELECT p.*, t.local_update_peer_timestamp FROM @changeTable p LEFT JOIN [DataSync].[CD_Facebook_Ads_Reach_Weekly_dss_tracking] t ON p.[date_stop] = t.[date_stop] AND p.[campaign_id] = t.[campaign_id] AND p.[account_id] = t.[account_id] AND p.[date_start] = t.[date_start]) AS changes ON changes.[date_stop] = base.[date_stop] AND changes.[campaign_id] = base.[campaign_id] AND changes.[account_id] = base.[account_id] AND changes.[date_start] = base.[date_start]
WHEN NOT MATCHED BY TARGET AND changes.local_update_peer_timestamp <= @sync_min_timestamp OR changes.local_update_peer_timestamp IS NULL THEN
INSERT ([dt_created], [dt_updated], [dt_filename], [impressions], [date_stop], [campaign_id], [reach], [inline_link_clicks], [campaign_name], [account_id], [date_start], [account_name], [frequency], [spend], [campaign_stop_time], [campaign_start_time]) VALUES (changes.[dt_created], changes.[dt_updated], changes.[dt_filename], changes.[impressions], changes.[date_stop], changes.[campaign_id], changes.[reach], changes.[inline_link_clicks], changes.[campaign_name], changes.[account_id], changes.[date_start], changes.[account_name], changes.[frequency], changes.[spend], changes.[campaign_stop_time], changes.[campaign_start_time])
OUTPUT INSERTED.[date_stop], INSERTED.[campaign_id], INSERTED.[account_id], INSERTED.[date_start] INTO @changed; -- populates the temp table with successful PKs

UPDATE side SET
update_scope_local_id = @sync_scope_local_id, 
scope_update_peer_key = changes.sync_update_peer_key, 
scope_update_peer_timestamp = changes.sync_update_peer_timestamp,
local_update_peer_key = 0,
create_scope_local_id = @sync_scope_local_id,
scope_create_peer_key = changes.sync_create_peer_key,
scope_create_peer_timestamp = changes.sync_create_peer_timestamp,
local_create_peer_key = 0
FROM 
[DataSync].[CD_Facebook_Ads_Reach_Weekly_dss_tracking] side JOIN 
(SELECT p.[date_stop], p.[campaign_id], p.[account_id], p.[date_start], p.sync_update_peer_timestamp, p.sync_update_peer_key, p.sync_create_peer_key, p.sync_create_peer_timestamp FROM @changed t JOIN @changeTable p ON p.[date_stop] = t.[date_stop] AND p.[campaign_id] = t.[campaign_id] AND p.[account_id] = t.[account_id] AND p.[date_start] = t.[date_start]) AS changes ON changes.[date_stop] = side.[date_stop] AND changes.[campaign_id] = side.[campaign_id] AND changes.[account_id] = side.[account_id] AND changes.[date_start] = side.[date_start]
SELECT [date_stop], [campaign_id], [account_id], [date_start] FROM @changeTable t WHERE NOT EXISTS (SELECT [date_stop], [campaign_id], [account_id], [date_start] from @changed i WHERE t.[date_stop] = i.[date_stop] AND t.[campaign_id] = i.[campaign_id] AND t.[account_id] = i.[account_id] AND t.[date_start] = i.[date_start])
END