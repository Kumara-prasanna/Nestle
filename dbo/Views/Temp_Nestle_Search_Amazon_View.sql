

CREATE VIEW [dbo].[Temp_Nestle_Search_Amazon_View]
AS
WITH Amazon_Search_Table
AS (
	(
SELECT 
	[adgroupname] AS 'Ad Group Name',
	[attributedconversions14d] AS 'Conversions',
	[attributedconversions14dsamesku] AS 'Conversions Same SKU',
	[attributedsales14d] AS 'Sales',
	[attributedsales14dsamesku] AS 'Sales Same SKU',
	[campaignname] AS 'Campaign',
	[campaignstatus] AS 'Campaign Status',
	[campaigntype] AS 'Campaign Type',
	[clicks] AS 'Clicks',
	[cost] AS 'Spend',
	[date] AS 'Date',
	[impressions] AS 'Impressions',
	[keywordtext] AS 'Keyword',
	[matchtype] AS 'Match Type',
	[targetingtype] AS 'Targeting Data Source',
	'N/A' AS 'ASIN',
	NULL AS 'Units Ordered',
	NULL AS 'Sales Other SKU',
	NULL AS 'Units Ordered Other SKU',
	NULL AS 'Other ASIN' ,
	NULL AS 'Profile Brand Name',
	NULL AS 'SKU',
	NULL AS 'Product', 
	NULL AS 'ASIN_Product',
	'Nestle_Ams_S_Brands' AS [table]
FROM Nestle_Ams_S_Brands
where campaignname like '2020_%'
and clicks > 0 and impressions > 0

UNION ALL

SELECT 
	[adgroupname] AS 'Ad Group Name',
	[attributedconversions14d] AS 'Conversions',
	[attributedconversions14dsamesku] AS 'Conversions Same SKU',
	[attributedsales14d] AS 'Sales',
	[attributedsales14dsamesku] AS 'Sales Same SKU',
	[campaignname] AS 'Campaign',
	[campaignstatus] AS 'Campaign Status',
	[campaigntype] AS 'Campaign Type',
	[clicks] AS 'Clicks',
	[cost] AS 'Spend',
	[date] AS 'Date',
	[impressions] AS 'Impressions',
	[keywordtext] AS 'Keyword',
	[matchtype] AS 'Match Type',
	[targetingtype] AS 'Targeting Data Source',
	NULL AS 'ASIN',
	[attributedunitsordered14d] AS 'Units Ordered',
	NULL AS 'Sales Other SKU',
	NULL AS 'Units Ordered Other SKU',
	NULL AS 'Other ASIN' ,
	NULL AS 'Profile Brand Name',
	NULL AS 'SKU',
	NULL AS 'Product', 
	NULL AS 'ASIN_Product',
	'Nestle_Ams_S_Products_KW' AS [table]
FROM Nestle_Ams_S_Products_KW
where campaignname like '2020_%'
and clicks > 0 and impressions > 0

UNION ALL

SELECT  
	a.[adgroupname] AS 'Ad Group Name',
	a.[attributedconversions14d] AS 'Conversions',
	a.[attributedconversions14dsamesku] AS 'Conversions Same SKU',
	a.[attributedsales14d] AS 'Sales',
	a.[attributedsales14dsamesku] AS 'Sales Same SKU',
	a.[campaignname] AS 'Campaign',
	a.[campaignstatus] AS 'Campaign Status',
	a.[campaigntype] AS 'Campaign Type',
	a.[clicks] AS 'Clicks',
	a.[cost] AS 'Spend',
	a.[date] AS 'Date',
	a.[impressions] AS 'Impressions',
	NULL AS 'Keyword',
	'UNKNOWN' AS 'Match Type' ,
	a.[targetingtype] AS 'Targeting Data Source',
	a.[asin] AS 'ASIN',
	a.[attributedunitsordered14d] AS 'Units Ordered',
	NULL AS 'Sales Other SKU',
	NULL AS 'Units Ordered Other SKU',
	NULL AS 'Other ASIN' ,
	a.[profilebrandname] AS 'Profile Brand Name',
	a.[sku] AS 'SKU',
	b.[Products] AS 'Product',
-- Adding ASIN Mapping to Product Names --
	c.Products as ASIN_Product,
	'Nestle_Ams_S_Products_Prod_Ads' AS [table]
FROM Nestle_Ams_S_Products_Prod_Ads as a  JOIN [dbo].[ASINS] as b ON a.[ASIN] = b.[ASIN]  JOIN [dbo].[Ams_ASIN_Mapping] c on a.[ASIN] = c.[ASIN]
where campaignname like '2020_%'
)
	)
	,

Distinct_Campaign_Table 
AS

(
	SELECT DISTINCT Campaign, [Campaign Type] FROM Amazon_Search_Table

)
,

Amazon_Search_Brand_Table

AS (
	SELECT *,
		CASE
		--------------------------------BEVERAGES--------------------------------------------------------------
			WHEN LOWER(Campaign) LIKE '%bliss%'  THEN 'Beverages-Bliss'
			WHEN (LOWER(Campaign) LIKE '%mate%' ) AND (LOWER(Campaign) LIKE '%coffee%') THEN 'Beverages-Coffee Mate'
			WHEN LOWER(Campaign) LIKE '%dolce%'  THEN 'Beverages-Dolce Gusto'
			WHEN LOWER(Campaign) LIKE '%gold%'  THEN 'Beverages-Nescafe Gold'
			WHEN (LOWER(Campaign) LIKE '%time%' ) AND (LOWER(Campaign) LIKE '%good%')  THEN 'Beverages-Good Time'
			WHEN (LOWER(Campaign) LIKE '%sweet%' ) AND LOWER(Campaign) LIKE '%cream%'  THEN 'Beverages-Nescafe Sweet & Creamy'
			WHEN LOWER(Campaign) LIKE '%capuccino%'  THEN 'Beverages-Nescafe Capuccino'
		    WHEN LOWER(Campaign) LIKE '%rich%'  THEN 'Beverages-Nescafe Rich'
			WHEN LOWER(Campaign) LIKE '%kcup%'  THEN 'Beverages-Starbucks Kcup'
		    WHEN LOWER(Campaign) LIKE '%nespresso%'  THEN 'Beverages-Starbucks by Nespresso'
		    WHEN LOWER(Campaign) LIKE '%nesquik%'  THEN  'Beverages-Nesquik'
		    WHEN (LOWER(Campaign) LIKE '%cpg%' ) AND (LOWER(Campaign) LIKE '%starbucks%' )  THEN 'Beverages-Starbucks-CPG At Home Coffee'
	
			-----------------------------------CONFECTIONERY------------------------------------------------------------
			WHEN LOWER(Campaign) LIKE '%aero%'  THEN 'Confectionery-Aero'
			WHEN LOWER(Campaign) LIKE '%baci%'  THEN 'Confectionery-Baci'
			WHEN (LOWER(Campaign) LIKE '%crisp%' ) AND (LOWER(Campaign) LIKE '%coffee%' ) THEN 'Confectionery-Coffee Crisp'
			WHEN (LOWER(Campaign) LIKE '%kit%' ) AND (LOWER(Campaign) LIKE '%kat%' )  THEN 'Confectionery-Kit Kat'
			WHEN LOWER(Campaign) LIKE '%telier%' THEN 'Confectionery-L''Atelier'
			WHEN LOWER(Campaign) LIKE '%minis%'  THEN 'Confectionery-Minis'
			WHEN LOWER(Campaign) LIKE '%smarties%' THEN 'Confectionery-Smarties'
			WHEN LOWER(Campaign) LIKE '%turtles%' THEN 'Confectionery-Turtles'
			-----------------------------------CORPORATE--------------------------------------------------------------------
			--WHEN (LOWER(Campaign) LIKE '%corp%' OR LOWER([Client Customer Name]) LIKE  '%corp%') AND FilterName is NULL THEN 'Corporate-Corporate'

            -----------------------------------FROZEN-----------------------------------------------------------------------
			WHEN LOWER(Campaign) LIKE '%delissio%'   THEN 'Frozen-Delissio'
			WHEN (LOWER(Campaign) LIKE '%lean%'  ) AND (LOWER(Campaign) LIKE '%cuisine%') THEN 'Frozen-Lean Cuisine'
			WHEN LOWER(Campaign) LIKE '%market%'   AND (LOWER(Campaign) LIKE '%cuisine%' )  THEN 'Frozen-Marketplace Cuisine'
			WHEN LOWER(Campaign) LIKE '%stouffer%'    THEN 'Frozen-Stouffers'
			

			-----------------------------------HEALTH-SCIENCES-------------------------------------------------------------

			WHEN LOWER(Campaign) LIKE '%boost%'  THEN 'Health Sciences-Boost'
			WHEN ( LOWER(Campaign) LIKE '%break%') AND ( LOWER(Campaign) LIKE '%carnation%' ) THEN 'Health Sciences-Carnation Breakfast'
			WHEN (LOWER(Campaign) LIKE '%adult%'  ) AND (LOWER(Campaign) LIKE '%compleat%'  ) THEN 'Health Sciences-Compleat Adult'
			WHEN LOWER(Campaign) LIKE '%pediatric%'  THEN 'Health Sciences-Compleat Pediatric'
			WHEN LOWER(Campaign) LIKE '%resource%'   THEN 'Health Sciences-Resources2.0'
			WHEN LOWER(Campaign) LIKE '%thicken%'   THEN 'Health Sciences-Thicken Up'
			WHEN (LOWER(Campaign) LIKE '%soothe%' ) AND (LOWER(Campaign) LIKE '%boost%'  )  THEN 'Health Sciences-Boost Soothe'
		    WHEN (LOWER(Campaign) LIKE '%complete%' ) AND (LOWER(Campaign) LIKE '%boost%' )  THEN 'Health Sciences-Boost Complete+'
			
			---------------------------------------ICE-CREAM-------------------------------------------------------------------

			WHEN (LOWER(Campaign) LIKE '%north%' ) AND (LOWER(Campaign) LIKE '%good%' )  THEN 'Ice Cream-Good North'
			WHEN LOWER(Campaign) LIKE '%haagen%' THEN 'Ice Cream-Haagen-Dazs'
		    WHEN LOWER(Campaign) LIKE '%drumstick%'  THEN  'Ice Cream-Drumstick'
			
			-------------------------------------------------INFANT-------------------------------------------------------------------
			
			WHEN LOWER(Campaign) LIKE '%gerber%'  THEN 'Infant Nutrition-Gerber'
			WHEN (LOWER(Campaign) LIKE '%start%') AND (LOWER(Campaign) LIKE '%good%' ) THEN 'Infant Nutrition-Good Start'
			WHEN LOWER(Campaign) LIKE '%materna%'   THEN 'Infant Nutrition-Materna'
			WHEN (LOWER(Campaign) LIKE '%baby%' OR LOWER(Campaign) LIKE '%swsw%') AND (LOWER(Campaign) NOT LIKE '%cetaphil%' ) THEN 'Infant-Nestle Baby'
			
        
		    ----------------------------------------PURINA------------------------------------------------------------------------------

			WHEN LOWER(Campaign) LIKE '%beneful%'   THEN 'Purina-Beneful'
			WHEN LOWER(Campaign) LIKE '%catchow%'  THEN 'Purina-Cat Chow'
			WHEN LOWER(Campaign) LIKE '%dogchow%'  THEN 'Purina-Dog Chow'
			WHEN LOWER(Campaign) LIKE '%fancy%'  THEN 'Purina-Fancy Feast'
			WHEN LOWER(Campaign) LIKE '%ONE%'  THEN 'Purina-ONE'
			WHEN (LOWER(Campaign) LIKE '%pro%')  AND (LOWER(Campaign) LIKE '%plan%' ) THEN 'Purina-Pro Plan'
			WHEN LOWER(Campaign) LIKE '%tidy%'   THEN 'Purina-Tidy Cats'
			WHEN LOWER(Campaign) LIKE '%beyond%'  THEN 'Purina -Beyond'
		    WHEN LOWER(Campaign) LIKE '%denta%'  THEN 'Purina-DentaLife'
		
			-------------------------------------------SKIN-HEALTH--------------------------------------------------------------------------
			WHEN  (LOWER(Campaign) LIKE '%baby%') AND (LOWER(Campaign) LIKE '%cetaphil%') THEN 'Skin Health-Cetaphil Baby'
			WHEN  (LOWER(Campaign) LIKE '%core%')   AND (LOWER(Campaign) LIKE '%cetaphil%') THEN 'Skin Health-Cetaphil Core'
			WHEN (LOWER(Campaign) LIKE '%master%') AND (LOWER(Campaign) LIKE '%cetaphil%')  THEN 'Skin Health-Cetaphil Master brand'
			WHEN LOWER(Campaign) LIKE '%dysport%'  THEN 'Skin Health-Dysport'
			WHEN LOWER(Campaign) LIKE '%excipial%'  THEN 'Skin Health-Excipial'
			WHEN LOWER(Campaign) LIKE '%restylane%'   THEN 'Skin Health-Restylane'
			WHEN LOWER(Campaign) LIKE '%rosacea%'  THEN 'Skin Health-Rosacea'
			
			------------------------------------WATERS--------------------------------------------------------------------------------------
	        WHEN LOWER(Campaign) LIKE '%pana%'    THEN 'Waters-Aqua Pana'
			WHEN LOWER(Campaign) LIKE '%perrier%'  THEN 'Waters-Perrier'
			WHEN (LOWER(Campaign) LIKE '%life%' ) 
			     AND ((LOWER(Campaign) NOT LIKE '%fruit%' ) )
			     AND ((LOWER(Campaign) NOT LIKE '%spark%') ) THEN 'Waters-Pure Life'
			WHEN LOWER(Campaign) LIKE '%spark%' THEN 'Waters-Pure Life Sparkling'
			WHEN ((LOWER(Campaign) LIKE '%san%' ) OR (LOWER(Campaign)  LIKE '%pellegrino%' )) 
			     AND ((LOWER(Campaign) NOT LIKE '%fruit%' )) 
				 AND ((LOWER(Campaign) NOT LIKE '%spark%' )) THEN 'Waters-San Pellegrino'
			WHEN LOWER(Campaign) LIKE '%fruit%'  THEN 'Waters-San Pellegrino Fruit'
			
			---------------------------------------OTHERS---------------------------------------------------------------------------------
			ELSE 'Other'
			
			END AS FilterName,
--Social - The campaign names mostly has english , french, FR, EN values - 
--setting up column language based on  pattern matching
		CASE
			WHEN (LOWER(Campaign) LIKE '%sponsored brand%') OR (LOWER([Campaign Type]) LIKE '%headline%') THEN 'Sponsored Brands'
			WHEN (LOWER(Campaign) LIKE '%sponsored product%') OR (LOWER([Campaign Type]) LIKE '%sponsoredproduct%') THEN 'Sponsored Products'
			ELSE 'Unknown'
			END AS [Ad Type],
      
       CASE 
	     
	     WHEN LOWER(Campaign) LIKE '%auto%' THEN 'Automatic'
		 WHEN LOWER(Campaign) LIKE '%generic%'  THEN 'Generic'
		 WHEN ( Campaign LIKE '%/_CO%' Escape '/' )  OR LOWER(Campaign) LIKE '%competitive%'   THEN 'Competitive'
		 WHEN (Campaign LIKE '%/_NB%' Escape '/' )   OR LOWER(Campaign) LIKE '%non brand%' OR LOWER(Campaign) LIKE '%non-brand%'  THEN 'Non-Brand'
		 WHEN (Campaign Like '%/_BR%'  Escape '/' )  OR LOWER(Campaign) LIKE '%brand%'  THEN 'Brand'
		 WHEN LOWER(Campaign) LIKE '%sponsored%'  THEN 'Non-Brand'
		 WHEN LOWER(Campaign) LIKE '%mix%'  THEN 'Mix'
		 WHEN LOWER(Campaign) LIKE '%category%'  THEN 'Category'
		 ELSE 'Other'
		 END AS [Targeting]

	FROM Distinct_Campaign_Table
	
	) 
,

---- Corp Check loop 2 

Amazon_Search_Brand_Filter_Table  
AS
(
 (

SELECT *, 
	       CASE
            WHEN (LOWER(Campaign) LIKE '%starbucks%' )AND (FilterName NOT LIKE '%Beverages%') THEN 'Beverages-Starbucks'
			WHEN (((LOWER(Campaign) LIKE '%bev%') AND (LOWER(Campaign) LIKE '%corp%'))) AND (FilterName NOT LIKE '%Beverages%') THEN 'Beverages-Beverages Corporate'
			WHEN ((LOWER(Campaign) LIKE '%nescafe%' ) AND (FilterName NOT LIKE '%Nescafe%'))THEN 'Beverages-Nescafe'
			WHEN ((LOWER(Campaign) LIKE '%confect%') AND (LOWER(Campaign) LIKE '%corp%'))  AND ( FilterName NOT LIKE '%Confect%')THEN 'Confectionery-Confectionery Corporate'
			WHEN (LOWER(Campaign) LIKE '%corp%' ) AND FilterName = 'other' THEN 'Corporate-Corporate'
			WHEN ((LOWER(Campaign) LIKE '%frozen%') AND (LOWER(Campaign) LIKE '%corp%'))  AND (FilterName NOT LIKE '%Frozen%') THEN 'Frozen-Frozen Corporate'
			WHEN ((LOWER(Campaign) LIKE '%frozen%') AND (LOWER(Campaign) LIKE '%corp%')) AND (FilterName NOT LIKE '%Frozen%') THEN 'Frozen-Frozen Corporate'
			WHEN ((LOWER(Campaign) LIKE '%health%') AND (LOWER(Campaign) LIKE '%corp%'))  AND (FilterName NOT LIKE '%Health%') THEN 'Health Sciences-Health Sciences Corporate'
			WHEN ((LOWER(Campaign) LIKE '%ice%') AND (LOWER(Campaign) LIKE '%corp%'))  AND (FilterName NOT LIKE '%Ice%') THEN 'Ice Cream-Ice Cream Corporate'
			WHEN ((LOWER(Campaign) LIKE '%infant%') AND (LOWER(Campaign) LIKE '%corp%')) AND( FilterName NOT LIKE '%Infant%') THEN 'Infant Nutrition-Infant Nutrition Corporate'
			WHEN(LOWER(Campaign) LIKE '%water%') AND (LOWER(Campaign) LIKE '%corp%')  AND (FilterName NOT LIKE '%Waters%') THEN 'Waters-Waters Corporate'
			WHEN (LOWER(Campaign) LIKE '%skin%') AND (LOWER(Campaign) LIKE '%corp%') AND( FilterName NOT LIKE '%Skin%')  THEN 'Skin Health-Skin Health Corporate'
			WHEN ((LOWER(Campaign) LIKE '%purina%') AND (LOWER(Campaign) LIKE '%corp%'))  AND (FilterName NOT LIKE '%Purina%') THEN 'Purina-Purina Corporate'
			WHEN ((LOWER(Campaign) LIKE '%master%') AND (LOWER(Campaign) LIKE '%master%' ) AND (FilterName NOT LIKE '%Purina%')) THEN 'Purina-Purina Master Brand'
			ELSE FilterName
			END AS FilterNameUpdated
			FROM Amazon_Search_Brand_Table
			)
) 

,

AMS_Join_CampaignSplit

AS 

(SELECT a.*,b.FilterName, b.[Ad Type],b.Targeting,b.FilterNameUpdated FROM Amazon_Search_Table AS a 
  JOIN Amazon_Search_Brand_Filter_Table AS b ON a.Campaign = b.Campaign

)
,

Amazon_Search_View
AS
(
			
SELECT *
FROM 
AMS_Join_CampaignSplit AS a
RIGHT JOIN [dbo].[BrandFilter] AS b ON a.FilterNameUpdated = b.Brand
)

SELECT a.*,b.Non_Branded_SOV
FROM  Amazon_Search_View  AS a JOIN [dbo].[Amazon_Search_KPI] as b ON a.Brand = b.Brand
where Clicks > 0 and Impressions > 0


