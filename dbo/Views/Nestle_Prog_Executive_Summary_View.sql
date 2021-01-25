
CREATE VIEW [dbo].[Nestle_Prog_Executive_Summary_View] 

AS

--Combining required columns from facebook & twitter data table
 with dcm as (
    SELECT    DISTINCT [Placement ID]
    FROM    [dbo].[Nestle_Prog_GCM_Spend_OldConv_View]
), 

dv360 AS (
    SELECT    DISTINCT CM_Placement_ID
    FROM    [dbo].[Nestle_Prog_DV360]
), 


matching AS    (
    SELECT    [Placement ID]
    FROM    dcm g INNER JOIN
            dv360 d ON g.[Placement ID] = d .CM_Placement_ID
)


	SELECT	
		d.Campaign AS 'Campaign',
		 [Date] AS 'Date',
		d.Impressions AS 'Impressions',
		d.clicks AS 'Clicks',
		d.Conversions AS 'Conversions',
		d.[Video Views - 25%] AS 'Video Views - 25%',
		d.[Video Views - 50%] AS 'Video Views - 50%',
		d.[Video Views - 75%] AS 'Video Views - 75%',
		d.[Video Views - 100%] AS 'Video Views - 100%',
		[Video Views] AS 'Video Views',
		d.Spend AS 'Spend',
		FilterName,
        FilterNameUpdated,
        Brand,	
        'GCM' as [Channel]
FROM    [Nestle_Prog_GCM_Spend_OldConv_View] d-- ON m.placement_id != d.[Placement ID]
where    not exists (select [Placement ID] from matching m where m.[Placement ID] = d.[Placement ID]) 
AND (d.Campaign like '2020%' and d.Campaign not like '%_SOCIAL')
	

--Missing columns in Facebook table - Twitter account, Tweet, Tweets Engagement
/* CHECK NEW GCM *************
	UNION ALL


	SELECT	
		d.Campaign AS 'Campaign',
		 [Date] AS 'Date',
		d.Impressions AS 'Impressions',
		d.clicks AS 'Clicks',
		d.Conversions AS 'Conversions',
		d.[Video Views - 25%] AS 'Video Views - 25%',
		d.[Video Views - 50%] AS 'Video Views - 50%',
		d.[Video Views - 75%] AS 'Video Views - 75%',
		d.[Video Views - 100%] AS 'Video Views - 100%',
		[Video Views] AS 'Video Views',
		'NA' AS 'Spend',
		FilterName,
        FilterNameUpdated,
        Brand,	
        'GCM' as [Channel]
FROM    [Nestle_Prog_GCM_Spend_NewConv_View] d-- ON m.placement_id != d.[Placement ID]
where    not exists (select [Placement ID] from matching m where m.[Placement ID] = d.[Placement ID]) 
AND (d.Campaign like '2020%' and d.Campaign not like '%_SOCIAL')
*/
UNION ALL
(
select Campaign,  
        Date,
        Impressions,
        Clicks,
        Conversions,
        [Video Views - 25%],
        [Video Views - 50%],
        [Video Views - 75%],
        [Video Views - 100%],
        [True View Views] AS 'Video Views',
        Cost AS 'Spend',
		 FilterName,
        FilterNameUpdated,
        Brand,	
        'DV360' as [Channel]
from    [dbo].[Nestle_Prog_DV360_View]
WHERE (Campaign like '2020%' and Campaign not like '%_SOCIAL')
)

UNION ALL
(

select  Campaign,
        Date,
        Impressions,
        Clicks,
        NULL AS Conversions,
        NULL AS[Video Views - 25%],
        NULL AS[Video Views - 50%],
        NULL AS[Video Views - 75%],
        NULL AS[Video Views - 100%],
        NULL AS [Video Views],     
        Cost AS 'Spend',
		 FilterName,
        FilterNameUpdated,
        Brand,		
        'Amazon DSP' as [Channel]
from   [dbo].[Nestle_Prog_AmazonDSP_View]
where (Campaign like '2020%' and Campaign not like '%_SOCIAL')
)
	
UNION ALL



select [Campaign], 
        Date,
        Impressions,
       Clicks,
       [All Conversions] AS Conversions,
       [Video Views - 25%],
       [Video Views - 50%],
       [Video Views - 75%],
       [Video Views - 100%],
      [Video Views] AS  [Video Views],
      Cost AS 'Spend',
      FilterName,
        FilterNameUpdated,
        Brand,
        'Google Ads' as [Channel]
from    [dbo].[Nestle_Prog_GoogleAds_YouTube_View] as e
-- Removing to keep only 2020 campaigns and exclude SOCIAL campaigns from Prog View
where (Campaign like '2020%' and Campaign not like '%_SOCIAL') 


