CREATE TABLE [dbo].[Nestle_Google_Ads_V21] (
    [dt_created]                DATETIME        NULL,
    [dt_updated]                DATETIME        NULL,
    [dt_filename]               NVARCHAR (255)  NULL,
    [client_customerid]         NVARCHAR (200)  NULL,
    [client_customer_name]      NVARCHAR (MAX)  NULL,
    [currency]                  NVARCHAR (MAX)  NULL,
    [account]                   NVARCHAR (MAX)  NULL,
    [network]                   NVARCHAR (MAX)  NULL,
    [network_w_search_partners] NVARCHAR (200)  NOT NULL,
    [all_conv]                  NUMERIC (20, 4) NULL,
    [all_conv_value]            NUMERIC (20, 4) NULL,
    [budget]                    NUMERIC (20, 4) NULL,
    [campaign__id]              NVARCHAR (200)  NOT NULL,
    [campaign]                  NVARCHAR (MAX)  NULL,
    [clicks]                    BIGINT          NULL,
    [conversions]               NUMERIC (20, 4) NULL,
    [total_conv_value]          NUMERIC (20, 4) NULL,
    [cost]                      NUMERIC (20, 4) NULL,
    [crossdevice_conv]          NVARCHAR (MAX)  NULL,
    [client_name]               NVARCHAR (MAX)  NULL,
    [day]                       DATE            NOT NULL,
    [devices]                   NVARCHAR (200)  NOT NULL,
    [end_date]                  NVARCHAR (MAX)  NULL,
    [engagement_rate]           FLOAT (53)      NULL,
    [engagements]               BIGINT          NULL,
    [customer_id]               BIGINT          NULL,
    [impressions]               BIGINT          NULL,
    [interactions]              BIGINT          NULL,
    [invalid_clicks]            BIGINT          NULL,
    [labels]                    VARCHAR (MAX)   NULL,
    [budget_period]             NVARCHAR (MAX)  NULL,
    [search_impr_share]         NVARCHAR (MAX)  NULL,
    [start_date]                NVARCHAR (MAX)  NULL,
    [video_played_to_100]       FLOAT (53)      NULL,
    [video_played_to_25]        FLOAT (53)      NULL,
    [video_played_to_50]        FLOAT (53)      NULL,
    [video_played_to_75]        FLOAT (53)      NULL,
    [view_rate]                 NVARCHAR (MAX)  NULL,
    [views]                     BIGINT          NULL,
    [viewthrough_conv]          BIGINT          NULL,
    PRIMARY KEY CLUSTERED ([network_w_search_partners] ASC, [campaign__id] ASC, [day] ASC, [devices] ASC)
);


GO
CREATE NONCLUSTERED INDEX [ix_Nestle_Google_Ads_V21_dt_filename]
    ON [dbo].[Nestle_Google_Ads_V21]([dt_filename] ASC);

