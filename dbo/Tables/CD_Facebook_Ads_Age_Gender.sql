CREATE TABLE [dbo].[CD_Facebook_Ads_Age_Gender] (
    [dt_created]                           DATETIME        NULL,
    [dt_updated]                           DATETIME        NULL,
    [dt_filename]                          NVARCHAR (255)  NULL,
    [date_stop]                            DATE            NULL,
    [campaign_id]                          BIGINT          NOT NULL,
    [video_p25_watched_actionsvideo_view]  BIGINT          NULL,
    [actionslink_click]                    BIGINT          NULL,
    [cpm]                                  NUMERIC (20, 4) NULL,
    [ad_id]                                BIGINT          NOT NULL,
    [actionspost_reaction]                 BIGINT          NULL,
    [ad_name]                              NVARCHAR (MAX)  NULL,
    [video_p50_watched_actionsvideo_view]  BIGINT          NULL,
    [adset_id]                             BIGINT          NOT NULL,
    [spend]                                NUMERIC (20, 4) NULL,
    [actionsvideo_view]                    BIGINT          NULL,
    [cpc]                                  NUMERIC (20, 4) NULL,
    [age_ag]                               NVARCHAR (200)  NOT NULL,
    [impressions]                          BIGINT          NULL,
    [ctr]                                  NUMERIC (20, 4) NULL,
    [adset_name]                           NVARCHAR (MAX)  NULL,
    [video_p75_watched_actionsvideo_view]  BIGINT          NULL,
    [video_p100_watched_actionsvideo_view] BIGINT          NULL,
    [actionspost_engagement]               BIGINT          NULL,
    [video_play_actionsvideo_view]         BIGINT          NULL,
    [campaign_name]                        NVARCHAR (MAX)  NULL,
    [actionscomment]                       BIGINT          NULL,
    [actionspage_engagement]               BIGINT          NULL,
    [objective]                            NVARCHAR (MAX)  NULL,
    [actionsonsite_conversionpost_save]    BIGINT          NULL,
    [account_id]                           BIGINT          NOT NULL,
    [clicks]                               BIGINT          NULL,
    [date_start]                           DATE            NOT NULL,
    [gender_ag]                            NVARCHAR (200)  NOT NULL,
    [account_name]                         NVARCHAR (MAX)  NULL,
    [actionspost]                          BIGINT          NULL,
    [campaign_stop_time]                   DATETIME        NULL,
    [ad_creative_image_url]                NVARCHAR (MAX)  NULL,
    [ad_creative_title]                    NVARCHAR (MAX)  NULL,
    [ad_creative_thumbnail_url]            NVARCHAR (MAX)  NULL,
    [ad_creative_body]                     NVARCHAR (MAX)  NULL,
    [campaign_start_time]                  DATETIME        NULL,
    [conversions]                          NUMERIC (20, 4) NULL,
    [video_p100_watched_actions]           NVARCHAR (MAX)  NULL,
    [video_p25_watched_actions]            NVARCHAR (MAX)  NULL,
    [video_p50_watched_actions]            NVARCHAR (MAX)  NULL,
    [video_p75_watched_actions]            NVARCHAR (MAX)  NULL,
    [video_play_actions]                   NVARCHAR (MAX)  NULL,
    [website_purchase_roas]                NVARCHAR (MAX)  NULL,
    [actionsinteractive_component_tap]     BIGINT          NULL,
    PRIMARY KEY CLUSTERED ([campaign_id] ASC, [ad_id] ASC, [adset_id] ASC, [age_ag] ASC, [account_id] ASC, [date_start] ASC, [gender_ag] ASC)
);


GO
CREATE NONCLUSTERED INDEX [ix_CD_Facebook_Ads_Age_Gender_dt_filename]
    ON [dbo].[CD_Facebook_Ads_Age_Gender]([dt_filename] ASC);


GO
CREATE TRIGGER [dbo].[CD_Facebook_Ads_Age_Gender_dss_delete_trigger] ON [dbo].[CD_Facebook_Ads_Age_Gender] FOR DELETE AS
SET NOCOUNT ON
DECLARE @marker_create_scope_local_id INT
DECLARE @marker_scope_create_peer_timestamp BIGINT
DECLARE @marker_scope_create_peer_key INT
DECLARE @marker_local_create_peer_timestamp BIGINT
DECLARE @marker_local_create_peer_key INT
DECLARE @marker_state INT
SELECT TOP 1 @marker_create_scope_local_id = [provision_scope_local_id], @marker_local_create_peer_timestamp = [provision_timestamp], @marker_local_create_peer_key = [provision_local_peer_key], @marker_scope_create_peer_timestamp = [provision_scope_peer_timestamp], @marker_scope_create_peer_key = [provision_scope_peer_key], @marker_state = [state]
FROM [DataSync].[provision_marker_dss]
WHERE [object_id] = 248908504 
 AND [owner_scope_local_id] = 0

MERGE [DataSync].[CD_Facebook_Ads_Age_Gender_dss_tracking] AS [target] 
USING (SELECT [i].[campaign_id], [i].[ad_id], [i].[adset_id], [i].[age_ag], [i].[account_id], [i].[date_start], [i].[gender_ag] FROM DELETED AS [i]) AS source([campaign_id], [ad_id], [adset_id], [age_ag], [account_id], [date_start], [gender_ag]) 
ON ([target].[campaign_id] = [source].[campaign_id] AND [target].[ad_id] = [source].[ad_id] AND [target].[adset_id] = [source].[adset_id] AND [target].[age_ag] = [source].[age_ag] AND [target].[account_id] = [source].[account_id] AND [target].[date_start] = [source].[date_start] AND [target].[gender_ag] = [source].[gender_ag])
WHEN MATCHED THEN
UPDATE SET [sync_row_is_tombstone] = 1, 
[local_update_peer_key] = 0, 
[update_scope_local_id] = NULL, [last_change_datetime] = GETDATE()
WHEN NOT MATCHED THEN
INSERT (
[campaign_id], [ad_id], [adset_id], [age_ag], [account_id], [date_start], [gender_ag] ,
[create_scope_local_id], [scope_create_peer_key], [scope_create_peer_timestamp], [local_create_peer_key], [local_create_peer_timestamp], [update_scope_local_id], [local_update_peer_key], [sync_row_is_tombstone], [last_change_datetime]) 
VALUES (
[source].[campaign_id], [source].[ad_id], [source].[adset_id], [source].[age_ag], [source].[account_id], [source].[date_start], [source].[gender_ag],@marker_create_scope_local_id, @marker_scope_create_peer_key, @marker_scope_create_peer_timestamp, 0, @marker_local_create_peer_timestamp , NULL, 0, 1, GETDATE() );
GO
CREATE TRIGGER [dbo].[CD_Facebook_Ads_Age_Gender_dss_update_trigger] ON [dbo].[CD_Facebook_Ads_Age_Gender] FOR UPDATE AS
SET NOCOUNT ON
DECLARE @marker_create_scope_local_id INT
DECLARE @marker_scope_create_peer_timestamp BIGINT
DECLARE @marker_scope_create_peer_key INT
DECLARE @marker_local_create_peer_timestamp BIGINT
DECLARE @marker_local_create_peer_key INT
DECLARE @marker_state INT
SELECT TOP 1 @marker_create_scope_local_id = [provision_scope_local_id], @marker_local_create_peer_timestamp = [provision_timestamp], @marker_local_create_peer_key = [provision_local_peer_key], @marker_scope_create_peer_timestamp = [provision_scope_peer_timestamp], @marker_scope_create_peer_key = [provision_scope_peer_key], @marker_state = [state]
FROM [DataSync].[provision_marker_dss]
WHERE [object_id] = 248908504 
 AND [owner_scope_local_id] = 0

MERGE [DataSync].[CD_Facebook_Ads_Age_Gender_dss_tracking] AS [target] 
USING (SELECT [i].[campaign_id], [i].[ad_id], [i].[adset_id], [i].[age_ag], [i].[account_id], [i].[date_start], [i].[gender_ag] FROM INSERTED AS [i]) AS source([campaign_id], [ad_id], [adset_id], [age_ag], [account_id], [date_start], [gender_ag]) 
ON ([target].[campaign_id] = [source].[campaign_id] AND [target].[ad_id] = [source].[ad_id] AND [target].[adset_id] = [source].[adset_id] AND [target].[age_ag] = [source].[age_ag] AND [target].[account_id] = [source].[account_id] AND [target].[date_start] = [source].[date_start] AND [target].[gender_ag] = [source].[gender_ag])
WHEN MATCHED THEN
UPDATE SET [sync_row_is_tombstone] = 0, 
[local_update_peer_key] = 0, 
[update_scope_local_id] = NULL, [last_change_datetime] = GETDATE()
WHEN NOT MATCHED THEN
INSERT (
[campaign_id], [ad_id], [adset_id], [age_ag], [account_id], [date_start], [gender_ag] ,
[create_scope_local_id], [scope_create_peer_key], [scope_create_peer_timestamp], [local_create_peer_key], [local_create_peer_timestamp], [update_scope_local_id], [local_update_peer_key], [sync_row_is_tombstone], [last_change_datetime]) 
VALUES (
[source].[campaign_id], [source].[ad_id], [source].[adset_id], [source].[age_ag], [source].[account_id], [source].[date_start], [source].[gender_ag],@marker_create_scope_local_id, @marker_scope_create_peer_key, @marker_scope_create_peer_timestamp, 0, @marker_local_create_peer_timestamp , NULL, 0, 0, GETDATE() );
GO
CREATE TRIGGER [dbo].[CD_Facebook_Ads_Age_Gender_dss_insert_trigger] ON [dbo].[CD_Facebook_Ads_Age_Gender] FOR INSERT AS
SET NOCOUNT ON
DECLARE @marker_create_scope_local_id INT
DECLARE @marker_scope_create_peer_timestamp BIGINT
DECLARE @marker_scope_create_peer_key INT
DECLARE @marker_local_create_peer_timestamp BIGINT
DECLARE @marker_local_create_peer_key INT
DECLARE @marker_state INT
SELECT TOP 1 @marker_create_scope_local_id = [provision_scope_local_id], @marker_local_create_peer_timestamp = [provision_timestamp], @marker_local_create_peer_key = [provision_local_peer_key], @marker_scope_create_peer_timestamp = [provision_scope_peer_timestamp], @marker_scope_create_peer_key = [provision_scope_peer_key], @marker_state = [state]
FROM [DataSync].[provision_marker_dss]
WHERE [object_id] = 248908504 
 AND [owner_scope_local_id] = 0

MERGE [DataSync].[CD_Facebook_Ads_Age_Gender_dss_tracking] AS [target] 
USING (SELECT [i].[campaign_id], [i].[ad_id], [i].[adset_id], [i].[age_ag], [i].[account_id], [i].[date_start], [i].[gender_ag] FROM INSERTED AS [i]) AS source([campaign_id], [ad_id], [adset_id], [age_ag], [account_id], [date_start], [gender_ag]) 
ON ([target].[campaign_id] = [source].[campaign_id] AND [target].[ad_id] = [source].[ad_id] AND [target].[adset_id] = [source].[adset_id] AND [target].[age_ag] = [source].[age_ag] AND [target].[account_id] = [source].[account_id] AND [target].[date_start] = [source].[date_start] AND [target].[gender_ag] = [source].[gender_ag])
WHEN MATCHED THEN
UPDATE SET [sync_row_is_tombstone] = 0, 
[local_update_peer_key] = 0, 
[update_scope_local_id] = NULL, [last_change_datetime] = GETDATE()
WHEN NOT MATCHED THEN
INSERT (
[campaign_id], [ad_id], [adset_id], [age_ag], [account_id], [date_start], [gender_ag] ,
[create_scope_local_id], [scope_create_peer_key], [scope_create_peer_timestamp], [local_create_peer_key], [local_create_peer_timestamp], [update_scope_local_id], [local_update_peer_key], [sync_row_is_tombstone], [last_change_datetime]) 
VALUES (
[source].[campaign_id], [source].[ad_id], [source].[adset_id], [source].[age_ag], [source].[account_id], [source].[date_start], [source].[gender_ag],NULL, NULL, NULL, 0, CAST(@@DBTS AS BIGINT) + 1, NULL, 0, 0, GETDATE() );