CREATE TABLE [dbo].[Nestle_Programmatic_Executive_Summary_RT] (
    [Campaign]           NVARCHAR (450)  NULL,
    [Date]               DATETIME        NULL,
    [Impressions]        BIGINT          NULL,
    [Clicks]             NUMERIC (23, 4) NULL,
    [Conversions]        NUMERIC (38, 4) NULL,
    [Video Views - 25%]  BIGINT          NULL,
    [Video Views - 50%]  FLOAT (53)      NULL,
    [Video Views - 75%]  BIGINT          NULL,
    [Video Views - 100%] BIGINT          NULL,
    [Video Views]        BIGINT          NULL,
    [Spend]              REAL            NULL,
    [FilterName]         VARCHAR (38)    NULL,
    [FilterNameUpdated]  VARCHAR (43)    NULL,
    [Brand]              NVARCHAR (100)  NULL,
    [Channel]            VARCHAR (10)    NOT NULL
);

