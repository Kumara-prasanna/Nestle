﻿CREATE TABLE [dbo].[Nestle_Social_Facebook_Ads_PublisherPlatform] (
    [dt_created]                                                     DATETIME        NULL,
    [dt_updated]                                                     DATETIME        NULL,
    [dt_filename]                                                    NVARCHAR (255)  NULL,
    [ad_creative_status]                                             NVARCHAR (MAX)  NULL,
    [ad_name]                                                        NVARCHAR (MAX)  NULL,
    [platform_position]                                              NVARCHAR (MAX)  NULL,
    [account_name]                                                   NVARCHAR (MAX)  NULL,
    [campaign_adlabels]                                              NVARCHAR (MAX)  NULL,
    [ad_creative_object_url]                                         NVARCHAR (MAX)  NULL,
    [video_p75_watched_actionsvideo_view]                            BIGINT          NULL,
    [unique_actionsvideo_view]                                       BIGINT          NULL,
    [actionspost_reaction]                                           BIGINT          NULL,
    [ad_creative_call_to_action_type]                                NVARCHAR (MAX)  NULL,
    [account_id]                                                     NVARCHAR (MAX)  NULL,
    [unique_actionsoffsite_conversionfb_pixel_complete_registration] NVARCHAR (MAX)  NULL,
    [ad_creative_template_url]                                       NVARCHAR (MAX)  NULL,
    [website_purchase_roas]                                          NVARCHAR (MAX)  NULL,
    [unique_actionsonsite_conversionpost_save]                       BIGINT          NULL,
    [action_valuescomplete_registration]                             NVARCHAR (MAX)  NULL,
    [ad_creative_instagram_permalink_url]                            NVARCHAR (MAX)  NULL,
    [video_p100_watched_actionsvideo_view]                           BIGINT          NULL,
    [unique_actionsoffsite_conversion]                               BIGINT          NULL,
    [ad_creative_thumbnail_url]                                      NVARCHAR (MAX)  NULL,
    [actionspost_engagement]                                         BIGINT          NULL,
    [actionsoffsite_conversionfb_pixel_lead]                         BIGINT          NULL,
    [mobile_app_purchase_roas]                                       NVARCHAR (MAX)  NULL,
    [conversions]                                                    NUMERIC (20, 4) NULL,
    [actionslanding_page_view]                                       BIGINT          NULL,
    [date_stop]                                                      DATE            NULL,
    [publisher_platform]                                             NVARCHAR (MAX)  NULL,
    [unique_actionsomni_complete_registration]                       NVARCHAR (MAX)  NULL,
    [adset_id]                                                       BIGINT          NULL,
    [campaign_id]                                                    NVARCHAR (MAX)  NULL,
    [actionscomment]                                                 BIGINT          NULL,
    [impressions]                                                    BIGINT          NULL,
    [action_valuesomni_complete_registration]                        NVARCHAR (MAX)  NULL,
    [ad_creative_object_id]                                          NVARCHAR (MAX)  NULL,
    [ad_creative_link_url]                                           NVARCHAR (MAX)  NULL,
    [campaign_stop_time]                                             DATETIME        NULL,
    [ad_id]                                                          BIGINT          NULL,
    [actionsomni_complete_registration]                              NVARCHAR (MAX)  NULL,
    [conversion_values]                                              NVARCHAR (MAX)  NULL,
    [ad_status]                                                      NVARCHAR (MAX)  NULL,
    [ad_creative_effective_instagram_story_id]                       BIGINT          NULL,
    [unique_actionsoffsite_conversionfb_pixel_lead]                  BIGINT          NULL,
    [account_business_id]                                            NVARCHAR (MAX)  NULL,
    [ctr]                                                            NUMERIC (20, 4) NULL,
    [ad_creative_image_url]                                          NVARCHAR (MAX)  NULL,
    [action_valuesoffsite_conversionfb_pixel_complete_registration]  NVARCHAR (MAX)  NULL,
    [video_p25_watched_actionsvideo_view]                            BIGINT          NULL,
    [unique_actionslead]                                             BIGINT          NULL,
    [ad_creative_name]                                               NVARCHAR (MAX)  NULL,
    [account_business_name]                                          NVARCHAR (MAX)  NULL,
    [ad_creative_instagram_actor_id]                                 BIGINT          NULL,
    [actionscomplete_registration]                                   NVARCHAR (MAX)  NULL,
    [campaign_name]                                                  NVARCHAR (MAX)  NULL,
    [video_p25_watched_actions]                                      NVARCHAR (MAX)  NULL,
    [ad_creative_title]                                              NVARCHAR (MAX)  NULL,
    [unique_actionspost_engagement]                                  BIGINT          NULL,
    [ad_creative_effective_object_story_id]                          NVARCHAR (MAX)  NULL,
    [unique_actionspost]                                             BIGINT          NULL,
    [actionslink_click]                                              BIGINT          NULL,
    [video_play_actionsvideo_view]                                   BIGINT          NULL,
    [video_p75_watched_actions]                                      NVARCHAR (MAX)  NULL,
    [adset_adlabels]                                                 NVARCHAR (MAX)  NULL,
    [ad_creative_object_story_spec]                                  VARCHAR (MAX)   NULL,
    [actionspost]                                                    BIGINT          NULL,
    [actionsvideo_view]                                              BIGINT          NULL,
    [video_p50_watched_actions]                                      NVARCHAR (MAX)  NULL,
    [campaign_start_time]                                            DATETIME        NULL,
    [unique_actionscomment]                                          BIGINT          NULL,
    [video_p95_watched_actions]                                      NVARCHAR (MAX)  NULL,
    [unique_actionspost_reaction]                                    BIGINT          NULL,
    [ad_creative_body]                                               NVARCHAR (MAX)  NULL,
    [actionsoffsite_conversionfb_pixel_complete_registration]        NVARCHAR (MAX)  NULL,
    [actionslead]                                                    BIGINT          NULL,
    [video_play_actions]                                             NVARCHAR (MAX)  NULL,
    [ad_creative_template_url_spec]                                  NVARCHAR (MAX)  NULL,
    [adset_name]                                                     NVARCHAR (MAX)  NULL,
    [unique_actionslanding_page_view]                                BIGINT          NULL,
    [actionspage_engagement]                                         BIGINT          NULL,
    [video_p95_watched_actionsvideo_view]                            BIGINT          NULL,
    [date_start]                                                     DATE            NULL,
    [unique_actionslink_click]                                       BIGINT          NULL,
    [objective]                                                      NVARCHAR (MAX)  NULL,
    [clicks]                                                         BIGINT          NULL,
    [ad_creative_url_tags]                                           NVARCHAR (MAX)  NULL,
    [action_valuesoffsite_conversioncustom332162047584854]           NVARCHAR (MAX)  NULL,
    [video_p100_watched_actions]                                     NVARCHAR (MAX)  NULL,
    [unique_actionspage_engagement]                                  BIGINT          NULL,
    [cpm]                                                            NUMERIC (20, 4) NULL,
    [ad_creative_object_type]                                        NVARCHAR (MAX)  NULL,
    [video_p50_watched_actionsvideo_view]                            BIGINT          NULL,
    [cpc]                                                            NUMERIC (20, 4) NULL,
    [actionsoffsite_conversioncustom332162047584854]                 NVARCHAR (MAX)  NULL,
    [cpp]                                                            NUMERIC (20, 4) NULL,
    [actionsonsite_conversionpost_save]                              BIGINT          NULL,
    [spend]                                                          NUMERIC (20, 4) NULL,
    [unique_actions]                                                 NVARCHAR (MAX)  NULL,
    [actionsoffsite_conversioncustom419476745487258]                 NVARCHAR (MAX)  NULL,
    [actionsoffsite_conversioncustom273306063544870]                 NVARCHAR (MAX)  NULL,
    [actionsoffsite_conversioncustom518810585313971]                 NVARCHAR (MAX)  NULL,
    [actionsoffsite_conversioncustom416396178924954]                 NVARCHAR (MAX)  NULL,
    [actionsoffsite_conversioncustom329162507949344]                 NVARCHAR (MAX)  NULL,
    [conversionscontact_total]                                       NVARCHAR (MAX)  NULL,
    [actionsoffsite_conversionfb_pixel_custom]                       NVARCHAR (MAX)  NULL,
    [conversionscontact_website]                                     NVARCHAR (MAX)  NULL,
    [unique_actionsonsite_conversionlead_grouped]                    NVARCHAR (MAX)  NULL,
    [unique_actionsleadgen_grouped]                                  NVARCHAR (MAX)  NULL,
    [actionsleadgen_grouped]                                         BIGINT          NULL,
    [actionsonsite_conversionlead_grouped]                           BIGINT          NULL,
    [unique_actionsoffsite_conversionfb_pixel_custom]                NVARCHAR (MAX)  NULL,
    [actionsoffsite_conversioncustom551752395715858]                 NVARCHAR (MAX)  NULL,
    [actionsoffsite_conversioncustom615226755618120]                 NVARCHAR (MAX)  NULL,
    [actionslike]                                                    NVARCHAR (MAX)  NULL,
    [unique_actionslike]                                             BIGINT          NULL,
    [actionsoffsite_conversioncustom304732223727503]                 NVARCHAR (MAX)  NULL,
    [actionsoffsite_conversioncustom417241375514810]                 NVARCHAR (MAX)  NULL,
    [actionsoffsite_conversioncustom855463594797757]                 NVARCHAR (MAX)  NULL,
    [actionsoffsite_conversioncustom384001715593845]                 NVARCHAR (MAX)  NULL,
    [unique_actionsphoto_view]                                       NVARCHAR (MAX)  NULL,
    [actionsphoto_view]                                              NVARCHAR (MAX)  NULL,
    [actionsview_content]                                            NVARCHAR (MAX)  NULL,
    [unique_actionsomni_view_content]                                NVARCHAR (MAX)  NULL,
    [actionsoffsite_conversionfb_pixel_view_content]                 NVARCHAR (MAX)  NULL,
    [actionsomni_view_content]                                       NVARCHAR (MAX)  NULL,
    [action_valuesomni_view_content]                                 NVARCHAR (MAX)  NULL,
    [action_valuesoffsite_conversionfb_pixel_view_content]           NVARCHAR (MAX)  NULL,
    [unique_actionsoffsite_conversionfb_pixel_view_content]          NVARCHAR (MAX)  NULL,
    [actionsinitiate_checkout]                                       NVARCHAR (MAX)  NULL,
    [unique_actionsomni_purchase]                                    NVARCHAR (MAX)  NULL,
    [unique_actionsomni_initiated_checkout]                          NVARCHAR (MAX)  NULL,
    [unique_actionsadd_payment_info]                                 NVARCHAR (MAX)  NULL,
    [action_valuesomni_initiated_checkout]                           NVARCHAR (MAX)  NULL,
    [unique_actionsoffsite_conversionfb_pixel_initiate_checkout]     NVARCHAR (MAX)  NULL,
    [action_valuesoffsite_conversionfb_pixel_purchase]               NVARCHAR (MAX)  NULL,
    [unique_actionsoffsite_conversionfb_pixel_add_payment_info]      NVARCHAR (MAX)  NULL,
    [website_purchase_roasoffsite_conversionfb_pixel_purchase]       NVARCHAR (MAX)  NULL,
    [action_valuesoffsite_conversionfb_pixel_add_payment_info]       NVARCHAR (MAX)  NULL,
    [unique_actionsoffsite_conversionfb_pixel_purchase]              NVARCHAR (MAX)  NULL,
    [actionsomni_purchase]                                           NVARCHAR (MAX)  NULL,
    [actionsadd_payment_info]                                        NVARCHAR (MAX)  NULL,
    [action_valuesoffsite_conversionfb_pixel_initiate_checkout]      NVARCHAR (MAX)  NULL,
    [actionsomni_initiated_checkout]                                 NVARCHAR (MAX)  NULL,
    [actionsoffsite_conversionfb_pixel_purchase]                     NVARCHAR (MAX)  NULL,
    [actionspurchase]                                                NVARCHAR (MAX)  NULL,
    [actionsoffsite_conversionfb_pixel_initiate_checkout]            NVARCHAR (MAX)  NULL,
    [action_valuesomni_purchase]                                     NVARCHAR (MAX)  NULL,
    [actionsoffsite_conversionfb_pixel_add_payment_info]             NVARCHAR (MAX)  NULL,
    [action_valuesadd_payment_info]                                  NVARCHAR (MAX)  NULL,
    [action_valuesinitiate_checkout]                                 NVARCHAR (MAX)  NULL,
    [actionsoffsite_conversioncustom207311907288356]                 BIGINT          NULL,
    [actionsoffsite_conversioncustom1352096411665352]                BIGINT          NULL,
    [actionsoffsite_conversioncustom2583422365270798]                BIGINT          NULL,
    [actionsoffsite_conversioncustom603513806898878]                 BIGINT          NULL,
    [actionsoffsite_conversioncustom369416124034643]                 NVARCHAR (MAX)  NULL,
    [actionsinteractive_component_tap]                               NVARCHAR (MAX)  NULL,
    [unique_actionsinteractive_component_tap]                        NVARCHAR (MAX)  NULL
);

