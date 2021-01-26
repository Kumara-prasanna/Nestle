CREATE PROCEDURE [DataSync].[CD_TEST_ADVERITY_dss_update_86428056-fea2-4062-8e10-5f42d853c559]
	@P_1 DateTime,
	@P_2 DateTime,
	@P_3 NVarChar(255),
	@P_4 Date,
	@P_5 BigInt,
	@P_6 BigInt,
	@P_7 BigInt,
	@P_8 Decimal(20,4),
	@P_9 BigInt,
	@P_10 BigInt,
	@P_11 NVarChar(max),
	@P_12 BigInt,
	@P_13 BigInt,
	@P_14 Decimal(20,4),
	@P_15 BigInt,
	@P_16 Decimal(20,4),
	@P_17 NVarChar(200),
	@P_18 BigInt,
	@P_19 Decimal(20,4),
	@P_20 NVarChar(max),
	@P_21 BigInt,
	@P_22 BigInt,
	@P_23 BigInt,
	@P_24 BigInt,
	@P_25 BigInt,
	@P_26 NVarChar(max),
	@P_27 NVarChar(max),
	@P_28 BigInt,
	@P_29 BigInt,
	@P_30 BigInt,
	@P_31 BigInt,
	@P_32 Date,
	@P_33 NVarChar(200),
	@P_34 BigInt,
	@P_35 NVarChar(max),
	@P_36 BigInt,
	@P_37 DateTime,
	@P_38 NVarChar(max),
	@P_39 NVarChar(max),
	@P_40 NVarChar(max),
	@P_41 NVarChar(max),
	@P_42 DateTime,
	@P_43 Decimal(20,4),
	@P_44 NVarChar(max),
	@P_45 NVarChar(max),
	@P_46 NVarChar(max),
	@P_47 NVarChar(max),
	@P_48 NVarChar(max),
	@P_49 NVarChar(max),
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
WHERE [object_id] = 741434261 
 AND [owner_scope_local_id] = 0

DECLARE @marker_update_scope_local_id INT
DECLARE @marker_scope_update_peer_timestamp BIGINT
DECLARE @marker_scope_update_peer_key INT
DECLARE @marker_local_update_peer_timestamp BIGINT
DECLARE @marker_local_update_peer_key INT
SELECT TOP 1 @marker_update_scope_local_id = [provision_scope_local_id], @marker_local_update_peer_timestamp = [provision_timestamp], @marker_local_update_peer_key = [provision_local_peer_key], @marker_scope_update_peer_timestamp = [provision_scope_peer_timestamp], @marker_scope_update_peer_key = [provision_scope_peer_key]
FROM [DataSync].[provision_marker_dss]
WHERE [object_id] = 741434261 
 AND [owner_scope_local_id] = 1
SET @sync_row_count = 0; UPDATE [dbo].[CD_TEST_ADVERITY] SET [dt_created] = @P_1, [dt_updated] = @P_2, [dt_filename] = @P_3, [date_stop] = @P_4, [video_p25_watched_actionsvideo_view] = @P_6, [actionslink_click] = @P_7, [cpm] = @P_8, [actionspost_reaction] = @P_10, [ad_name] = @P_11, [video_p50_watched_actionsvideo_view] = @P_12, [spend] = @P_14, [actionsvideo_view] = @P_15, [cpc] = @P_16, [impressions] = @P_18, [ctr] = @P_19, [adset_name] = @P_20, [actionsinteractive_component_tap] = @P_21, [video_p75_watched_actionsvideo_view] = @P_22, [video_p100_watched_actionsvideo_view] = @P_23, [actionspost_engagement] = @P_24, [video_play_actionsvideo_view] = @P_25, [campaign_name] = @P_26, [objective] = @P_27, [actionspage_engagement] = @P_28, [actionscomment] = @P_29, [clicks] = @P_31, [actionsonsite_conversionpost_save] = @P_34, [account_name] = @P_35, [actionspost] = @P_36, [campaign_stop_time] = @P_37, [ad_creative_image_url] = @P_38, [ad_creative_title] = @P_39, [ad_creative_thumbnail_url] = @P_40, [ad_creative_body] = @P_41, [campaign_start_time] = @P_42, [conversions] = @P_43, [video_p100_watched_actions] = @P_44, [video_p25_watched_actions] = @P_45, [video_p50_watched_actions] = @P_46, [video_p75_watched_actions] = @P_47, [video_play_actions] = @P_48, [website_purchase_roas] = @P_49 FROM [dbo].[CD_TEST_ADVERITY] [base] LEFT JOIN [DataSync].[CD_TEST_ADVERITY_dss_tracking] [side] ON [base].[campaign_id] = [side].[campaign_id] AND [base].[ad_id] = [side].[ad_id] AND [base].[adset_id] = [side].[adset_id] AND [base].[age_ag] = [side].[age_ag] AND [base].[account_id] = [side].[account_id] AND [base].[date_start] = [side].[date_start] AND [base].[gender_ag] = [side].[gender_ag] WHERE ((CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL AND [side].[local_update_peer_timestamp] > @marker_local_update_peer_timestamp 
THEN [side].[local_update_peer_timestamp]
ELSE @marker_local_update_peer_timestamp
 END)  <= @sync_min_timestamp OR @sync_force_write = 1) AND ([base].[campaign_id] = @P_5 AND [base].[ad_id] = @P_9 AND [base].[adset_id] = @P_13 AND [base].[age_ag] = @P_17 AND [base].[account_id] = @P_30 AND [base].[date_start] = @P_32 AND [base].[gender_ag] = @P_33); SET @sync_row_count = @@ROWCOUNT;
END