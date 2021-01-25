CREATE TABLE [dbo].[Nestle_GCM_Spend] (
    [Placement]           VARCHAR (175) NULL,
    [Date]                DATETIME      NULL,
    [Flight_Capped_Spend] REAL          NULL,
    [Flight_Budget]       REAL          NULL
);


GO
CREATE NONCLUSTERED INDEX [idx_date]
    ON [dbo].[Nestle_GCM_Spend]([Date] ASC)
    INCLUDE([Placement]);

