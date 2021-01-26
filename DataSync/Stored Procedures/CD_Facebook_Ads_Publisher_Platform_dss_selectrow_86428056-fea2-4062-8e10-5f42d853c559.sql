CREATE PROCEDURE [DataSync].[CD_Facebook_Ads_Publisher_Platform_dss_selectrow_86428056-fea2-4062-8e10-5f42d853c559]
	@P_5 BigInt,
	@P_9 BigInt,
	@P_13 BigInt,
	@P_19 NVarChar(200),
	@P_21 NVarChar(200),
	@P_31 BigInt,
	@P_33 Date,
	@sync_scope_local_id Int,
	@sync_scope_restore_count Int
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
SELECT (CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL 
THEN [side].[campaign_id]
ELSE [base].[campaign_id] END) 
as [campaign_id], 
(CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL 
THEN [side].[ad_id]
ELSE [base].[ad_id] END) 
as [ad_id], 
(CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL 
THEN [side].[adset_id]
ELSE [base].[adset_id] END) 
as [adset_id], 
(CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL 
THEN [side].[publisher_platform_pp]
ELSE [base].[publisher_platform_pp] END) 
as [publisher_platform_pp], 
(CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL 
THEN [side].[platform_position_pp]
ELSE [base].[platform_position_pp] END) 
as [platform_position_pp], 
(CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL 
THEN [side].[account_id]
ELSE [base].[account_id] END) 
as [account_id], 
(CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL 
THEN [side].[date_start]
ELSE [base].[date_start] END) 
as [date_start], 
[base].[dt_created], [base].[dt_updated], [base].[dt_filename], [base].[date_stop], [base].[video_p25_watched_actionsvideo_view], [base].[actionslink_click], [base].[cpm], [base].[actionspost_reaction], [base].[ad_name], [base].[video_p50_watched_actionsvideo_view], [base].[spend], [base].[actionsvideo_view], [base].[cpc], [base].[impressions], [base].[ctr], [base].[adset_name], [base].[video_p75_watched_actionsvideo_view], [base].[video_p100_watched_actionsvideo_view], [base].[actionspost_engagement], [base].[video_play_actionsvideo_view], [base].[campaign_name], [base].[actionscomment], [base].[actionspage_engagement], [base].[objective], [base].[actionsonsite_conversionpost_save], [base].[clicks], [base].[account_name], [base].[actionspost], [base].[campaign_stop_time], [base].[ad_creative_image_url], [base].[ad_creative_title], [base].[ad_creative_thumbnail_url], [base].[ad_creative_body], [base].[campaign_start_time], [base].[conversions], [base].[video_p100_watched_actions], [base].[video_p25_watched_actions], [base].[video_p50_watched_actions], [base].[video_p75_watched_actions], [base].[video_play_actions], [base].[website_purchase_roas], [base].[actionslike], [base].[actionslanding_page_view], [base].[actionsinteractive_component_tap], [base].[actionsphoto_view], [base].[actionsoffsite_conversionfb_pixel_add_to_cart], [base].[actionsadd_to_cart], [base].[actionspurchase], [base].[actionsomni_add_to_cart], [base].[action_valuesoffsite_conversionfb_pixel_purchase], [base].[website_purchase_roasoffsite_conversionfb_pixel_purchase], [base].[actionsomni_purchase], [base].[actionsoffsite_conversionfb_pixel_purchase], [base].[action_valuesomni_purchase], [base].[actionsinitiate_checkout], [base].[actionsomni_initiated_checkout], [base].[actionsoffsite_conversionfb_pixel_initiate_checkout], [base].[actionsoffsite_conversionfb_pixel_complete_registration], [base].[actionsomni_complete_registration], [base].[actionscomplete_registration], (CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL 
THEN [side].[sync_row_is_tombstone]
ELSE 0
 END) 
 as sync_row_is_tombstone, (CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL AND [side].[local_update_peer_timestamp] > @marker_local_update_peer_timestamp 
THEN [side].[local_update_peer_timestamp]
ELSE @marker_local_update_peer_timestamp
 END)  as sync_row_timestamp, case when ((CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL AND [side].[local_update_peer_timestamp] > @marker_local_update_peer_timestamp 
THEN [side].[update_scope_local_id]
ELSE @marker_update_scope_local_id
 END)  is null or (CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL AND [side].[local_update_peer_timestamp] > @marker_local_update_peer_timestamp 
THEN [side].[update_scope_local_id]
ELSE @marker_update_scope_local_id
 END)  <> @sync_scope_local_id) then (CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL AND [side].[local_update_peer_timestamp] > @marker_local_update_peer_timestamp 
THEN [side].[local_update_peer_timestamp]
ELSE @marker_local_update_peer_timestamp
 END)  else (CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL AND [side].[local_update_peer_timestamp] > @marker_local_update_peer_timestamp 
THEN [side].[scope_update_peer_timestamp]
ELSE @marker_scope_update_peer_timestamp
 END)  end as sync_update_peer_timestamp, case when ((CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL AND [side].[local_update_peer_timestamp] > @marker_local_update_peer_timestamp 
THEN [side].[update_scope_local_id]
ELSE @marker_update_scope_local_id
 END)  is null or (CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL AND [side].[local_update_peer_timestamp] > @marker_local_update_peer_timestamp 
THEN [side].[update_scope_local_id]
ELSE @marker_update_scope_local_id
 END)  <> @sync_scope_local_id) then case when ((CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL AND [side].[local_update_peer_timestamp] > @marker_local_update_peer_timestamp 
THEN [side].[local_update_peer_key]
ELSE @marker_local_update_peer_key
 END)  > @sync_scope_restore_count) then @sync_scope_restore_count else (CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL AND [side].[local_update_peer_timestamp] > @marker_local_update_peer_timestamp 
THEN [side].[local_update_peer_key]
ELSE @marker_local_update_peer_key
 END)  end else (CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL AND [side].[local_update_peer_timestamp] > @marker_local_update_peer_timestamp 
THEN [side].[scope_update_peer_key]
ELSE @marker_scope_update_peer_key
 END)  end as sync_update_peer_key, case when ((CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL 
THEN [side].[create_scope_local_id]
ELSE @marker_create_scope_local_id
 END) 
 is null or (CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL 
THEN [side].[create_scope_local_id]
ELSE @marker_create_scope_local_id
 END) 
 <> @sync_scope_local_id) then (CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL 
THEN [side].[local_create_peer_timestamp]
ELSE @marker_local_create_peer_timestamp
 END) 
 else (CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL 
THEN [side].[scope_create_peer_timestamp]
ELSE @marker_scope_create_peer_timestamp
 END) 
 end as sync_create_peer_timestamp, case when ((CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL 
THEN [side].[create_scope_local_id]
ELSE @marker_create_scope_local_id
 END) 
 is null or (CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL 
THEN [side].[create_scope_local_id]
ELSE @marker_create_scope_local_id
 END) 
 <> @sync_scope_local_id) then case when ((CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL 
THEN [side].[local_create_peer_key]
ELSE @marker_local_create_peer_key
 END) 
 > @sync_scope_restore_count) then @sync_scope_restore_count else (CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL 
THEN [side].[local_create_peer_key]
ELSE @marker_local_create_peer_key
 END) 
 end else (CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL 
THEN [side].[scope_create_peer_key]
ELSE @marker_scope_create_peer_key
 END) 
 end as sync_create_peer_key FROM (SELECT * FROM [dbo].[CD_Facebook_Ads_Publisher_Platform] WHERE [campaign_id] = @P_5 AND [ad_id] = @P_9 AND [adset_id] = @P_13 AND [publisher_platform_pp] = @P_19 AND [platform_position_pp] = @P_21 AND [account_id] = @P_31 AND [date_start] = @P_33) [base] FULL OUTER JOIN (SELECT * FROM [DataSync].[CD_Facebook_Ads_Publisher_Platform_dss_tracking] WHERE [campaign_id] = @P_5 AND [ad_id] = @P_9 AND [adset_id] = @P_13 AND [publisher_platform_pp] = @P_19 AND [platform_position_pp] = @P_21 AND [account_id] = @P_31 AND [date_start] = @P_33) [side] ON [base].[campaign_id] = [side].[campaign_id] AND [base].[ad_id] = [side].[ad_id] AND [base].[adset_id] = [side].[adset_id] AND [base].[publisher_platform_pp] = [side].[publisher_platform_pp] AND [base].[platform_position_pp] = [side].[platform_position_pp] AND [base].[account_id] = [side].[account_id] AND [base].[date_start] = [side].[date_start]
END