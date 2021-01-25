CREATE TABLE [dbo].[Netsle_Google_Ads_KW_V2] (
    [dt_created]                DATETIME        NULL,
    [dt_updated]                DATETIME        NULL,
    [dt_filename]               NVARCHAR (255)  NULL,
    [client_customerid]         NVARCHAR (200)  NOT NULL,
    [client_customer_name]      NVARCHAR (MAX)  NULL,
    [time_zone]                 NVARCHAR (MAX)  NULL,
    [ad_groupid]                NVARCHAR (200)  NOT NULL,
    [ad_group]                  NVARCHAR (MAX)  NULL,
    [network]                   NVARCHAR (MAX)  NULL,
    [network_w_search_partners] NVARCHAR (200)  NOT NULL,
    [campaign__id]              NVARCHAR (200)  NOT NULL,
    [campaign]                  NVARCHAR (MAX)  NULL,
    [clicks]                    BIGINT          NULL,
    [conversions]               NUMERIC (20, 4) NULL,
    [cost]                      NUMERIC (20, 4) NULL,
    [keyword]                   NVARCHAR (MAX)  NULL,
    [day]                       DATE            NOT NULL,
    [devices]                   NVARCHAR (200)  NOT NULL,
    [engagements]               BIGINT          NULL,
    [customer_id]               BIGINT          NULL,
    [keywordsid]                NVARCHAR (200)  NOT NULL,
    [impressions]               BIGINT          NULL,
    [interactions]              BIGINT          NULL,
    [match_type]                NVARCHAR (MAX)  NULL,
    [label_ids]                 NVARCHAR (MAX)  NULL,
    [labels]                    VARCHAR (MAX)   NULL,
    [keyword_state]             NVARCHAR (MAX)  NULL,
    [view_rate]                 NVARCHAR (MAX)  NULL,
    [views]                     BIGINT          NULL,
    PRIMARY KEY CLUSTERED ([client_customerid] ASC, [ad_groupid] ASC, [network_w_search_partners] ASC, [campaign__id] ASC, [day] ASC, [devices] ASC, [keywordsid] ASC)
);


GO
CREATE NONCLUSTERED INDEX [ix_Netsle_Google_Ads_KW_V2_dt_filename]
    ON [dbo].[Netsle_Google_Ads_KW_V2]([dt_filename] ASC);

