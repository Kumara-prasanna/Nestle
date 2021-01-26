CREATE TABLE [dbo].[CD_AMN_S_Pro_ProAds] (
    [dt_created]                      DATETIME        NULL,
    [dt_updated]                      DATETIME        NULL,
    [dt_filename]                     NVARCHAR (255)  NULL,
    [adgroupid]                       BIGINT          NULL,
    [campaignbudgettype]              NVARCHAR (MAX)  NULL,
    [campaignid]                      BIGINT          NULL,
    [campaigntype]                    NVARCHAR (MAX)  NULL,
    [currency]                        NVARCHAR (MAX)  NULL,
    [attributedconversions14dsamesku] BIGINT          NULL,
    [cost]                            NUMERIC (13, 4) NULL,
    [impressions]                     BIGINT          NULL,
    [sku]                             NVARCHAR (MAX)  NULL,
    [asin]                            NVARCHAR (MAX)  NULL,
    [campaignstatus]                  NVARCHAR (MAX)  NULL,
    [profilebrandname]                NVARCHAR (MAX)  NULL,
    [attributedunitsordered14d]       BIGINT          NULL,
    [targetingtype]                   NVARCHAR (MAX)  NULL,
    [clicks]                          BIGINT          NULL,
    [campaignname]                    NVARCHAR (MAX)  NULL,
    [attributedsales14d]              NUMERIC (13, 4) NULL,
    [attributedconversions14d]        BIGINT          NULL,
    [date]                            DATE            NULL,
    [attributedsales14dsamesku]       NUMERIC (13, 4) NULL,
    [profileid]                       BIGINT          NULL
);


GO
CREATE NONCLUSTERED INDEX [ix_CD_AMN_S_Pro_ProAds_dt_filename]
    ON [dbo].[CD_AMN_S_Pro_ProAds]([dt_filename] ASC);

