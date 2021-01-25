﻿CREATE TABLE [dbo].[Nestle_Amazon_RT] (
    [Ad Group Name]           NVARCHAR (400)  NULL,
    [Conversions]             BIGINT          NULL,
    [Conversions Same SKU]    BIGINT          NULL,
    [Sales]                   NUMERIC (13, 4) NULL,
    [Sales Same SKU]          NUMERIC (13, 4) NULL,
    [Campaign]                NVARCHAR (400)  NULL,
    [Campaign Status]         NVARCHAR (100)  NULL,
    [Campaign Type]           NVARCHAR (100)  NULL,
    [Clicks]                  BIGINT          NULL,
    [Spend]                   NUMERIC (13, 4) NULL,
    [Date]                    DATE            NULL,
    [Impressions]             BIGINT          NULL,
    [Keyword]                 NVARCHAR (300)  NULL,
    [Match Type]              NVARCHAR (100)  NULL,
    [Targeting Data Source]   NVARCHAR (100)  NULL,
    [ASIN]                    NVARCHAR (50)   NULL,
    [Units Ordered]           BIGINT          NULL,
    [Sales Other SKU]         INT             NULL,
    [Units Ordered Other SKU] INT             NULL,
    [Other ASIN]              INT             NULL,
    [Profile Brand Name]      NVARCHAR (100)  NULL,
    [SKU]                     NVARCHAR (50)   NULL,
    [Product]                 VARCHAR (200)   NULL,
    [ASIN_Product]            VARCHAR (200)   NULL,
    [Campaign_Year]           VARCHAR (6)     NULL,
    [table]                   VARCHAR (30)    NULL,
    [FilterName]              VARCHAR (38)    NULL,
    [Ad Type]                 VARCHAR (18)    NULL,
    [Targeting]               VARCHAR (11)    NULL,
    [FilterNameUpdated]       VARCHAR (43)    NULL,
    [Brand]                   NVARCHAR (100)  NULL,
    [Non_Branded_SOV]         NVARCHAR (50)   NULL
);
