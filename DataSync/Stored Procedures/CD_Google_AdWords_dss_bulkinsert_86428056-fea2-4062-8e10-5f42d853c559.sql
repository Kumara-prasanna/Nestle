CREATE PROCEDURE [DataSync].[CD_Google_AdWords_dss_bulkinsert_86428056-fea2-4062-8e10-5f42d853c559]
	@sync_min_timestamp BigInt,
	@sync_scope_local_id Int,
	@changeTable [DataSync].[CD_Google_AdWords_dss_BulkType_86428056-fea2-4062-8e10-5f42d853c559] READONLY
AS
BEGIN
-- use a temp table to store the list of PKs that successfully got updated/inserted
DECLARE @changed TABLE ([client_customer_id] bigint, [network_w_search_partners] nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS, [campaign_id] bigint, [day] date, [deviceseg] nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS, PRIMARY KEY ([client_customer_id], [network_w_search_partners], [campaign_id], [day], [deviceseg]));

-- update/insert into the base table
MERGE [dbo].[CD_Google_AdWords] AS base USING
-- join done here against the side table to get the local timestamp for concurrency check
(SELECT p.*, t.local_update_peer_timestamp FROM @changeTable p LEFT JOIN [DataSync].[CD_Google_AdWords_dss_tracking] t ON p.[client_customer_id] = t.[client_customer_id] AND p.[network_w_search_partners] = t.[network_w_search_partners] AND p.[campaign_id] = t.[campaign_id] AND p.[day] = t.[day] AND p.[deviceseg] = t.[deviceseg]) AS changes ON changes.[client_customer_id] = base.[client_customer_id] AND changes.[network_w_search_partners] = base.[network_w_search_partners] AND changes.[campaign_id] = base.[campaign_id] AND changes.[day] = base.[day] AND changes.[deviceseg] = base.[deviceseg]
WHEN NOT MATCHED BY TARGET AND changes.local_update_peer_timestamp <= @sync_min_timestamp OR changes.local_update_peer_timestamp IS NULL THEN
INSERT ([dt_created], [dt_updated], [dt_filename], [client_customer_id], [client_customer_name], [currency], [account], [network], [network_w_search_partners], [all_conv], [all_conv_value], [budget], [campaign_id], [campaign], [clicks], [conv_rate], [conversions], [total_conv_value], [cost], [crossdevice_conv], [client_name], [day], [deviceseg], [end_date], [engagement_rate], [engagements], [customer_id], [impressions], [interactions], [invalid_clicks], [labels], [search_impr_share], [start_date], [video_played_to_100], [video_played_to_25], [video_played_to_50], [video_played_to_75], [view_rate], [views], [viewthrough_conv]) VALUES (changes.[dt_created], changes.[dt_updated], changes.[dt_filename], changes.[client_customer_id], changes.[client_customer_name], changes.[currency], changes.[account], changes.[network], changes.[network_w_search_partners], changes.[all_conv], changes.[all_conv_value], changes.[budget], changes.[campaign_id], changes.[campaign], changes.[clicks], changes.[conv_rate], changes.[conversions], changes.[total_conv_value], changes.[cost], changes.[crossdevice_conv], changes.[client_name], changes.[day], changes.[deviceseg], changes.[end_date], changes.[engagement_rate], changes.[engagements], changes.[customer_id], changes.[impressions], changes.[interactions], changes.[invalid_clicks], changes.[labels], changes.[search_impr_share], changes.[start_date], changes.[video_played_to_100], changes.[video_played_to_25], changes.[video_played_to_50], changes.[video_played_to_75], changes.[view_rate], changes.[views], changes.[viewthrough_conv])
OUTPUT INSERTED.[client_customer_id], INSERTED.[network_w_search_partners], INSERTED.[campaign_id], INSERTED.[day], INSERTED.[deviceseg] INTO @changed; -- populates the temp table with successful PKs

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
[DataSync].[CD_Google_AdWords_dss_tracking] side JOIN 
(SELECT p.[client_customer_id], p.[network_w_search_partners], p.[campaign_id], p.[day], p.[deviceseg], p.sync_update_peer_timestamp, p.sync_update_peer_key, p.sync_create_peer_key, p.sync_create_peer_timestamp FROM @changed t JOIN @changeTable p ON p.[client_customer_id] = t.[client_customer_id] AND p.[network_w_search_partners] = t.[network_w_search_partners] AND p.[campaign_id] = t.[campaign_id] AND p.[day] = t.[day] AND p.[deviceseg] = t.[deviceseg]) AS changes ON changes.[client_customer_id] = side.[client_customer_id] AND changes.[network_w_search_partners] = side.[network_w_search_partners] AND changes.[campaign_id] = side.[campaign_id] AND changes.[day] = side.[day] AND changes.[deviceseg] = side.[deviceseg]
SELECT [client_customer_id], [network_w_search_partners], [campaign_id], [day], [deviceseg] FROM @changeTable t WHERE NOT EXISTS (SELECT [client_customer_id], [network_w_search_partners], [campaign_id], [day], [deviceseg] from @changed i WHERE t.[client_customer_id] = i.[client_customer_id] AND t.[network_w_search_partners] = i.[network_w_search_partners] AND t.[campaign_id] = i.[campaign_id] AND t.[day] = i.[day] AND t.[deviceseg] = i.[deviceseg])
END