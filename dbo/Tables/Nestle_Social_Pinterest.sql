﻿CREATE TABLE [dbo].[Nestle_Social_Pinterest] (
    [dt_created]                                         DATETIME        NULL,
    [dt_updated]                                         DATETIME        NULL,
    [dt_filename]                                        NVARCHAR (255)  NULL,
    [advertiser_id]                                      BIGINT          NULL,
    [advertiser_name]                                    NVARCHAR (MAX)  NULL,
    [pin_attribution]                                    NVARCHAR (MAX)  NULL,
    [date]                                               DATE            NULL,
    [conversions]                                        NUMERIC (20, 4) NULL,
    [earned_clicks]                                      NVARCHAR (MAX)  NULL,
    [earned_impressions]                                 BIGINT          NULL,
    [earned_engagements]                                 BIGINT          NULL,
    [earned_video_views]                                 BIGINT          NULL,
    [paid_clicks]                                        BIGINT          NULL,
    [paid_impressions]                                   BIGINT          NULL,
    [paid_engagements]                                   BIGINT          NULL,
    [paid_video_views]                                   BIGINT          NULL,
    [spend_in_account_currency]                          NUMERIC (20, 4) NULL,
    [campaign_id]                                        NVARCHAR (MAX)  NULL,
    [campaign_name]                                      NVARCHAR (MAX)  NULL,
    [ad_group_id]                                        BIGINT          NULL,
    [ad_group_name]                                      NVARCHAR (MAX)  NULL,
    [pin_promotion_id]                                   BIGINT          NULL,
    [pin_promotion_name]                                 NVARCHAR (MAX)  NULL,
    [pin_id]                                             BIGINT          NULL,
    [ad_group_status]                                    NVARCHAR (MAX)  NULL,
    [paid_average_video_watch_time]                      NUMERIC (20, 4) NULL,
    [paid_video_watched_at_100]                          BIGINT          NULL,
    [paid_video_starts]                                  BIGINT          NULL,
    [paid_video_watched_at_25]                           BIGINT          NULL,
    [paid_video_watched_at_50]                           BIGINT          NULL,
    [paid_saves]                                         NVARCHAR (MAX)  NULL,
    [paid_video_watched_at_75]                           BIGINT          NULL,
    [paid_closeups]                                      BIGINT          NULL,
    [paid_video_watched_at_95]                           BIGINT          NULL,
    [earned_saves]                                       BIGINT          NULL,
    [earned_video_starts]                                BIGINT          NULL,
    [earned_video_watched_at_100]                        BIGINT          NULL,
    [earned_closeups]                                    BIGINT          NULL,
    [earned_average_video_watch_time]                    NUMERIC (20, 4) NULL,
    [earned_video_watched_at_75]                         BIGINT          NULL,
    [earned_video_watched_at_50]                         BIGINT          NULL,
    [earned_video_watched_at_25]                         BIGINT          NULL,
    [earned_video_watched_at_95]                         BIGINT          NULL,
    [spend_in_account_currency_micro]                    BIGINT          NULL,
    [conversion_quantity_from_add_to_cart_clicks]        NVARCHAR (MAX)  NULL,
    [conversion_quantity_from_lead_clicks]               NVARCHAR (MAX)  NULL,
    [conversion_quantity_from_search_clicks]             NVARCHAR (MAX)  NULL,
    [conversion_quantity_from_signup_clicks]             NVARCHAR (MAX)  NULL,
    [conversion_quantity_from_page_visit_clicks]         NVARCHAR (MAX)  NULL,
    [conversion_quantity_from_custom_clicks]             NVARCHAR (MAX)  NULL,
    [conversion_quantity_from_watch_video_clicks]        NVARCHAR (MAX)  NULL,
    [conversion_quantity_from_unknown_clicks]            NVARCHAR (MAX)  NULL,
    [conversion_quantity_from_view_category_clicks]      NVARCHAR (MAX)  NULL,
    [total_conversion_value_micro]                       NVARCHAR (MAX)  NULL,
    [total_conversion_value]                             NVARCHAR (MAX)  NULL,
    [total_conversion_quantity]                          NVARCHAR (MAX)  NULL,
    [campaign_managed_status]                            NVARCHAR (MAX)  NULL,
    [campaign_status]                                    NVARCHAR (MAX)  NULL,
    [clickthrough_conversions_add_to_cart]               NVARCHAR (MAX)  NULL,
    [clickthrough_conversions_app_install]               NVARCHAR (MAX)  NULL,
    [clickthrough_conversions_category_view]             NVARCHAR (MAX)  NULL,
    [clickthrough_conversions_checkout]                  NVARCHAR (MAX)  NULL,
    [clickthrough_conversions_custom]                    NVARCHAR (MAX)  NULL,
    [clickthrough_conversions_lead]                      NVARCHAR (MAX)  NULL,
    [clickthrough_conversions_page_visit]                NVARCHAR (MAX)  NULL,
    [clickthrough_conversions_unknown]                   NVARCHAR (MAX)  NULL,
    [clickthrough_conversions_signup]                    NVARCHAR (MAX)  NULL,
    [clickthrough_conversions_watch_video]               NVARCHAR (MAX)  NULL,
    [clickthrough_conversions_website_search]            NVARCHAR (MAX)  NULL,
    [clickthrough_value_custom]                          NVARCHAR (MAX)  NULL,
    [clickthrough_value_micro_lead]                      NVARCHAR (MAX)  NULL,
    [clickthrough_value_micro_custom]                    NVARCHAR (MAX)  NULL,
    [clickthrough_value_micro_category_view]             NVARCHAR (MAX)  NULL,
    [clickthrough_value_micro_signup]                    NVARCHAR (MAX)  NULL,
    [clickthrough_value_micro_app_install]               NVARCHAR (MAX)  NULL,
    [clickthrough_value_website_search]                  NVARCHAR (MAX)  NULL,
    [clickthrough_value_micro_add_to_cart]               NVARCHAR (MAX)  NULL,
    [clickthrough_value_watch_video]                     NVARCHAR (MAX)  NULL,
    [clickthrough_value_micro_page_visit]                NVARCHAR (MAX)  NULL,
    [clickthrough_value_unknown]                         NVARCHAR (MAX)  NULL,
    [clickthrough_value_signup]                          NVARCHAR (MAX)  NULL,
    [clickthrough_value_page_visit]                      NVARCHAR (MAX)  NULL,
    [clickthrough_value_category_view]                   NVARCHAR (MAX)  NULL,
    [clickthrough_value_lead]                            NVARCHAR (MAX)  NULL,
    [clickthrough_value_add_to_cart]                     NVARCHAR (MAX)  NULL,
    [clickthrough_value_app_install]                     NVARCHAR (MAX)  NULL,
    [clickthrough_order_quantity_checkout]               NVARCHAR (MAX)  NULL,
    [clickthrough_value_micro_watch_video]               NVARCHAR (MAX)  NULL,
    [clickthrough_value_micro_website_search]            NVARCHAR (MAX)  NULL,
    [clickthrough_value_micro_unknown]                   NVARCHAR (MAX)  NULL,
    [viewthrough_conversions_add_to_cart]                NVARCHAR (MAX)  NULL,
    [viewthrough_conversions_custom]                     NVARCHAR (MAX)  NULL,
    [viewthrough_conversions_page_visit]                 NVARCHAR (MAX)  NULL,
    [viewthrough_conversions_lead]                       NVARCHAR (MAX)  NULL,
    [viewthrough_conversions_checkout]                   NVARCHAR (MAX)  NULL,
    [viewthrough_conversions_category_view]              NVARCHAR (MAX)  NULL,
    [viewthrough_conversions_watch_video]                NVARCHAR (MAX)  NULL,
    [viewthrough_value_add_to_cart]                      NVARCHAR (MAX)  NULL,
    [viewthrough_order_quantity_checkout]                NVARCHAR (MAX)  NULL,
    [viewthrough_conversions_website_search]             NVARCHAR (MAX)  NULL,
    [viewthrough_conversions_unknown]                    NVARCHAR (MAX)  NULL,
    [viewthrough_conversions_signup]                     NVARCHAR (MAX)  NULL,
    [viewthrough_value_page_visit]                       NVARCHAR (MAX)  NULL,
    [viewthrough_value_lead]                             NVARCHAR (MAX)  NULL,
    [viewthrough_value_signup]                           NVARCHAR (MAX)  NULL,
    [viewthrough_value_category_view]                    NVARCHAR (MAX)  NULL,
    [viewthrough_value_custom]                           NVARCHAR (MAX)  NULL,
    [viewthrough_value_app_install]                      NVARCHAR (MAX)  NULL,
    [viewthrough_value_watch_video]                      NVARCHAR (MAX)  NULL,
    [viewthrough_value_unknown]                          NVARCHAR (MAX)  NULL,
    [viewthrough_value_website_search]                   NVARCHAR (MAX)  NULL,
    [viewthrough_conversions_app_install]                NVARCHAR (MAX)  NULL,
    [viewthrough_value_micro_lead]                       NVARCHAR (MAX)  NULL,
    [viewthrough_value_micro_custom]                     NVARCHAR (MAX)  NULL,
    [viewthrough_value_micro_category_view]              NVARCHAR (MAX)  NULL,
    [viewthrough_value_micro_watch_video]                NVARCHAR (MAX)  NULL,
    [viewthrough_value_micro_signup]                     NVARCHAR (MAX)  NULL,
    [viewthrough_value_micro_page_visit]                 NVARCHAR (MAX)  NULL,
    [viewthrough_value_micro_website_search]             NVARCHAR (MAX)  NULL,
    [viewthrough_value_micro_unknown]                    NVARCHAR (MAX)  NULL,
    [viewthrough_value_micro_add_to_cart]                NVARCHAR (MAX)  NULL,
    [viewthrough_value_micro_app_install]                NVARCHAR (MAX)  NULL,
    [cost_per_2second_50_viewability_video_view]         NUMERIC (20, 4) NULL,
    [cost_per_2second_50_viewability_video_view_micro]   NUMERIC (20, 4) NULL,
    [cost_per_at_least_95_completed_video_view]          NUMERIC (20, 4) NULL,
    [cost_per_at_least_95_completed_video_view_micro]    NUMERIC (20, 4) NULL,
    [cost_per_completed_video_view]                      NUMERIC (20, 4) NULL,
    [cost_per_completed_video_view_micro]                NUMERIC (20, 4) NULL,
    [conversion_quantity_from_custom_views]              NVARCHAR (MAX)  NULL,
    [conversion_quantity_from_custom_engagements]        NVARCHAR (MAX)  NULL,
    [conversion_quantity_from_add_to_cart_views]         NVARCHAR (MAX)  NULL,
    [conversion_quantity_from_lead_engagements]          NVARCHAR (MAX)  NULL,
    [conversion_quantity_from_lead_views]                NVARCHAR (MAX)  NULL,
    [conversion_quantity_from_search_engagements]        NVARCHAR (MAX)  NULL,
    [conversion_quantity_from_search_views]              NVARCHAR (MAX)  NULL,
    [conversion_quantity_from_page_visits]               NVARCHAR (MAX)  NULL,
    [conversion_quantity_from_signup_views]              NVARCHAR (MAX)  NULL,
    [conversion_quantity_from_signup_engagements]        NVARCHAR (MAX)  NULL,
    [conversion_quantity_from_unknown_engagements]       NVARCHAR (MAX)  NULL,
    [conversion_quantity_from_add_to_cart_engagements]   NVARCHAR (MAX)  NULL,
    [conversion_quantity_from_view_category_views]       NVARCHAR (MAX)  NULL,
    [conversion_quantity_from_view_category_engagements] NVARCHAR (MAX)  NULL,
    [conversion_quantity_from_watch_video_engagements]   NVARCHAR (MAX)  NULL,
    [conversion_quantity_from_unknown_views]             NVARCHAR (MAX)  NULL,
    [conversion_quantity_from_watch_video_views]         NVARCHAR (MAX)  NULL,
    [conversion_quantity_from_page_visit_views]          NVARCHAR (MAX)  NULL,
    [engagement_conversions_watch_video]                 NVARCHAR (MAX)  NULL,
    [engagement_value_watch_video]                       NVARCHAR (MAX)  NULL,
    [engagement_value_micro_watch_video]                 NVARCHAR (MAX)  NULL
);


GO
CREATE NONCLUSTERED INDEX [ix_Nestle_Social_Pinterest_dt_filename]
    ON [dbo].[Nestle_Social_Pinterest]([dt_filename] ASC);

