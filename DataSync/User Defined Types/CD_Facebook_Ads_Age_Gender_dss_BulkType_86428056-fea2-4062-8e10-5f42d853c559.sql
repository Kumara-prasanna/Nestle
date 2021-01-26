﻿CREATE TYPE [DataSync].[CD_Facebook_Ads_Age_Gender_dss_BulkType_86428056-fea2-4062-8e10-5f42d853c559] AS TABLE (
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
    [sync_update_peer_timestamp]           BIGINT          NULL,
    [sync_update_peer_key]                 INT             NULL,
    [sync_create_peer_timestamp]           BIGINT          NULL,
    [sync_create_peer_key]                 INT             NULL,
    PRIMARY KEY CLUSTERED ([campaign_id] ASC, [ad_id] ASC, [adset_id] ASC, [age_ag] ASC, [account_id] ASC, [date_start] ASC, [gender_ag] ASC));

