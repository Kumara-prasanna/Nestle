CREATE TABLE [dbo].[Nestle_Ams_S_Brands] (
    [dt_created]                      DATETIME        NULL,
    [dt_updated]                      DATETIME        NULL,
    [dt_filename]                     NVARCHAR (255)  NULL,
    [campaigntype]                    NVARCHAR (100)  NULL,
    [campaignbudgettype]              NVARCHAR (100)  NULL,
    [adgroupname]                     NVARCHAR (400)  NULL,
    [campaignid]                      BIGINT          NULL,
    [adgroupid]                       BIGINT          NULL,
    [currency]                        NVARCHAR (50)   NULL,
    [attributedconversions14dsamesku] BIGINT          NULL,
    [keywordid]                       BIGINT          NULL,
    [keywordtext]                     NVARCHAR (250)  NULL,
    [impressions]                     BIGINT          NULL,
    [campaignstatus]                  NVARCHAR (100)  NULL,
    [campaignbudget]                  BIGINT          NULL,
    [targetingtype]                   NVARCHAR (100)  NULL,
    [matchtype]                       NVARCHAR (100)  NULL,
    [clicks]                          BIGINT          NULL,
    [profilecountrycode]              NVARCHAR (50)   NULL,
    [campaignname]                    NVARCHAR (400)  NULL,
    [attributedsales14d]              NUMERIC (13, 4) NULL,
    [attributedconversions14d]        BIGINT          NULL,
    [date]                            DATE            NULL,
    [attributedsales14dsamesku]       NUMERIC (13, 4) NULL,
    [cost]                            NUMERIC (13, 4) NULL,
    [profileid]                       BIGINT          NULL
);


GO
CREATE NONCLUSTERED INDEX [ix_Nestle_Ams_S_Brands_dt_filename]
    ON [dbo].[Nestle_Ams_S_Brands]([dt_filename] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_AMS_S_brands]
    ON [dbo].[Nestle_Ams_S_Brands]([date] ASC)
    INCLUDE([campaignname]);

