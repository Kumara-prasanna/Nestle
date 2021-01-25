CREATE TABLE [dbo].[Nestle_Google_Ads_KW] (
    [dt_created]                   DATETIME        NULL,
    [dt_updated]                   DATETIME        NULL,
    [dt_filename]                  NVARCHAR (255)  NULL,
    [client_customer_id]           BIGINT          NULL,
    [client_customer_name]         NVARCHAR (400)  NULL,
    [network_with_search_partners] NVARCHAR (100)  NULL,
    [network]                      NVARCHAR (100)  NULL,
    [keyword_id]                   BIGINT          NULL,
    [clicks]                       BIGINT          NULL,
    [time_zone]                    NVARCHAR (100)  NULL,
    [interactions]                 BIGINT          NULL,
    [label_ids]                    NVARCHAR (200)  NULL,
    [device]                       NVARCHAR (150)  NULL,
    [view_rate]                    NVARCHAR (25)   NULL,
    [engagements]                  BIGINT          NULL,
    [day]                          DATE            NULL,
    [keyword]                      NVARCHAR (400)  NULL,
    [match_type]                   NVARCHAR (100)  NULL,
    [ad_group]                     NVARCHAR (MAX)  NULL,
    [conversions]                  NUMERIC (13, 4) NULL,
    [keyword_state]                NVARCHAR (50)   NULL,
    [campaign]                     NVARCHAR (400)  NULL,
    [views]                        BIGINT          NULL,
    [campaign_id]                  BIGINT          NULL,
    [labels]                       NVARCHAR (200)  NULL,
    [customer_id]                  BIGINT          NULL,
    [ad_group_id]                  BIGINT          NULL,
    [cost]                         NUMERIC (13, 4) NULL,
    [impressions]                  BIGINT          NULL
);


GO
CREATE NONCLUSTERED INDEX [ix_Nestle_Google_Ads_KW_dt_filename]
    ON [dbo].[Nestle_Google_Ads_KW]([dt_filename] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_Google_Ads_KW]
    ON [dbo].[Nestle_Google_Ads_KW]([day] ASC)
    INCLUDE([device], [campaign], [client_customer_name], [network]);

