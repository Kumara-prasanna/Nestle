CREATE TABLE [dbo].[Nestle_Ams_S_Products_Prod_Ads] (
    [dt_created]                      DATETIME        NULL,
    [dt_updated]                      DATETIME        NULL,
    [dt_filename]                     NVARCHAR (255)  NULL,
    [adgroupid]                       BIGINT          NULL,
    [campaignbudgettype]              NVARCHAR (100)  NULL,
    [adgroupname]                     NVARCHAR (100)  NULL,
    [campaignid]                      BIGINT          NULL,
    [campaigntype]                    NVARCHAR (50)   NULL,
    [currency]                        NVARCHAR (50)   NULL,
    [attributedconversions14dsamesku] BIGINT          NULL,
    [cost]                            NUMERIC (13, 4) NULL,
    [impressions]                     BIGINT          NULL,
    [sku]                             NVARCHAR (50)   NULL,
    [asin]                            NVARCHAR (50)   NULL,
    [campaignstatus]                  NVARCHAR (50)   NULL,
    [profilebrandname]                NVARCHAR (100)  NULL,
    [attributedunitsordered14d]       BIGINT          NULL,
    [campaignbudget]                  BIGINT          NULL,
    [targetingtype]                   NVARCHAR (50)   NULL,
    [clicks]                          BIGINT          NULL,
    [campaignname]                    NVARCHAR (400)  NULL,
    [attributedsales14d]              NUMERIC (13, 4) NULL,
    [attributedconversions14d]        BIGINT          NULL,
    [date]                            DATE            NULL,
    [attributedsales14dsamesku]       NUMERIC (13, 4) NULL,
    [profileid]                       BIGINT          NULL
);


GO
CREATE NONCLUSTERED INDEX [ix_Nestle_Ams_S_Products_Prod_Ads_dt_filename]
    ON [dbo].[Nestle_Ams_S_Products_Prod_Ads]([dt_filename] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_new_prodads]
    ON [dbo].[Nestle_Ams_S_Products_Prod_Ads]([asin] ASC)
    INCLUDE([adgroupname], [campaigntype], [sku], [campaignstatus], [profilebrandname], [targetingtype], [campaignname], [date]);

