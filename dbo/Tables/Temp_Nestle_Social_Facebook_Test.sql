﻿CREATE TABLE [dbo].[Temp_Nestle_Social_Facebook_Test] (
    [dt_created]                                                     DATETIME        NULL,
    [dt_updated]                                                     DATETIME        NULL,
    [dt_filename]                                                    NVARCHAR (255)  NULL,
    [clicks]                                                         BIGINT          NULL,
    [actionspage_engagement]                                         BIGINT          NULL,
    [actionscomment]                                                 BIGINT          NULL,
    [actionspost_reaction]                                           BIGINT          NULL,
    [age]                                                            NVARCHAR (MAX)  NULL,
    [unique_actionsoffsite_conversionfb_pixel_view_content]          NVARCHAR (MAX)  NULL,
    [video_play_actionsvideo_view]                                   BIGINT          NULL,
    [impressions]                                                    BIGINT          NULL,
    [actionsonsite_conversionpost_save]                              BIGINT          NULL,
    [unique_actionslanding_page_view]                                BIGINT          NULL,
    [unique_actionsvideo_view]                                       BIGINT          NULL,
    [adset_name]                                                     NVARCHAR (MAX)  NULL,
    [actionslink_click]                                              BIGINT          NULL,
    [unique_actionscomment]                                          BIGINT          NULL,
    [video_p95_watched_actionsvideo_view]                            BIGINT          NULL,
    [date_stop]                                                      DATE            NULL,
    [actionspost_engagement]                                         BIGINT          NULL,
    [cpm]                                                            NUMERIC (20, 4) NULL,
    [account_name]                                                   NVARCHAR (MAX)  NULL,
    [video_p50_watched_actionsvideo_view]                            BIGINT          NULL,
    [gender]                                                         NVARCHAR (MAX)  NULL,
    [video_p100_watched_actionsvideo_view]                           BIGINT          NULL,
    [actionspost]                                                    BIGINT          NULL,
    [actionsvideo_view]                                              BIGINT          NULL,
    [date_start]                                                     DATE            NULL,
    [adset_id]                                                       BIGINT          NULL,
    [video_p25_watched_actionsvideo_view]                            BIGINT          NULL,
    [actionsview_content]                                            NVARCHAR (MAX)  NULL,
    [ctr]                                                            NUMERIC (20, 4) NULL,
    [cpc]                                                            NUMERIC (20, 4) NULL,
    [unique_actionslink_click]                                       BIGINT          NULL,
    [unique_actionsonsite_conversionpost_save]                       BIGINT          NULL,
    [account_id]                                                     NVARCHAR (MAX)  NULL,
    [video_p75_watched_actionsvideo_view]                            BIGINT          NULL,
    [unique_actionspost_reaction]                                    BIGINT          NULL,
    [campaign_name]                                                  NVARCHAR (MAX)  NULL,
    [spend]                                                          NUMERIC (20, 4) NULL,
    [actionslanding_page_view]                                       BIGINT          NULL,
    [unique_actionspost]                                             BIGINT          NULL,
    [campaign_id]                                                    NVARCHAR (MAX)  NULL,
    [ad_id]                                                          BIGINT          NULL,
    [ad_name]                                                        NVARCHAR (MAX)  NULL,
    [unique_actionspage_engagement]                                  BIGINT          NULL,
    [actionsomni_view_content]                                       NVARCHAR (MAX)  NULL,
    [unique_actionsoffsite_conversion]                               BIGINT          NULL,
    [unique_actionsomni_view_content]                                NVARCHAR (MAX)  NULL,
    [unique_actionspost_engagement]                                  BIGINT          NULL,
    [cpp]                                                            NUMERIC (20, 4) NULL,
    [actionsoffsite_conversionfb_pixel_view_content]                 NVARCHAR (MAX)  NULL,
    [objective]                                                      NVARCHAR (MAX)  NULL,
    [ad_creative_object_story_spec]                                  VARCHAR (MAX)   NULL,
    [ad_creative_body]                                               NVARCHAR (MAX)  NULL,
    [account_business_name]                                          NVARCHAR (MAX)  NULL,
    [ad_creative_instagram_actor_id]                                 BIGINT          NULL,
    [ad_creative_call_to_action_type]                                NVARCHAR (MAX)  NULL,
    [ad_creative_object_url]                                         NVARCHAR (MAX)  NULL,
    [adset_adlabels]                                                 NVARCHAR (MAX)  NULL,
    [ad_creative_name]                                               NVARCHAR (MAX)  NULL,
    [ad_creative_template_url_spec]                                  NVARCHAR (MAX)  NULL,
    [ad_creative_effective_object_story_id]                          NVARCHAR (MAX)  NULL,
    [ad_creative_instagram_permalink_url]                            NVARCHAR (MAX)  NULL,
    [ad_creative_title]                                              NVARCHAR (MAX)  NULL,
    [account_business_id]                                            NVARCHAR (MAX)  NULL,
    [ad_creative_object_id]                                          NVARCHAR (MAX)  NULL,
    [campaign_start_time]                                            DATETIME        NULL,
    [ad_creative_template_url]                                       NVARCHAR (MAX)  NULL,
    [campaign_stop_time]                                             DATETIME        NULL,
    [ad_creative_link_url]                                           NVARCHAR (MAX)  NULL,
    [ad_creative_effective_instagram_story_id]                       BIGINT          NULL,
    [ad_creative_status]                                             NVARCHAR (MAX)  NULL,
    [ad_creative_url_tags]                                           NVARCHAR (MAX)  NULL,
    [campaign_adlabels]                                              NVARCHAR (MAX)  NULL,
    [ad_creative_image_url]                                          NVARCHAR (MAX)  NULL,
    [ad_creative_object_type]                                        NVARCHAR (MAX)  NULL,
    [ad_creative_thumbnail_url]                                      NVARCHAR (MAX)  NULL,
    [ad_status]                                                      NVARCHAR (MAX)  NULL,
    [conversion_values]                                              NVARCHAR (MAX)  NULL,
    [conversions]                                                    NUMERIC (20, 4) NULL,
    [mobile_app_purchase_roas]                                       NVARCHAR (MAX)  NULL,
    [unique_actions]                                                 NVARCHAR (MAX)  NULL,
    [video_p100_watched_actions]                                     NVARCHAR (MAX)  NULL,
    [video_p25_watched_actions]                                      NVARCHAR (MAX)  NULL,
    [video_p50_watched_actions]                                      NVARCHAR (MAX)  NULL,
    [video_p75_watched_actions]                                      NVARCHAR (MAX)  NULL,
    [video_p95_watched_actions]                                      NVARCHAR (MAX)  NULL,
    [video_play_actions]                                             NVARCHAR (MAX)  NULL,
    [website_purchase_roas]                                          NVARCHAR (MAX)  NULL,
    [actionsoffsite_conversionfb_pixel_purchase]                     NVARCHAR (MAX)  NULL,
    [unique_actionsoffsite_conversionfb_pixel_complete_registration] NVARCHAR (MAX)  NULL,
    [unique_actionsoffsite_conversionfb_pixel_purchase]              NVARCHAR (MAX)  NULL,
    [action_valuesoffsite_conversionfb_pixel_purchase]               NVARCHAR (MAX)  NULL,
    [actionslead]                                                    BIGINT          NULL,
    [actionscomplete_registration]                                   NVARCHAR (MAX)  NULL,
    [actionsoffsite_conversionfb_pixel_lead]                         BIGINT          NULL,
    [unique_actionslead]                                             BIGINT          NULL,
    [actionsoffsite_conversionfb_pixel_complete_registration]        NVARCHAR (MAX)  NULL,
    [unique_actionsomni_purchase]                                    NVARCHAR (MAX)  NULL,
    [unique_actionsomni_complete_registration]                       NVARCHAR (MAX)  NULL,
    [actionsomni_complete_registration]                              NVARCHAR (MAX)  NULL,
    [actionspurchase]                                                NVARCHAR (MAX)  NULL,
    [website_purchase_roasoffsite_conversionfb_pixel_purchase]       NVARCHAR (MAX)  NULL,
    [action_valuesomni_purchase]                                     NVARCHAR (MAX)  NULL,
    [unique_actionsoffsite_conversionfb_pixel_lead]                  BIGINT          NULL,
    [actionsomni_purchase]                                           NVARCHAR (MAX)  NULL,
    [actionsphoto_view]                                              NVARCHAR (MAX)  NULL,
    [unique_actionsphoto_view]                                       NVARCHAR (MAX)  NULL,
    [actionsoffsite_conversioncustom400761344017779]                 NVARCHAR (MAX)  NULL,
    [actionsonsite_conversionlead_grouped]                           BIGINT          NULL,
    [actionsleadgen_grouped]                                         BIGINT          NULL,
    [unique_actionsleadgen_grouped]                                  NVARCHAR (MAX)  NULL,
    [unique_actionsonsite_conversionlead_grouped]                    NVARCHAR (MAX)  NULL,
    [actionslike]                                                    NVARCHAR (MAX)  NULL,
    [unique_actionslike]                                             BIGINT          NULL,
    [conversionscontact_total]                                       NVARCHAR (MAX)  NULL,
    [unique_actionsoffsite_conversionfb_pixel_custom]                NVARCHAR (MAX)  NULL,
    [actionsoffsite_conversionfb_pixel_custom]                       NVARCHAR (MAX)  NULL,
    [conversionscontact_website]                                     NVARCHAR (MAX)  NULL
);


GO
CREATE NONCLUSTERED INDEX [ix_Nestle_FB_Ads_test_dt_filename]
    ON [dbo].[Temp_Nestle_Social_Facebook_Test]([dt_filename] ASC);

