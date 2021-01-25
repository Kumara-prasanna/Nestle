CREATE TABLE [dbo].[Nestle_Ams_S_Products_KW] (
    [dt_created]                      DATETIME        NULL,
    [dt_updated]                      DATETIME        NULL,
    [dt_filename]                     NVARCHAR (255)  NULL,
    [adgroupid]                       BIGINT          NULL,
    [adgroupname]                     NVARCHAR (100)  NULL,
    [campaignid]                      BIGINT          NULL,
    [profileid]                       BIGINT          NULL,
    [attributedsales14dsamesku]       NUMERIC (13, 4) NULL,
    [campaigntype]                    NVARCHAR (100)  NULL,
    [attributedsales14d]              NUMERIC (13, 4) NULL,
    [keywordtext]                     NVARCHAR (300)  NULL,
    [currency]                        NVARCHAR (50)   NULL,
    [attributedconversions14dsamesku] BIGINT          NULL,
    [cost]                            NUMERIC (13, 4) NULL,
    [attributedunitsordered14d]       BIGINT          NULL,
    [campaignstatus]                  NVARCHAR (50)   NULL,
    [keywordid]                       BIGINT          NULL,
    [date]                            DATE            NULL,
    [attributedconversions14d]        BIGINT          NULL,
    [matchtype]                       NVARCHAR (50)   NULL,
    [campaignname]                    NVARCHAR (400)  NULL,
    [impressions]                     BIGINT          NULL,
    [clicks]                          BIGINT          NULL,
    [targetingtype]                   NVARCHAR (100)  NULL
);


GO
CREATE NONCLUSTERED INDEX [ix_Nestle_Ams_S_Products_KW_dt_filename]
    ON [dbo].[Nestle_Ams_S_Products_KW]([dt_filename] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_AMS_S_Prod_KW]
    ON [dbo].[Nestle_Ams_S_Products_KW]([date] ASC)
    INCLUDE([campaignname]);

