CREATE TABLE [dbo].[Nestle_Social_Twitter_KPI] (
    [Brand] NVARCHAR (50) NOT NULL,
    [CPM]   FLOAT (53)    NOT NULL,
    CONSTRAINT [PK_Twitter KPI] PRIMARY KEY CLUSTERED ([Brand] ASC)
);

