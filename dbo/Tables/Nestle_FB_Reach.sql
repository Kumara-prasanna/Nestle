CREATE TABLE [dbo].[Nestle_FB_Reach] (
    [dt_created]    DATETIME        NULL,
    [dt_updated]    DATETIME        NULL,
    [dt_filename]   NVARCHAR (255)  NULL,
    [adset_id]      BIGINT          NULL,
    [account_id]    BIGINT          NULL,
    [reach]         BIGINT          NULL,
    [campaign_id]   BIGINT          NULL,
    [frequency]     NUMERIC (13, 4) NULL,
    [campaign_name] NVARCHAR (MAX)  NULL,
    [account_name]  NVARCHAR (MAX)  NULL,
    [adset_name]    NVARCHAR (MAX)  NULL,
    [date_stop]     DATE            NULL,
    [date_start]    DATE            NULL
);


GO
CREATE NONCLUSTERED INDEX [ix_Nestle_FB_Reach_dt_filename]
    ON [dbo].[Nestle_FB_Reach]([dt_filename] ASC);

