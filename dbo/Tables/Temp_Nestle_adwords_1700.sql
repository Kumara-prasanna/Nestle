CREATE TABLE [dbo].[Temp_Nestle_adwords_1700] (
    [dt_created]  DATETIME       NULL,
    [dt_updated]  DATETIME       NULL,
    [dt_filename] NVARCHAR (255) NULL,
    [day]         DATE           NULL
);


GO
CREATE NONCLUSTERED INDEX [ix_Nestle_adwords_1700_dt_filename]
    ON [dbo].[Temp_Nestle_adwords_1700]([dt_filename] ASC);

