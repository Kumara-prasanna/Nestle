CREATE TABLE [dbo].[CD_AMN_S_Brands_Ads] (
    [dt_created]                      DATETIME        NULL,
    [dt_updated]                      DATETIME        NULL,
    [dt_filename]                     NVARCHAR (255)  NULL,
    [adgroupid]                       BIGINT          NULL,
    [campaignid]                      BIGINT          NULL,
    [campaigntype]                    NVARCHAR (MAX)  NULL,
    [attributedsales14d]              NUMERIC (13, 4) NULL,
    [currency]                        NVARCHAR (MAX)  NULL,
    [cost]                            NUMERIC (13, 4) NULL,
    [campaignstatus]                  NVARCHAR (MAX)  NULL,
    [date]                            DATE            NULL,
    [attributedconversions14d]        BIGINT          NULL,
    [campaignname]                    NVARCHAR (MAX)  NULL,
    [impressions]                     BIGINT          NULL,
    [clicks]                          BIGINT          NULL,
    [attributedsales14dsamesku]       NUMERIC (13, 4) NULL,
    [attributedconversions14dsamesku] BIGINT          NULL,
    [keywordid]                       BIGINT          NULL,
    [keywordtext]                     NVARCHAR (MAX)  NULL,
    [matchtype]                       NVARCHAR (MAX)  NULL,
    [targetingtype]                   NVARCHAR (MAX)  NULL,
    [profileid]                       BIGINT          NULL
);


GO
CREATE NONCLUSTERED INDEX [ix_CD_AMN_Ads_dt_filename]
    ON [dbo].[CD_AMN_S_Brands_Ads]([dt_filename] ASC);

