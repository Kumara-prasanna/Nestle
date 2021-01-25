CREATE TABLE [dbo].[Nestle_Search_Amazon_ASIN_Mapping] (
    [Brand]       VARCHAR (50)  NULL,
    [ASIN]        VARCHAR (50)  NULL,
    [Campaign]    VARCHAR (200) NULL,
    [Adgroup]     VARCHAR (50)  NULL,
    [State]       VARCHAR (50)  NULL,
    [Products]    VARCHAR (200) NULL,
    [Status]      VARCHAR (50)  NULL,
    [SKU]         VARCHAR (50)  NULL,
    [Impressions] NUMERIC (18)  NULL,
    [Clicks]      VARCHAR (50)  NULL,
    [CTR]         REAL          NULL,
    [Spend(CAD)]  REAL          NULL,
    [CPC(CAD)]    REAL          NULL,
    [Orders]      NUMERIC (18)  NULL,
    [Sales(CAD)]  REAL          NULL,
    [ACOS]        NUMERIC (18)  NULL
);


GO
CREATE NONCLUSTERED INDEX [idx_ASIN_Mapping]
    ON [dbo].[Nestle_Search_Amazon_ASIN_Mapping]([Brand] ASC, [ASIN] ASC, [Campaign] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_products]
    ON [dbo].[Nestle_Search_Amazon_ASIN_Mapping]([Products] ASC)
    INCLUDE([ASIN]);

