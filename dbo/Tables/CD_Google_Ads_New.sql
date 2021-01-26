CREATE TABLE [dbo].[CD_Google_Ads_New] (
    [dt_created]                   DATETIME        NULL,
    [dt_updated]                   DATETIME        NULL,
    [dt_filename]                  NVARCHAR (255)  NULL,
    [client_customer_id]           BIGINT          NULL,
    [client_customer_name]         NVARCHAR (MAX)  NULL,
    [network_with_search_partners] NVARCHAR (MAX)  NULL,
    [all_conv]                     NUMERIC (13, 4) NULL,
    [network]                      NVARCHAR (MAX)  NULL,
    [crossdevice_conv]             NVARCHAR (MAX)  NULL,
    [video_played_to_25]           FLOAT (53)      NULL,
    [campaign_serving_status]      NVARCHAR (MAX)  NULL,
    [clicks]                       BIGINT          NULL,
    [video_played_to_50]           FLOAT (53)      NULL,
    [campaign_state]               NVARCHAR (MAX)  NULL,
    [client_name]                  NVARCHAR (MAX)  NULL,
    [video_played_to_100]          FLOAT (53)      NULL,
    [interactions]                 BIGINT          NULL,
    [viewthrough_conv]             BIGINT          NULL,
    [budget_period]                NVARCHAR (MAX)  NULL,
    [device]                       NVARCHAR (MAX)  NULL,
    [engagements]                  BIGINT          NULL,
    [day]                          DATE            NULL,
    [interaction_rate]             FLOAT (53)      NULL,
    [account]                      NVARCHAR (MAX)  NULL,
    [video_played_to_75]           FLOAT (53)      NULL,
    [campaign_trial_type]          NVARCHAR (MAX)  NULL,
    [budget]                       NUMERIC (13, 4) NULL,
    [all_conv_value]               NUMERIC (13, 4) NULL,
    [conversions]                  NUMERIC (13, 4) NULL,
    [campaign]                     NVARCHAR (MAX)  NULL,
    [views]                        BIGINT          NULL,
    [campaign_id]                  BIGINT          NULL,
    [labels]                       NVARCHAR (MAX)  NULL,
    [customer_id]                  BIGINT          NULL,
    [currency]                     NVARCHAR (MAX)  NULL,
    [cost]                         NUMERIC (13, 4) NULL,
    [avg_cost]                     NUMERIC (13, 4) NULL,
    [total_conv_value]             NUMERIC (13, 4) NULL,
    [impressions]                  BIGINT          NULL,
    [interaction_types]            NVARCHAR (MAX)  NULL
);


GO
CREATE NONCLUSTERED INDEX [ix_CD_Google_Ads_New_dt_filename]
    ON [dbo].[CD_Google_Ads_New]([dt_filename] ASC);

