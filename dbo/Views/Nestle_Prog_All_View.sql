
CREATE VIEW [dbo].[Nestle_Prog_All_View]
AS

    with dcm as (
    SELECT    DISTINCT [Placement ID]
    FROM    [dbo].[Nestle_Prog_GCM_Spend_OldNewConv_View]
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
		d.Campaign,
        'N/A' as Creative,
        d.Date,
        NULL as 'Ad Type',
        NULL as 'Creative Attribution',
        d.Impressions,
        d.Clicks,
        d.Conversions,
        NULL as 'Post Click Conversions',
        NULL as Engagements,
        d.[Video Views - 25%],
        d.[Video Views - 50%],
        d.[Video Views - 75%],
        d.[Video Views - 100%],
        NULL as 'True View Views',
        NULL as 'True View View Rate',
        NULL as 'Companion Clicks Video',
        NULL as 'Companion Views Video',
        d.Spend as 'Spend',
        d.Revenue,
        d.FilterName,
        d.Language,
        d.[Search Partner],
        d.FilterNameUpdated,
        d.Brand,
        d.Placement,
        d.[Placement ID],
        d.Interactions,
        d.[Video Views],
        d.[Video Plays],
        d.Budget,
		NULL AS [Mashup Clicks],
		NULL AS [Mashup Clicks CPA],
		NULL AS [Detailed Page Views],
		NULL AS [Detailed Page View Rate],
		NULL AS [Add To List],
		NULL AS [Units Sold],
		NULL AS [Sales],
		NULL AS [New To Brand Purchases],
		NULL AS [New To Brand Product Sales],
		NULL AS [New To Brand Units Sold],
		Campaign_Year,
		[Ad_Type_Category] AS 'Ad Type Category',
-- Convention --
CASE
	WHEN (Campaign like 'T%' or Campaign like 'L%') THEN 'New'
	ELSE 'Old'
END AS 'Convention',
-- Demarcating campaigns based on names --
CASE
	WHEN Campaign like '2020\_%' escape '\'  THEN Campaign
	WHEN (Campaign like 'T%' or Campaign like 'L%')  THEN Campaign
	ELSE CONCAT('X - ',Campaign)
	END AS 'Campaign2'
       , 'GCM' as [Platform],
[Decoded Campaign Objective], [Decoded Campaign Type], [Decoded Master Brand], [Decoded Range Brand], [Decoded Segment] 

FROM  [dbo].[Nestle_Prog_GCM_Spend_OldNewConv_View]   d-- ON m.placement_id != d.[Placement ID]
where    
--not exists (select [Placement ID] from matching m where m.[Placement ID] = d.[Placement ID]) 
--AND 
(d.Campaign not like '%_SOCIAL' and d.Campaign not like '%DO NOT USE%')

UNION ALL


select 
		Campaign,
        Creative,
        Date,
        [Ad Type],
        [Creative Attribute],
        Impressions,
        Clicks,
        Conversions,
        [Post Click Conversions],
        Engagements,
        [Video Views - 25%],
        [Video Views - 50%],
        [Video Views - 75%],
        [Video Views - 100%],
        [True View Views],
        [True View View Rate],
        [Companion Clicks Video],
        [Companion Views Video],
        Cost AS 'Spend',
        Revenue,
        FilterName,
        Language,
        [Search Partner],
        FilterNameUpdated,
        Brand,
        NULL as Placement,
        NULL as 'Placement ID',
        NULL as Interactions,
        NULL as 'Video Views',
        NULL as 'Video Plays',
        NULL as Budget,
		NULL AS [Mashup Clicks],
		NULL AS [Mashup Clicks CPA],
		NULL AS [Detailed Page Views],
		NULL AS [Detailed Page View Rate],
		NULL AS [Add To List],
		NULL AS [Units Sold],
		NULL AS [Sales],
		NULL AS [New To Brand Purchases],
		NULL AS [New To Brand Product Sales],
		NULL AS [New To Brand Units Sold],
		Campaign_Year,
		[Ad_Type_Category] AS 'Ad Type Category',
		'Old' AS 'Convention',
		-- Demarcating campaigns based on names --
CASE
	WHEN Campaign like '2020\_%' escape '\'  THEN Campaign
	ELSE CONCAT('X - ',Campaign)
	END AS 'Campaign2',
        'DV360' as [Platform],
		NULL as [Decoded Campaign Objective], NULL as [Decoded Campaign Type], NULL as [Decoded Master Brand], NULL as [Decoded Range Brand], NULL as [Decoded Segment] 

from   [dbo].[Nestle_Prog_DV360_View]  dv
WHERE (dv.Campaign not like '%_SOCIAL' and dv.Campaign not like '%DO NOT USE%')

UNION ALL


select 
		Campaign,
        Creative,
        Date,
        NULL AS [Ad Type],
        NULL AS [Creative Attribute],
        Impressions,
        Clicks,
        NULL AS Conversions,
        NULL AS [Post Click Conversions],
        NULL AS Engagements,
        NULL AS[Video Views - 25%],
        NULL AS[Video Views - 50%],
        NULL AS[Video Views - 75%],
        NULL AS[Video Views - 100%],
        NULL AS [True View Views],
        NULL AS[True View View Rate],
        NULL AS[Companion Clicks Video],
        NULL AS[Companion Views Video],
        Cost AS 'Spend',
        Null As Revenue,
        FilterName,
        Language,
        [Search Partner],
        FilterNameUpdated,
        Brand,
        NULL as Placement,
        NULL as 'Placement ID',
        NULL as Interactions,
        NULL as 'Video Views',
        NULL as 'Video Plays',
        NULL as Budget,
		[Mashup Clicks],
		[Mashup Clicks CPA],
		[Detailed Page Views],
		[Detailed Page View Rate],
		[Add To List],
		[Units Sold],
		[Sales],
		[New To Brand Purchases],
		[New To Brand Product Sales],
		[New To Brand Units Sold],
		Campaign_Year,
		[Ad_Type_Category] AS 'Ad Type Category',
		'Old' AS 'Convention',
 CASE
	WHEN Campaign like '2020\_%' escape '\'  THEN Campaign
	ELSE CONCAT('X - ',Campaign)
	END AS 'Campaign2',
        'Amazon DSP' as [Platform],
				NULL as [Decoded Campaign Objective], NULL as [Decoded Campaign Type], NULL as [Decoded Master Brand], NULL as [Decoded Range Brand], NULL as [Decoded Segment] 

from  [dbo].[Nestle_Prog_AmazonDSP_View]  ds
WHERE (ds.Campaign not like '%_SOCIAL' and ds.Campaign not like '%DO NOT USE%')

UNION ALL 



select 
		[Campaign], 
        NULL AS Creative,
        Date,
       NULL AS [Ad Type],
     Null AS [Creative Attribute],
        Impressions,
       Clicks,
       [All Conversions] AS Conversions,
        NULL AS[Post Click Conversions],
        NULL AS Engagements,
       [Video Views - 25%],
       [Video Views - 50%],
       [Video Views - 75%],
       [Video Views - 100%],
      [Video Views] AS  [True View Views],
      NULL AS  [True View View Rate],
      NULL AS  [Companion Clicks Video],
      NULL AS  [Companion Views Video],
      Cost AS 'Spend',
      NULL AS Revenue,
      FilterName,
      Language,
      'YouTube' AS [Search Partner],
       FilterNameUpdated,
       Brand,
        NULL as Placement,
        NULL as 'Placement ID',
        NULL as Interactions,
        NULL as 'Video Views',
        NULL as 'Video Plays',
        NULL as Budget,
		NULL AS [Mashup Clicks],
		NULL AS [Mashup Clicks CPA],
		NULL AS [Detailed Page Views],
		NULL AS [Detailed Page View Rate],
		NULL AS [Add To List],
		NULL AS [Units Sold],
		NULL AS [Sales],
		NULL AS [New To Brand Purchases],
		NULL AS [New To Brand Product Sales],
		NULL AS [New To Brand Units Sold],
		Campaign_Year,
		[Ad_Type_Category] AS 'Ad Type Category',
		'Old' AS 'Convention',
	CASE
	WHEN Campaign like '2020\_%' escape '\'  THEN Campaign
	WHEN (Campaign like 'CA%') THEN Campaign
	ELSE CONCAT('X - ',Campaign)
	END AS 'Campaign2',
        'Google Ads' as [Platform],
				NULL as [Decoded Campaign Objective], NULL as [Decoded Campaign Type], NULL as [Decoded Master Brand], NULL as [Decoded Range Brand], NULL as [Decoded Segment] 

from   [dbo].[Nestle_Prog_GoogleAds_YouTube_View]  as e
-- Removing to keep only 2020 campaigns and exclude SOCIAL campaigns from Prog View
WHERE  (e.Campaign not like '%_SOCIAL' and e.Campaign not like '%DO NOT USE%')
