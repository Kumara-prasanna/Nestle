CREATE TABLE [dbo].[Nestle_GCM] (
    [dt_created]                              DATETIME        NULL,
    [dt_updated]                              DATETIME        NULL,
    [dt_filename]                             NVARCHAR (255)  NULL,
    [creative_id]                             NVARCHAR (100)  NULL,
    [date]                                    DATE            NULL,
    [campaign_id]                             NVARCHAR (100)  NULL,
    [placement]                               NVARCHAR (450)  NULL,
    [campaign_end_date]                       NVARCHAR (100)  NULL,
    [advertiser]                              NVARCHAR (100)  NULL,
    [creative]                                NVARCHAR (100)  NULL,
    [placement_id]                            BIGINT          NULL,
    [site_dcm]                                NVARCHAR (50)   NULL,
    [advertiser_id]                           BIGINT          NULL,
    [campaign_start_date]                     NVARCHAR (50)   NULL,
    [site_id_dcm]                             BIGINT          NULL,
    [campaign]                                NVARCHAR (450)  NULL,
    [creative_type]                           NVARCHAR (50)   NULL,
    [activity]                                NVARCHAR (100)  NULL,
    [clicks]                                  BIGINT          NULL,
    [impressions]                             BIGINT          NULL,
    [total_conversions]                       NUMERIC (20, 4) NULL,
    [total_revenue]                           NUMERIC (20, 4) NULL,
    [video_views]                             BIGINT          NULL,
    [video_completions]                       BIGINT          NULL,
    [media_cost]                              NUMERIC (20, 4) NULL,
    [video_first_quartile_completions]        BIGINT          NULL,
    [video_midpoints]                         BIGINT          NULL,
    [video_third_quartile_completions]        BIGINT          NULL,
    [video_stops]                             BIGINT          NULL,
    [video_view_rate]                         NUMERIC (20, 4) NULL,
    [click_rate]                              NUMERIC (20, 4) NULL,
    [total_interaction_time]                  BIGINT          NULL,
    [total_interactions]                      BIGINT          NULL,
    [total_social_engagements]                BIGINT          NULL,
    [creative_pixel_size]                     NVARCHAR (10)   NULL,
    [placement_end_date]                      DATE            NULL,
    [placement_start_date]                    DATE            NULL,
    [ad_id]                                   BIGINT          NULL,
    [placement_cost_structure]                NVARCHAR (25)   NULL,
    [video_plays]                             BIGINT          NULL,
    [code_serves]                             BIGINT          NULL,
    [fullscreen_video_plays]                  BIGINT          NULL,
    [fullscreen_impressions]                  BIGINT          NULL,
    [fullscreen_video_completions]            BIGINT          NULL,
    [fullscreen_average_view_time]            NUMERIC (20, 4) NULL,
    [video_fullscreen]                        BIGINT          NULL,
    [companion_clicks]                        BIGINT          NULL,
    [companion_views]                         BIGINT          NULL,
    [video_replays]                           BIGINT          NULL,
    [video_skips]                             BIGINT          NULL,
    [trueview_views]                          BIGINT          NULL,
    [video_mutes]                             BIGINT          NULL,
    [video_unmutes]                           BIGINT          NULL,
    [video_interaction_rate]                  NUMERIC (20, 4) NULL,
    [video_average_view_time]                 NUMERIC (20, 4) NULL,
    [video_companion_clicks]                  BIGINT          NULL,
    [video_pauses]                            BIGINT          NULL,
    [video_interactions]                      BIGINT          NULL,
    [video_progress_events]                   BIGINT          NULL,
    [twitter_video_100_in_view_for_3_seconds] BIGINT          NULL,
    [twitter_video_50_in_view_for_2_seconds]  BIGINT          NULL
);


GO
CREATE NONCLUSTERED INDEX [ix_Nestle_GCM_dt_filename]
    ON [dbo].[Nestle_GCM]([dt_filename] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_gcm]
    ON [dbo].[Nestle_GCM]([date] ASC)
    INCLUDE([placement], [campaign]);

