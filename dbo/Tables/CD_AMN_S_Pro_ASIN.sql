CREATE TABLE [dbo].[CD_AMN_S_Pro_ASIN] (
    [dt_created]                        DATETIME        NULL,
    [dt_updated]                        DATETIME        NULL,
    [dt_filename]                       NVARCHAR (255)  NULL,
    [sku]                               NVARCHAR (MAX)  NULL,
    [asin]                              NVARCHAR (MAX)  NULL,
    [adgroupid]                         BIGINT          NULL,
    [adgroupname]                       NVARCHAR (MAX)  NULL,
    [profilebrandname]                  NVARCHAR (MAX)  NULL,
    [campaignid]                        BIGINT          NULL,
    [keywordtext]                       NVARCHAR (MAX)  NULL,
    [targetingtype]                     NVARCHAR (MAX)  NULL,
    [otherasin]                         NVARCHAR (MAX)  NULL,
    [keywordid]                         BIGINT          NULL,
    [attributedunitsordered14dothersku] BIGINT          NULL,
    [campaignname]                      NVARCHAR (MAX)  NULL,
    [date]                              DATE            NULL,
    [matchtype]                         NVARCHAR (MAX)  NULL,
    [attributedsales14dothersku]        NUMERIC (13, 4) NULL
);


GO
CREATE NONCLUSTERED INDEX [ix_CD_AMN_S_Pro_ASIN_dt_filename]
    ON [dbo].[CD_AMN_S_Pro_ASIN]([dt_filename] ASC);

