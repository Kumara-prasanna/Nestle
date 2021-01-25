CREATE TABLE [dbo].[Nestle_Facebook_Reach_RT] (
    [Campaign Start Date] DATE            NULL,
    [Campaign Stop Date]  DATE            NULL,
    [Account]             NVARCHAR (MAX)  NULL,
    [Adset Name]          NVARCHAR (MAX)  NULL,
    [Campaign]            NVARCHAR (MAX)  NULL,
    [Reach]               BIGINT          NULL,
    [Frequency]           NUMERIC (13, 4) NULL,
    [FilterName]          VARCHAR (38)    NULL,
    [Language]            VARCHAR (7)     NULL,
    [FilterNameUpdated]   VARCHAR (43)    NULL,
    [Brand]               NVARCHAR (100)  NULL
);

