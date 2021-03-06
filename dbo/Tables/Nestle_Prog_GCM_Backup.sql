﻿CREATE TABLE [dbo].[Nestle_Prog_GCM_Backup] (
    [dt_created]                       DATETIME        NULL,
    [dt_updated]                       DATETIME        NULL,
    [dt_filename]                      NVARCHAR (255)  NULL,
    [placement_end_date]               DATE            NULL,
    [creative_id]                      BIGINT          NULL,
    [date]                             DATE            NULL,
    [ad_id]                            BIGINT          NULL,
    [site_id_site_directory]           BIGINT          NULL,
    [campaign_id]                      BIGINT          NULL,
    [placement_start_date]             DATE            NULL,
    [placement]                        NVARCHAR (MAX)  NULL,
    [campaign_end_date]                NVARCHAR (MAX)  NULL,
    [creative_start_date]              DATE            NULL,
    [flight_booked_cost]               NVARCHAR (MAX)  NULL,
    [week]                             DATE            NULL,
    [month]                            DATE            NULL,
    [advertiser]                       NVARCHAR (MAX)  NULL,
    [creative]                         NVARCHAR (MAX)  NULL,
    [ad]                               NVARCHAR (MAX)  NULL,
    [placement_id]                     BIGINT          NULL,
    [site_dcm]                         NVARCHAR (MAX)  NULL,
    [advertiser_id]                    BIGINT          NULL,
    [flight_start_date]                NVARCHAR (MAX)  NULL,
    [hour]                             BIGINT          NULL,
    [ad_status]                        NVARCHAR (MAX)  NULL,
    [mobile_carrier]                   NVARCHAR (MAX)  NULL,
    [creative_end_date]                DATE            NULL,
    [ad_type]                          NVARCHAR (MAX)  NULL,
    [site_id_dcm]                      BIGINT          NULL,
    [campaign]                         NVARCHAR (MAX)  NULL,
    [dynamic_profile_id]               NVARCHAR (MAX)  NULL,
    [flight_end_date]                  NVARCHAR (MAX)  NULL,
    [creative_type]                    NVARCHAR (MAX)  NULL,
    [dynamic_profile]                  NVARCHAR (MAX)  NULL,
    [site_site_directory]              NVARCHAR (MAX)  NULL,
    [site_keyname]                     NVARCHAR (MAX)  NULL,
    [activity]                         NVARCHAR (MAX)  NULL,
    [activity_group]                   NVARCHAR (MAX)  NULL,
    [campaign_start_date]              NVARCHAR (MAX)  NULL,
    [clicks]                           BIGINT          NULL,
    [impressions]                      BIGINT          NULL,
    [total_conversions]                NUMERIC (13, 4) NULL,
    [total_revenue]                    NUMERIC (13, 4) NULL,
    [video_views]                      BIGINT          NULL,
    [video_completions]                BIGINT          NULL,
    [media_cost]                       NUMERIC (13, 4) NULL,
    [booked_activities]                NUMERIC (13, 4) NULL,
    [booked_clicks]                    NUMERIC (13, 4) NULL,
    [booked_impressions]               NUMERIC (13, 4) NULL,
    [planned_media_cost]               NUMERIC (13, 4) NULL,
    [video_first_quartile_completions] BIGINT          NULL,
    [video_companion_clicks]           BIGINT          NULL,
    [video_midpoints]                  BIGINT          NULL,
    [video_fullscreen]                 BIGINT          NULL,
    [video_interactions]               BIGINT          NULL,
    [video_mutes]                      BIGINT          NULL,
    [companion_clicks]                 BIGINT          NULL,
    [video_pauses]                     BIGINT          NULL,
    [video_plays]                      BIGINT          NULL,
    [companion_views]                  BIGINT          NULL,
    [video_third_quartile_completions] BIGINT          NULL,
    [video_replays]                    BIGINT          NULL,
    [video_skips]                      BIGINT          NULL,
    [video_stops]                      BIGINT          NULL,
    [video_unmutes]                    BIGINT          NULL,
    [fullscreen_video_plays]           BIGINT          NULL,
    [fullscreen_impressions]           BIGINT          NULL,
    [fullscreen_video_completions]     BIGINT          NULL,
    [code_serves]                      BIGINT          NULL,
    [video_view_rate]                  NUMERIC (13, 4) NULL,
    [click_rate]                       NUMERIC (13, 4) NULL,
    [total_interaction_time]           BIGINT          NULL,
    [total_interactions]               BIGINT          NULL,
    [total_social_engagements]         BIGINT          NULL
);


GO
CREATE NONCLUSTERED INDEX [ix_Nestle_GCM_dt_filename]
    ON [dbo].[Nestle_Prog_GCM_Backup]([dt_filename] ASC);

