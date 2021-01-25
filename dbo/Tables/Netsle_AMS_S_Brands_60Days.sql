CREATE TABLE [dbo].[Netsle_AMS_S_Brands_60Days] (
    [dt_created]                      DATETIME        NULL,
    [dt_updated]                      DATETIME        NULL,
    [dt_filename]                     NVARCHAR (255)  NULL,
    [clicks]                          BIGINT          NULL,
    [campaignid]                      BIGINT          NULL,
    [campaignstatus]                  NVARCHAR (MAX)  NULL,
    [attributedsales14d]              NUMERIC (20, 4) NULL,
    [cost]                            NUMERIC (20, 4) NULL,
    [attributedconversions14d]        BIGINT          NULL,
    [impressions]                     BIGINT          NULL,
    [date]                            DATE            NULL,
    [matchtype]                       NVARCHAR (MAX)  NULL,
    [attributedconversions14dsamesku] BIGINT          NULL,
    [campaigntype]                    NVARCHAR (MAX)  NULL,
    [campaignbudgettype]              NVARCHAR (MAX)  NULL,
    [profilebrandname]                NVARCHAR (MAX)  NULL,
    [adgroupid]                       BIGINT          NULL,
    [profileid]                       BIGINT          NULL,
    [attributedsales14dsamesku]       NUMERIC (20, 4) NULL,
    [keywordid]                       BIGINT          NULL,
    [keywordtext]                     NVARCHAR (MAX)  NULL,
    [adgroupname]                     NVARCHAR (MAX)  NULL,
    [currency]                        NVARCHAR (MAX)  NULL,
    [campaignname]                    NVARCHAR (MAX)  NULL,
    [campaignbudget]                  BIGINT          NULL,
    [profilecountrycode]              NVARCHAR (MAX)  NULL
);


GO
CREATE NONCLUSTERED INDEX [ix_Netsle_AMS_S_Brands_60Days_dt_filename]
    ON [dbo].[Netsle_AMS_S_Brands_60Days]([dt_filename] ASC);

