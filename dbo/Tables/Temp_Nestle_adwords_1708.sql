CREATE TABLE [dbo].[Temp_Nestle_adwords_1708] (
    [dt_created]  DATETIME       NULL,
    [dt_updated]  DATETIME       NULL,
    [dt_filename] NVARCHAR (255) NULL,
    [day]         DATE           NULL
);


GO
CREATE NONCLUSTERED INDEX [ix_Nestle_adwords_1708_dt_filename]
    ON [dbo].[Temp_Nestle_adwords_1708]([dt_filename] ASC);

