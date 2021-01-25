

CREATE VIEW [dbo].[Nestle_All_Executive_Summary_View] 

AS

WITH EXEC_VIEW AS 
(
select [Campaign], 
        Date,
        Impressions,
       Clicks,
       [Video Views - 25%],
       [Video Views - 50%],
       [Video Views - 75%],
       [Video Views - 100%],
      [Video Views] AS  [Video Views],
	   Conversions,
      Spend,
	  NULL AS Sales,
	  NULL AS [Search Impression Share],
       FilterName,
        FilterNameUpdated,
        Brand,
         [Channel]
from   [dbo].[Nestle_Prog_Executive_Summary_View]


	UNION ALL

	SELECT	
		Campaign,
		 [Date] ,
		Impressions,
		Clicks,
		NULL AS [Video Views - 25%],
       NULL AS [Video Views - 50%],
      NULL AS [Video Views - 75%],
       NULL AS [Video Views - 100%],
     NULL AS [Video Views] ,
		Conversions,
		Spend,
		Sales,
		[Search Impression Share],
		FilterName,
        FilterNameUpdated,
        Brand,	
        [Channel]
FROM    [dbo].[Nestle_Search_Executive_Summary_View]


UNION ALL

SELECT	
		Campaign,
		[Date] ,
		Impressions,
		Clicks,
		[Video Views - 25%],
       [Video Views - 50%],
       [Video Views - 75%],
       [Video Views - 100%],
        [Video Views],
		NULL AS Conversions,
		Spend,
		NULL AS Sales,
		NULL AS [Search Impression Share],
		FilterName,
        FilterNameUpdated,
        Brand,	
       [Channel]
FROM    [dbo].[Nestle_Social_Executive_Summary_View] 


)

SELECT a.*,b.[Branded_CPC], b.[Branded_Impr_Share], b.[Non_Branded_CPC], 
b.[Non_Branded_Impr_Share],b.[Competitive_CPC],	b.[Competitive_Impr_Share]
FROM  EXEC_VIEW  AS a JOIN [dbo].[Nestle_Search_GoogleAds_KPI] as b ON a.Brand = b.Brand


