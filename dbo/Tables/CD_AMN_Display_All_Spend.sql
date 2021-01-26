CREATE TABLE [dbo].[CD_AMN_Display_All_Spend] (
    [dt_created]    DATETIME       NULL,
    [dt_updated]    DATETIME       NULL,
    [dt_filename]   NVARCHAR (255) NULL,
    [date]          DATE           NULL,
    [advertiser_id] BIGINT         NULL,
    [advertiser]    NVARCHAR (MAX) NULL,
    [order_id]      BIGINT         NULL,
    [order]         NVARCHAR (MAX) NULL,
    [line_item_id]  BIGINT         NULL,
    [line_item]     NVARCHAR (MAX) NULL,
    [creative_id]   NVARCHAR (MAX) NULL,
    [creative]      NVARCHAR (MAX) NULL,
    [spend]         FLOAT (53)     NULL
);


GO
CREATE NONCLUSTERED INDEX [ix_CD_AMN_Display_All_Spend_dt_filename]
    ON [dbo].[CD_AMN_Display_All_Spend]([dt_filename] ASC);

