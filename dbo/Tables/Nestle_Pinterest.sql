﻿CREATE TABLE [dbo].[Nestle_Pinterest] (
    [dt_created]                                 DATETIME        NULL,
    [dt_updated]                                 DATETIME        NULL,
    [dt_filename]                                NVARCHAR (255)  NULL,
    [advertiser_id]                              BIGINT          NULL,
    [advertiser_name]                            NVARCHAR (MAX)  NULL,
    [pin_attribution]                            NVARCHAR (MAX)  NULL,
    [date]                                       DATE            NULL,
    [conversions]                                NUMERIC (20, 4) NULL,
    [earned_clicks]                              NVARCHAR (MAX)  NULL,
    [earned_impressions]                         BIGINT          NULL,
    [earned_engagements]                         BIGINT          NULL,
    [earned_video_views]                         BIGINT          NULL,
    [paid_clicks]                                BIGINT          NULL,
    [paid_impressions]                           BIGINT          NULL,
    [paid_engagements]                           BIGINT          NULL,
    [paid_video_views]                           BIGINT          NULL,
    [spend_in_account_currency]                  NUMERIC (20, 4) NULL,
    [campaign_id]                                NVARCHAR (MAX)  NULL,
    [campaign_name]                              NVARCHAR (MAX)  NULL,
    [spend_in_account_currency_micro]            BIGINT          NULL,
    [cost_per_completed_video_view]              NUMERIC (20, 4) NULL,
    [cost_per_completed_video_view_micro]        NUMERIC (20, 4) NULL,
    [engagement_value_category_view]             NVARCHAR (MAX)  NULL,
    [engagement_value_add_to_cart]               NVARCHAR (MAX)  NULL,
    [engagement_value_custom]                    NVARCHAR (MAX)  NULL,
    [engagement_value_lead]                      NVARCHAR (MAX)  NULL,
    [engagement_value_page_visit]                NVARCHAR (MAX)  NULL,
    [engagement_value_app_install]               NVARCHAR (MAX)  NULL,
    [engagement_value_signup]                    NVARCHAR (MAX)  NULL,
    [engagement_conversions_website_search]      NVARCHAR (MAX)  NULL,
    [engagement_value_unknown]                   NVARCHAR (MAX)  NULL,
    [engagement_order_quantity_checkout]         NVARCHAR (MAX)  NULL,
    [engagement_conversions_watch_video]         NVARCHAR (MAX)  NULL,
    [engagement_conversions_page_visit]          NVARCHAR (MAX)  NULL,
    [engagement_conversions_category_view]       NVARCHAR (MAX)  NULL,
    [engagement_conversions_app_install]         NVARCHAR (MAX)  NULL,
    [engagement_conversions_checkout]            NVARCHAR (MAX)  NULL,
    [engagement_conversions_custom]              NVARCHAR (MAX)  NULL,
    [engagement_conversions_lead]                NVARCHAR (MAX)  NULL,
    [engagement_conversions_signup]              NVARCHAR (MAX)  NULL,
    [engagement_conversions_unknown]             NVARCHAR (MAX)  NULL,
    [engagement_value_watch_video]               NVARCHAR (MAX)  NULL,
    [engagement_value_website_search]            NVARCHAR (MAX)  NULL,
    [checkout_value_from_click_conversions]      NVARCHAR (MAX)  NULL,
    [checkout_value_from_engagement_conversions] NVARCHAR (MAX)  NULL,
    [checkout_value_from_view_conversions]       NVARCHAR (MAX)  NULL,
    [clickthrough_conversions_add_to_cart]       NVARCHAR (MAX)  NULL,
    [clickthrough_conversions_app_install]       NVARCHAR (MAX)  NULL,
    [clickthrough_conversions_category_view]     NVARCHAR (MAX)  NULL,
    [clickthrough_conversions_lead]              NVARCHAR (MAX)  NULL,
    [clickthrough_conversions_custom]            NVARCHAR (MAX)  NULL,
    [clickthrough_conversions_unknown]           NVARCHAR (MAX)  NULL,
    [clickthrough_conversions_watch_video]       NVARCHAR (MAX)  NULL,
    [clickthrough_conversions_signup]            NVARCHAR (MAX)  NULL,
    [clickthrough_conversions_page_visit]        NVARCHAR (MAX)  NULL,
    [checkout_value_from_view_conversions_micro] NVARCHAR (MAX)  NULL,
    [clickthrough_conversions_checkout]          NVARCHAR (MAX)  NULL,
    [clickthrough_conversions_website_search]    NVARCHAR (MAX)  NULL,
    [conversions_app_install]                    NVARCHAR (MAX)  NULL,
    [engagement_conversions_add_to_cart]         NVARCHAR (MAX)  NULL,
    [viewthrough_conversions_checkout]           NVARCHAR (MAX)  NULL,
    [viewthrough_conversions_category_view]      NVARCHAR (MAX)  NULL,
    [viewthrough_conversions_app_install]        NVARCHAR (MAX)  NULL,
    [viewthrough_conversions_page_visit]         NVARCHAR (MAX)  NULL,
    [viewthrough_conversions_custom]             NVARCHAR (MAX)  NULL,
    [viewthrough_conversions_add_to_cart]        NVARCHAR (MAX)  NULL,
    [web_view_category_roas]                     NVARCHAR (MAX)  NULL,
    [web_unknown_roas]                           NVARCHAR (MAX)  NULL,
    [web_signup_roas]                            NVARCHAR (MAX)  NULL,
    [web_search_roas]                            NVARCHAR (MAX)  NULL,
    [web_page_visit_roas]                        NVARCHAR (MAX)  NULL,
    [web_lead_roas]                              NVARCHAR (MAX)  NULL,
    [web_custom_roas]                            NVARCHAR (MAX)  NULL,
    [web_checkout_roas]                          NVARCHAR (MAX)  NULL,
    [web_add_to_cart_roas]                       NVARCHAR (MAX)  NULL,
    [viewthrough_conversions_signup]             NVARCHAR (MAX)  NULL,
    [viewthrough_conversions_unknown]            NVARCHAR (MAX)  NULL,
    [viewthrough_conversions_lead]               NVARCHAR (MAX)  NULL,
    [viewthrough_conversions_watch_video]        NVARCHAR (MAX)  NULL,
    [viewthrough_conversions_website_search]     NVARCHAR (MAX)  NULL,
    [conversion_quantity_from_watch_video_views] NVARCHAR (MAX)  NULL,
    [paid_video_watched_at_25]                   BIGINT          NULL,
    [earned_video_watched_at_25]                 BIGINT          NULL,
    [cost_per_2second_50_viewability_video_view] NUMERIC (20, 4) NULL,
    [earned_video_watched_at_50]                 BIGINT          NULL,
    [paid_video_watched_at_50]                   BIGINT          NULL,
    [earned_video_watched_at_75]                 BIGINT          NULL,
    [paid_video_watched_at_75]                   BIGINT          NULL,
    [paid_video_watched_at_100]                  BIGINT          NULL,
    [earned_video_watched_at_100]                BIGINT          NULL,
    [earned_saves]                               BIGINT          NULL,
    [paid_saves]                                 NVARCHAR (MAX)  NULL
);


GO
CREATE NONCLUSTERED INDEX [ix_Nestle_Pinterest_dt_filename]
    ON [dbo].[Nestle_Pinterest]([dt_filename] ASC);
