CREATE TABLE [dbo].[Nestle_Search_Amazon_Products_ASINS] (
    [dt_created]                        DATETIME       NULL,
    [dt_updated]                        DATETIME       NULL,
    [dt_filename]                       NVARCHAR (255) NULL,
    [sku]                               NVARCHAR (MAX) NULL,
    [asin]                              NVARCHAR (MAX) NULL,
    [adgroupid]                         BIGINT         NULL,
    [adgroupname]                       NVARCHAR (MAX) NULL,
    [profilebrandname]                  NVARCHAR (MAX) NULL,
    [campaignid]                        BIGINT         NULL,
    [keywordtext]                       NVARCHAR (MAX) NULL,
    [targetingtype]                     NVARCHAR (MAX) NULL,
    [otherasin]                         NVARCHAR (MAX) NULL,
    [keywordid]                         BIGINT         NULL,
    [attributedunitsordered14dothersku] BIGINT         NULL,
    [campaignname]                      NVARCHAR (MAX) NULL,
    [date]                              DATE           NULL,
    [profileid]                         BIGINT         NULL,
    [matchtype]                         NVARCHAR (MAX) NULL,
    [attributedsales14dothersku]        FLOAT (53)     NULL
);

