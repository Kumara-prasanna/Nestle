CREATE TABLE [dbo].[CD_Facebook_Ads_Publisher_Platform] (
    [dt_created]                                               DATETIME        NULL,
    [dt_updated]                                               DATETIME        NULL,
    [dt_filename]                                              NVARCHAR (255)  NULL,
    [date_stop]                                                DATE            NULL,
    [campaign_id]                                              BIGINT          NOT NULL,
    [video_p25_watched_actionsvideo_view]                      BIGINT          NULL,
    [actionslink_click]                                        BIGINT          NULL,
    [cpm]                                                      NUMERIC (20, 4) NULL,
    [ad_id]                                                    BIGINT          NOT NULL,
    [actionspost_reaction]                                     BIGINT          NULL,
    [ad_name]                                                  NVARCHAR (MAX)  NULL,
    [video_p50_watched_actionsvideo_view]                      BIGINT          NULL,
    [adset_id]                                                 BIGINT          NOT NULL,
    [spend]                                                    NUMERIC (20, 4) NULL,
    [actionsvideo_view]                                        BIGINT          NULL,
    [cpc]                                                      NUMERIC (20, 4) NULL,
    [impressions]                                              BIGINT          NULL,
    [ctr]                                                      NUMERIC (20, 4) NULL,
    [publisher_platform_pp]                                    NVARCHAR (200)  NOT NULL,
    [adset_name]                                               NVARCHAR (MAX)  NULL,
    [platform_position_pp]                                     NVARCHAR (200)  NOT NULL,
    [video_p75_watched_actionsvideo_view]                      BIGINT          NULL,
    [video_p100_watched_actionsvideo_view]                     BIGINT          NULL,
    [actionspost_engagement]                                   BIGINT          NULL,
    [video_play_actionsvideo_view]                             BIGINT          NULL,
    [campaign_name]                                            NVARCHAR (MAX)  NULL,
    [actionscomment]                                           BIGINT          NULL,
    [actionspage_engagement]                                   BIGINT          NULL,
    [objective]                                                NVARCHAR (MAX)  NULL,
    [actionsonsite_conversionpost_save]                        BIGINT          NULL,
    [account_id]                                               BIGINT          NOT NULL,
    [clicks]                                                   BIGINT          NULL,
    [date_start]                                               DATE            NOT NULL,
    [account_name]                                             NVARCHAR (MAX)  NULL,
    [actionspost]                                              BIGINT          NULL,
    [campaign_stop_time]                                       DATETIME        NULL,
    [ad_creative_image_url]                                    NVARCHAR (MAX)  NULL,
    [ad_creative_title]                                        NVARCHAR (MAX)  NULL,
    [ad_creative_thumbnail_url]                                NVARCHAR (MAX)  NULL,
    [ad_creative_body]                                         NVARCHAR (MAX)  NULL,
    [campaign_start_time]                                      DATETIME        NULL,
    [conversions]                                              NUMERIC (20, 4) NULL,
    [video_p100_watched_actions]                               NVARCHAR (MAX)  NULL,
    [video_p25_watched_actions]                                NVARCHAR (MAX)  NULL,
    [video_p50_watched_actions]                                NVARCHAR (MAX)  NULL,
    [video_p75_watched_actions]                                NVARCHAR (MAX)  NULL,
    [video_play_actions]                                       NVARCHAR (MAX)  NULL,
    [website_purchase_roas]                                    NVARCHAR (MAX)  NULL,
    [actionslike]                                              BIGINT          NULL,
    [actionslanding_page_view]                                 BIGINT          NULL,
    [actionsinteractive_component_tap]                         BIGINT          NULL,
    [actionsphoto_view]                                        NVARCHAR (MAX)  NULL,
    [actionsoffsite_conversionfb_pixel_add_to_cart]            BIGINT          NULL,
    [actionsadd_to_cart]                                       NVARCHAR (MAX)  NULL,
    [actionspurchase]                                          NVARCHAR (MAX)  NULL,
    [actionsomni_add_to_cart]                                  BIGINT          NULL,
    [action_valuesoffsite_conversionfb_pixel_purchase]         NUMERIC (20, 4) NULL,
    [website_purchase_roasoffsite_conversionfb_pixel_purchase] NVARCHAR (MAX)  NULL,
    [actionsomni_purchase]                                     BIGINT          NULL,
    [actionsoffsite_conversionfb_pixel_purchase]               BIGINT          NULL,
    [action_valuesomni_purchase]                               NUMERIC (20, 4) NULL,
    [actionsinitiate_checkout]                                 NVARCHAR (MAX)  NULL,
    [actionsomni_initiated_checkout]                           NVARCHAR (MAX)  NULL,
    [actionsoffsite_conversionfb_pixel_initiate_checkout]      NVARCHAR (MAX)  NULL,
    [actionsoffsite_conversionfb_pixel_complete_registration]  NVARCHAR (MAX)  NULL,
    [actionsomni_complete_registration]                        NVARCHAR (MAX)  NULL,
    [actionscomplete_registration]                             NVARCHAR (MAX)  NULL,
    CONSTRAINT [CD_Facebook_Ads_Publisher_Platform_pkey] PRIMARY KEY CLUSTERED ([campaign_id] ASC, [ad_id] ASC, [adset_id] ASC, [publisher_platform_pp] ASC, [platform_position_pp] ASC, [account_id] ASC, [date_start] ASC)
);


GO
CREATE NONCLUSTERED INDEX [ix_CD_Facebook_Ads_Publisher_Platform_dt_filename]
    ON [dbo].[CD_Facebook_Ads_Publisher_Platform]([dt_filename] ASC);


GO
CREATE TRIGGER [dbo].[CD_Facebook_Ads_Publisher_Platform_dss_delete_trigger] ON [dbo].[CD_Facebook_Ads_Publisher_Platform] FOR DELETE AS
SET NOCOUNT ON
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

MERGE [DataSync].[CD_Facebook_Ads_Publisher_Platform_dss_tracking] AS [target] 
USING (SELECT [i].[campaign_id], [i].[ad_id], [i].[adset_id], [i].[publisher_platform_pp], [i].[platform_position_pp], [i].[account_id], [i].[date_start] FROM DELETED AS [i]) AS source([campaign_id], [ad_id], [adset_id], [publisher_platform_pp], [platform_position_pp], [account_id], [date_start]) 
ON ([target].[campaign_id] = [source].[campaign_id] AND [target].[ad_id] = [source].[ad_id] AND [target].[adset_id] = [source].[adset_id] AND [target].[publisher_platform_pp] = [source].[publisher_platform_pp] AND [target].[platform_position_pp] = [source].[platform_position_pp] AND [target].[account_id] = [source].[account_id] AND [target].[date_start] = [source].[date_start])
WHEN MATCHED THEN
UPDATE SET [sync_row_is_tombstone] = 1, 
[local_update_peer_key] = 0, 
[update_scope_local_id] = NULL, [last_change_datetime] = GETDATE()
WHEN NOT MATCHED THEN
INSERT (
[campaign_id], [ad_id], [adset_id], [publisher_platform_pp], [platform_position_pp], [account_id], [date_start] ,
[create_scope_local_id], [scope_create_peer_key], [scope_create_peer_timestamp], [local_create_peer_key], [local_create_peer_timestamp], [update_scope_local_id], [local_update_peer_key], [sync_row_is_tombstone], [last_change_datetime]) 
VALUES (
[source].[campaign_id], [source].[ad_id], [source].[adset_id], [source].[publisher_platform_pp], [source].[platform_position_pp], [source].[account_id], [source].[date_start],@marker_create_scope_local_id, @marker_scope_create_peer_key, @marker_scope_create_peer_timestamp, 0, @marker_local_create_peer_timestamp , NULL, 0, 1, GETDATE() );
GO
CREATE TRIGGER [dbo].[CD_Facebook_Ads_Publisher_Platform_dss_update_trigger] ON [dbo].[CD_Facebook_Ads_Publisher_Platform] FOR UPDATE AS
SET NOCOUNT ON
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

MERGE [DataSync].[CD_Facebook_Ads_Publisher_Platform_dss_tracking] AS [target] 
USING (SELECT [i].[campaign_id], [i].[ad_id], [i].[adset_id], [i].[publisher_platform_pp], [i].[platform_position_pp], [i].[account_id], [i].[date_start] FROM INSERTED AS [i]) AS source([campaign_id], [ad_id], [adset_id], [publisher_platform_pp], [platform_position_pp], [account_id], [date_start]) 
ON ([target].[campaign_id] = [source].[campaign_id] AND [target].[ad_id] = [source].[ad_id] AND [target].[adset_id] = [source].[adset_id] AND [target].[publisher_platform_pp] = [source].[publisher_platform_pp] AND [target].[platform_position_pp] = [source].[platform_position_pp] AND [target].[account_id] = [source].[account_id] AND [target].[date_start] = [source].[date_start])
WHEN MATCHED THEN
UPDATE SET [sync_row_is_tombstone] = 0, 
[local_update_peer_key] = 0, 
[update_scope_local_id] = NULL, [last_change_datetime] = GETDATE()
WHEN NOT MATCHED THEN
INSERT (
[campaign_id], [ad_id], [adset_id], [publisher_platform_pp], [platform_position_pp], [account_id], [date_start] ,
[create_scope_local_id], [scope_create_peer_key], [scope_create_peer_timestamp], [local_create_peer_key], [local_create_peer_timestamp], [update_scope_local_id], [local_update_peer_key], [sync_row_is_tombstone], [last_change_datetime]) 
VALUES (
[source].[campaign_id], [source].[ad_id], [source].[adset_id], [source].[publisher_platform_pp], [source].[platform_position_pp], [source].[account_id], [source].[date_start],@marker_create_scope_local_id, @marker_scope_create_peer_key, @marker_scope_create_peer_timestamp, 0, @marker_local_create_peer_timestamp , NULL, 0, 0, GETDATE() );
GO
CREATE TRIGGER [dbo].[CD_Facebook_Ads_Publisher_Platform_dss_insert_trigger] ON [dbo].[CD_Facebook_Ads_Publisher_Platform] FOR INSERT AS
SET NOCOUNT ON
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

MERGE [DataSync].[CD_Facebook_Ads_Publisher_Platform_dss_tracking] AS [target] 
USING (SELECT [i].[campaign_id], [i].[ad_id], [i].[adset_id], [i].[publisher_platform_pp], [i].[platform_position_pp], [i].[account_id], [i].[date_start] FROM INSERTED AS [i]) AS source([campaign_id], [ad_id], [adset_id], [publisher_platform_pp], [platform_position_pp], [account_id], [date_start]) 
ON ([target].[campaign_id] = [source].[campaign_id] AND [target].[ad_id] = [source].[ad_id] AND [target].[adset_id] = [source].[adset_id] AND [target].[publisher_platform_pp] = [source].[publisher_platform_pp] AND [target].[platform_position_pp] = [source].[platform_position_pp] AND [target].[account_id] = [source].[account_id] AND [target].[date_start] = [source].[date_start])
WHEN MATCHED THEN
UPDATE SET [sync_row_is_tombstone] = 0, 
[local_update_peer_key] = 0, 
[update_scope_local_id] = NULL, [last_change_datetime] = GETDATE()
WHEN NOT MATCHED THEN
INSERT (
[campaign_id], [ad_id], [adset_id], [publisher_platform_pp], [platform_position_pp], [account_id], [date_start] ,
[create_scope_local_id], [scope_create_peer_key], [scope_create_peer_timestamp], [local_create_peer_key], [local_create_peer_timestamp], [update_scope_local_id], [local_update_peer_key], [sync_row_is_tombstone], [last_change_datetime]) 
VALUES (
[source].[campaign_id], [source].[ad_id], [source].[adset_id], [source].[publisher_platform_pp], [source].[platform_position_pp], [source].[account_id], [source].[date_start],NULL, NULL, NULL, 0, CAST(@@DBTS AS BIGINT) + 1, NULL, 0, 0, GETDATE() );