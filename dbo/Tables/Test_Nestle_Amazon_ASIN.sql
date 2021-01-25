CREATE TABLE [dbo].[Test_Nestle_Amazon_ASIN] (
    [ASIN]        NVARCHAR (50)  NOT NULL,
    [Campaign]    NVARCHAR (150) NOT NULL,
    [Adgroup]     NVARCHAR (50)  NULL,
    [State]       NVARCHAR (50)  NOT NULL,
    [Products]    NVARCHAR (150) NOT NULL,
    [Status]      NVARCHAR (50)  NOT NULL,
    [SKU]         NVARCHAR (50)  NOT NULL,
    [Impressions] NVARCHAR (50)  NOT NULL,
    [Clicks]      NVARCHAR (50)  NOT NULL,
    [CTR]         NVARCHAR (50)  NOT NULL,
    [Spend_CAD]   NVARCHAR (50)  NOT NULL,
    [CPC_CAD]     NVARCHAR (50)  NOT NULL,
    [Orders]      NVARCHAR (50)  NOT NULL,
    [Sales_CAD]   NVARCHAR (50)  NOT NULL,
    [ACOS]        NVARCHAR (50)  NOT NULL
);

