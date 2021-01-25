﻿CREATE TABLE [dbo].[Nestle_DV360] (
    [dt_created]                           DATETIME        NULL,
    [dt_updated]                           DATETIME        NULL,
    [dt_filename]                          NVARCHAR (255)  NULL,
    [advertiser]                           NVARCHAR (255)  NULL,
    [advertiser_id]                        BIGINT          NULL,
    [advertiser_currency]                  NVARCHAR (50)   NULL,
    [insertion_order]                      NVARCHAR (150)  NULL,
    [insertion_order_id]                   BIGINT          NULL,
    [line_item]                            NVARCHAR (400)  NULL,
    [line_item_id]                         NVARCHAR (100)  NULL,
    [campaign]                             NVARCHAR (400)  NULL,
    [campaign_id]                          BIGINT          NULL,
    [creative]                             NVARCHAR (450)  NULL,
    [creative_id]                          NVARCHAR (100)  NULL,
    [creative_size]                        NVARCHAR (100)  NULL,
    [creative_type]                        NVARCHAR (100)  NULL,
    [date]                                 DATE            NULL,
    [exchange]                             NVARCHAR (100)  NULL,
    [exchange_id]                          BIGINT          NULL,
    [partner]                              NVARCHAR (100)  NULL,
    [partner_id]                           BIGINT          NULL,
    [cm_placement_id]                      BIGINT          NULL,
    [ad_type]                              NVARCHAR (100)  NULL,
    [advertiser_status]                    NVARCHAR (100)  NULL,
    [line_item_type]                       NVARCHAR (100)  NULL,
    [impression_counting_methodology]      NVARCHAR (100)  NULL,
    [creative_attributes]                  NVARCHAR (100)  NULL,
    [creative_status]                      NVARCHAR (100)  NULL,
    [line_item_status]                     NVARCHAR (100)  NULL,
    [partner_status]                       NVARCHAR (100)  NULL,
    [variant_id]                           BIGINT          NULL,
    [variant_name]                         NVARCHAR (100)  NULL,
    [video_continuous_play]                NVARCHAR (100)  NULL,
    [impressions]                          BIGINT          NULL,
    [billable_impressions]                 NUMERIC (13, 4) NULL,
    [clicks]                               BIGINT          NULL,
    [click_rate_ctr]                       NUMERIC (13, 4) NULL,
    [total_conversions]                    NUMERIC (13, 4) NULL,
    [postclick_conversions]                NUMERIC (13, 4) NULL,
    [postview_conversions]                 NUMERIC (13, 4) NULL,
    [revenue_adv_currency]                 NUMERIC (13, 4) NULL,
    [media_cost_advertiser_currency]       NUMERIC (13, 4) NULL,
    [cm_postclick_revenue]                 NUMERIC (13, 4) NULL,
    [engagements]                          BIGINT          NULL,
    [engagement_rate]                      FLOAT (53)      NULL,
    [cm_postview_revenue]                  NUMERIC (13, 4) NULL,
    [firstquartile_views_video]            BIGINT          NULL,
    [midpoint_views_video]                 BIGINT          NULL,
    [thirdquartile_views_video]            BIGINT          NULL,
    [complete_views_video]                 BIGINT          NULL,
    [total_media_cost_advertiser_currency] NUMERIC (13, 4) NULL,
    [trueview_views]                       BIGINT          NULL,
    [trueview_view_rate]                   NUMERIC (13, 4) NULL,
    [tracked_ads]                          BIGINT          NULL,
    [companion_clicks_video]               BIGINT          NULL,
    [companion_views_video]                BIGINT          NULL,
    [profit_margin]                        NUMERIC (13, 4) NULL,
    [interactive_impressions]              BIGINT          NULL,
    [profit_advertiser_currency]           NUMERIC (13, 4) NULL
);


GO
CREATE NONCLUSTERED INDEX [ix_Nestle_DV360_dt_filename]
    ON [dbo].[Nestle_DV360]([dt_filename] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_Dv360]
    ON [dbo].[Nestle_DV360]([date] ASC)
    INCLUDE([advertiser], [campaign]);

