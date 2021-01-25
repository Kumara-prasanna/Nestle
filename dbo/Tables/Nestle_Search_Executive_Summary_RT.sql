CREATE TABLE [dbo].[Nestle_Search_Executive_Summary_RT] (
    [Campaign]                NVARCHAR (450)  NULL,
    [Date]                    DATE            NULL,
    [Impressions]             BIGINT          NULL,
    [Clicks]                  BIGINT          NULL,
    [Conversions]             NUMERIC (23, 4) NULL,
    [Spend]                   NUMERIC (13, 4) NULL,
    [Sales]                   NUMERIC (13, 4) NULL,
    [Search Impression Share] FLOAT (53)      NULL,
    [Targeting]               VARCHAR (11)    NULL,
    [FilterName]              VARCHAR (38)    NULL,
    [FilterNameUpdated]       VARCHAR (43)    NULL,
    [Brand]                   NVARCHAR (100)  NULL,
    [Branded_CPC]             NVARCHAR (50)   NULL,
    [Branded_Impr_Share]      NVARCHAR (50)   NULL,
    [Non_Branded_CPC]         NVARCHAR (50)   NULL,
    [Non_Branded_Impr_Share]  NVARCHAR (50)   NULL,
    [Competitive_CPC]         NVARCHAR (50)   NULL,
    [Competitive_Impr_Share]  NVARCHAR (50)   NULL,
    [Language]                VARCHAR (8000)  NULL,
    [Non_Branded_SOV]         NVARCHAR (50)   NULL,
    [Channel]                 VARCHAR (13)    NOT NULL
);

