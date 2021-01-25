﻿CREATE TABLE [dbo].[Nestle_Google_Adss] (
    [Account]                      NVARCHAR (400)  NULL,
    [All Conversions]              NUMERIC (13, 4) NULL,
    [All Conversions Value]        NUMERIC (13, 4) NULL,
    [Campaign]                     NVARCHAR (450)  NULL,
    [Clicks]                       BIGINT          NULL,
    [Client Customer Name]         NVARCHAR (400)  NULL,
    [Conversions]                  NUMERIC (13, 4) NULL,
    [Cost]                         NUMERIC (13, 4) NULL,
    [Date]                         DATE            NULL,
    [Device]                       NVARCHAR (400)  NULL,
    [Impressions]                  BIGINT          NULL,
    [Labels]                       VARCHAR (900)   NULL,
    [Network]                      NVARCHAR (100)  NULL,
    [Network With Search Partners] NVARCHAR (400)  NULL,
    [Ad Group]                     INT             NULL,
    [Keyword]                      INT             NULL,
    [Keyword State]                INT             NULL,
    [Targeting]                    VARCHAR (11)    NOT NULL,
    [Match Type]                   VARCHAR (7)     NOT NULL,
    [Search Impression Share]      FLOAT (53)      NULL,
    [Campaign_Year]                VARCHAR (6)     NOT NULL,
    [table]                        VARCHAR (17)    NOT NULL
);

