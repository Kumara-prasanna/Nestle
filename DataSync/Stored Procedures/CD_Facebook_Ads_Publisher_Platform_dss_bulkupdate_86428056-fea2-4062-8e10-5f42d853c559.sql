CREATE PROCEDURE [DataSync].[CD_Facebook_Ads_Publisher_Platform_dss_bulkupdate_86428056-fea2-4062-8e10-5f42d853c559]
	@sync_min_timestamp BigInt,
	@sync_scope_local_id Int,
	@changeTable [DataSync].[CD_Facebook_Ads_Publisher_Platform_dss_BulkType_86428056-fea2-4062-8e10-5f42d853c559] READONLY
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
-- use a temp table to store the list of PKs that successfully got updated
declare @changed TABLE ([campaign_id] bigint, [ad_id] bigint, [adset_id] bigint, [publisher_platform_pp] nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS, [platform_position_pp] nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS, [account_id] bigint, [date_start] date, PRIMARY KEY ([campaign_id], [ad_id], [adset_id], [publisher_platform_pp], [platform_position_pp], [account_id], [date_start]));

-- update the base table
MERGE [dbo].[CD_Facebook_Ads_Publisher_Platform] AS base USING
-- join done here against the side table to get the local timestamp for concurrency check
(SELECT p.*, t.update_scope_local_id, t.scope_update_peer_key, t.local_update_peer_timestamp FROM @changeTable p LEFT JOIN [DataSync].[CD_Facebook_Ads_Publisher_Platform_dss_tracking] t ON p.[campaign_id] = t.[campaign_id] AND p.[ad_id] = t.[ad_id] AND p.[adset_id] = t.[adset_id] AND p.[publisher_platform_pp] = t.[publisher_platform_pp] AND p.[platform_position_pp] = t.[platform_position_pp] AND p.[account_id] = t.[account_id] AND p.[date_start] = t.[date_start]) as changes ON changes.[campaign_id] = base.[campaign_id] AND changes.[ad_id] = base.[ad_id] AND changes.[adset_id] = base.[adset_id] AND changes.[publisher_platform_pp] = base.[publisher_platform_pp] AND changes.[platform_position_pp] = base.[platform_position_pp] AND changes.[account_id] = base.[account_id] AND changes.[date_start] = base.[date_start]
WHEN MATCHED AND (changes.update_scope_local_id = @sync_scope_local_id AND changes.scope_update_peer_key = changes.sync_update_peer_key) OR changes.local_update_peer_timestamp <= @sync_min_timestamp-- No tracking record exists
OR (changes.update_scope_local_id IS NULL AND changes.scope_update_peer_key IS NULL AND changes.local_update_peer_timestamp IS NULL) 
 THEN
UPDATE SET [dt_created] = changes.[dt_created], [dt_updated] = changes.[dt_updated], [dt_filename] = changes.[dt_filename], [date_stop] = changes.[date_stop], [video_p25_watched_actionsvideo_view] = changes.[video_p25_watched_actionsvideo_view], [actionslink_click] = changes.[actionslink_click], [cpm] = changes.[cpm], [actionspost_reaction] = changes.[actionspost_reaction], [ad_name] = changes.[ad_name], [video_p50_watched_actionsvideo_view] = changes.[video_p50_watched_actionsvideo_view], [spend] = changes.[spend], [actionsvideo_view] = changes.[actionsvideo_view], [cpc] = changes.[cpc], [impressions] = changes.[impressions], [ctr] = changes.[ctr], [adset_name] = changes.[adset_name], [video_p75_watched_actionsvideo_view] = changes.[video_p75_watched_actionsvideo_view], [video_p100_watched_actionsvideo_view] = changes.[video_p100_watched_actionsvideo_view], [actionspost_engagement] = changes.[actionspost_engagement], [video_play_actionsvideo_view] = changes.[video_play_actionsvideo_view], [campaign_name] = changes.[campaign_name], [actionscomment] = changes.[actionscomment], [actionspage_engagement] = changes.[actionspage_engagement], [objective] = changes.[objective], [actionsonsite_conversionpost_save] = changes.[actionsonsite_conversionpost_save], [clicks] = changes.[clicks], [account_name] = changes.[account_name], [actionspost] = changes.[actionspost], [campaign_stop_time] = changes.[campaign_stop_time], [ad_creative_image_url] = changes.[ad_creative_image_url], [ad_creative_title] = changes.[ad_creative_title], [ad_creative_thumbnail_url] = changes.[ad_creative_thumbnail_url], [ad_creative_body] = changes.[ad_creative_body], [campaign_start_time] = changes.[campaign_start_time], [conversions] = changes.[conversions], [video_p100_watched_actions] = changes.[video_p100_watched_actions], [video_p25_watched_actions] = changes.[video_p25_watched_actions], [video_p50_watched_actions] = changes.[video_p50_watched_actions], [video_p75_watched_actions] = changes.[video_p75_watched_actions], [video_play_actions] = changes.[video_play_actions], [website_purchase_roas] = changes.[website_purchase_roas], [actionslike] = changes.[actionslike], [actionslanding_page_view] = changes.[actionslanding_page_view], [actionsinteractive_component_tap] = changes.[actionsinteractive_component_tap], [actionsphoto_view] = changes.[actionsphoto_view], [actionsoffsite_conversionfb_pixel_add_to_cart] = changes.[actionsoffsite_conversionfb_pixel_add_to_cart], [actionsadd_to_cart] = changes.[actionsadd_to_cart], [actionspurchase] = changes.[actionspurchase], [actionsomni_add_to_cart] = changes.[actionsomni_add_to_cart], [action_valuesoffsite_conversionfb_pixel_purchase] = changes.[action_valuesoffsite_conversionfb_pixel_purchase], [website_purchase_roasoffsite_conversionfb_pixel_purchase] = changes.[website_purchase_roasoffsite_conversionfb_pixel_purchase], [actionsomni_purchase] = changes.[actionsomni_purchase], [actionsoffsite_conversionfb_pixel_purchase] = changes.[actionsoffsite_conversionfb_pixel_purchase], [action_valuesomni_purchase] = changes.[action_valuesomni_purchase], [actionsinitiate_checkout] = changes.[actionsinitiate_checkout], [actionsomni_initiated_checkout] = changes.[actionsomni_initiated_checkout], [actionsoffsite_conversionfb_pixel_initiate_checkout] = changes.[actionsoffsite_conversionfb_pixel_initiate_checkout], [actionsoffsite_conversionfb_pixel_complete_registration] = changes.[actionsoffsite_conversionfb_pixel_complete_registration], [actionsomni_complete_registration] = changes.[actionsomni_complete_registration], [actionscomplete_registration] = changes.[actionscomplete_registration]
OUTPUT INSERTED.[campaign_id], INSERTED.[ad_id], INSERTED.[adset_id], INSERTED.[publisher_platform_pp], INSERTED.[platform_position_pp], INSERTED.[account_id], INSERTED.[date_start] into @changed; -- populates the temp table with successful PKs

UPDATE side SET
update_scope_local_id = @sync_scope_local_id, 
scope_update_peer_key = changes.sync_update_peer_key, 
scope_update_peer_timestamp = changes.sync_update_peer_timestamp,
local_update_peer_key = 0
FROM 
[DataSync].[CD_Facebook_Ads_Publisher_Platform_dss_tracking] side JOIN 
(SELECT p.[campaign_id], p.[ad_id], p.[adset_id], p.[publisher_platform_pp], p.[platform_position_pp], p.[account_id], p.[date_start], p.sync_update_peer_timestamp, p.sync_update_peer_key, p.sync_create_peer_key, p.sync_create_peer_timestamp FROM @changed t JOIN @changeTable p ON p.[campaign_id] = t.[campaign_id] AND p.[ad_id] = t.[ad_id] AND p.[adset_id] = t.[adset_id] AND p.[publisher_platform_pp] = t.[publisher_platform_pp] AND p.[platform_position_pp] = t.[platform_position_pp] AND p.[account_id] = t.[account_id] AND p.[date_start] = t.[date_start]) as changes ON changes.[campaign_id] = side.[campaign_id] AND changes.[ad_id] = side.[ad_id] AND changes.[adset_id] = side.[adset_id] AND changes.[publisher_platform_pp] = side.[publisher_platform_pp] AND changes.[platform_position_pp] = side.[platform_position_pp] AND changes.[account_id] = side.[account_id] AND changes.[date_start] = side.[date_start]
SELECT [campaign_id], [ad_id], [adset_id], [publisher_platform_pp], [platform_position_pp], [account_id], [date_start] FROM @changeTable t WHERE NOT EXISTS (SELECT [campaign_id], [ad_id], [adset_id], [publisher_platform_pp], [platform_position_pp], [account_id], [date_start] from @changed i WHERE t.[campaign_id] = i.[campaign_id] AND t.[ad_id] = i.[ad_id] AND t.[adset_id] = i.[adset_id] AND t.[publisher_platform_pp] = i.[publisher_platform_pp] AND t.[platform_position_pp] = i.[platform_position_pp] AND t.[account_id] = i.[account_id] AND t.[date_start] = i.[date_start])
END