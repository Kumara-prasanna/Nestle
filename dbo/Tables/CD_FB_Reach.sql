CREATE TABLE [dbo].[CD_FB_Reach] (
    [dt_created]          DATETIME        NULL,
    [dt_updated]          DATETIME        NULL,
    [dt_filename]         NVARCHAR (255)  NULL,
    [date_stop]           DATE            NULL,
    [date_start]          DATE            NULL,
    [reach]               BIGINT          NULL,
    [campaign_id]         BIGINT          NULL,
    [frequency]           NUMERIC (13, 4) NULL,
    [campaign_name]       NVARCHAR (MAX)  NULL,
    [campaign_stop_time]  DATETIME        NULL,
    [campaign_start_time] DATETIME        NULL
);


GO
CREATE NONCLUSTERED INDEX [ix_CD_FB_Reach_dt_filename]
    ON [dbo].[CD_FB_Reach]([dt_filename] ASC);

