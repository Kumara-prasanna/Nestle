







CREATE VIEW [dbo].[Nestle_Search_Executive_Summary_View] 

AS

--Combining required columns from facebook & twitter data table


	SELECT	
		Campaign,
		 [Date] ,
		Impressions,
		Clicks,
		Conversions,
		Cost AS 'Spend',
		NULL AS 'Sales',
		[Search Impression Share],
		Targeting,
		FilterName,
        FilterNameUpdated,
        Brand,	
		-- column for KPI
		Branded_CPC,
		Branded_Impr_Share,
		Non_Branded_CPC,
		Non_Branded_Impr_Share,
		Competitive_CPC,
		Competitive_Impr_Share,
		[Language],
		NULL as Non_Branded_SOV,
        'Google Ads' as [Channel]
FROM    [dbo].[Nestle_Search_Google_OldNewConv_View]


--Missing columns in Facebook table - Twitter account, Tweet, Tweets Engagement

	UNION ALL

	SELECT
		Campaign,
		 [Date] ,
		Impressions,
		Clicks,
		Conversions,
		Spend,
		Sales,
		NULL AS [Search Impression Share],
		[Targeting],
		FilterName,
        FilterNameUpdated,
        Brand,	
		-- column for KPI
		NULL as Branded_CPC,
		NULL as Branded_Impr_Share,
		NULL as Non_Branded_CPC,
		NULL as Non_Branded_Impr_Share,
		NULL as Competitive_CPC,
		NULL as Competitive_Impr_Share,
		NULL as [Language],
		Non_Branded_SOV,
        'Amazon Search' as [Channel]
FROM   [dbo].[Nestle_Search_Amazon_View] 


