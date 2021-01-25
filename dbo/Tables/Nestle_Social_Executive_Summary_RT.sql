CREATE TABLE [dbo].[Nestle_Social_Executive_Summary_RT] (
    [Date]               DATE            NULL,
    [Channel]            VARCHAR (18)    NULL,
    [Account]            NVARCHAR (MAX)  NULL,
    [Campaign]           NVARCHAR (MAX)  NULL,
    [Objective]          NVARCHAR (MAX)  NULL,
    [Gender]             NVARCHAR (MAX)  NULL,
    [Age]                NVARCHAR (MAX)  NULL,
    [Spend]              NUMERIC (13, 4) NULL,
    [Impressions]        BIGINT          NULL,
    [Clicks]             BIGINT          NULL,
    [Video Views]        BIGINT          NULL,
    [Video Views - 25%]  BIGINT          NULL,
    [Video Views - 50%]  BIGINT          NULL,
    [Video Views - 75%]  BIGINT          NULL,
    [Video Views - 100%] BIGINT          NULL,
    [FilterName]         VARCHAR (38)    NULL,
    [Language]           VARCHAR (7)     NULL,
    [FilterNameUpdated]  VARCHAR (43)    NULL,
    [Brand]              NVARCHAR (100)  NULL
);

