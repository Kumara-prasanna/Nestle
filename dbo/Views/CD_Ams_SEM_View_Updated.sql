



CREATE VIEW [dbo].[CD_Ams_SEM_View_Updated]
AS
WITH Amazon_Search_Table
AS (
	(
SELECT
	[Ad_Group_Name] AS 'Ad Group Name', 
	[Conversions] AS 'Conversions',
	[Rev] AS 'Sales', 
	--[_14_days_same_sku] AS 'Sales Same SKU',
	[Campaign_Name] AS 'Campaign',
	[Campaign_Status] AS 'Campaign Status',
	--[campaigntype] AS 'Campaign Type',
	[Clicks] AS 'Clicks',
	[Cost] AS 'Spend',  
	[Date] AS 'Date',
	[Impressions] AS 'Impressions',
	[Keyword] AS 'Keyword',
	[Match_Type] AS 'Match Type',
	[Keyword_Targeting] AS 'Targeting Data Source',
	'N/A' AS 'ASIN', ---> N/A
	[units_14_day] AS 'Units Ordered',
	--NULL AS 'Sales Other SKU', 
	--NULL AS 'Units Ordered Other SKU',
	--NULL AS 'Other ASIN' ,
	[Profile_Name] AS 'Profile Brand Name',
	--NULL AS 'SKU',
	'CD_AMN_Search' AS [table]
FROM [dbo].[CD_AMN_Search]

--UNION ALL
-- ASINS Table redundant 
--SELECT 
--	[adgroupname] AS 'Ad Group Name',
--	NULL AS 'Conversions',
--	NULL AS 'Conversions Same SKU',
--	NULL AS 'Sales',
--	NULL AS 'Sales Same SKU',
--	[Campaign] AS 'Campaign',
--	NULL AS 'Campaign Status',
--	NULL AS 'Campaign Type',
--	NULL AS 'Clicks',
--	NULL AS 'Spend',
--	[date] AS 'Date',
--	NULL AS 'Impressions',
--	[keywordtext] AS 'Keyword',
--	[matchtype] AS 'Match Type',
--	[targetingtype] AS 'Targeting Data Source',
--	[asin] AS 'ASIN',
--	NULL  AS 'Units Ordered',
--	[attributedsales14dothersku] AS 'Sales Other SKU',
--	[attributedunitsordered14dothersku] AS 'Units Ordered Other SKU',
--	[otherasin] AS 'Other ASIN' ,
--	[profilebrandname] AS 'Profile Brand Name',
--	[sku] AS 'SKU',
--	'Nestle_Ams_S_Products_ASINS' AS [table]
--FROM Nestle_Ams_S_Products_ASINS

--UNION ALL

--SELECT 
--	[adgroupname] AS 'Ad Group Name',
--	[attributedconversions14d] AS 'Conversions',
--	[attributedconversions14dsamesku] AS 'Conversions Same SKU',
--	[attributedsales14d] AS 'Sales',
--	[attributedsales14dsamesku] AS 'Sales Same SKU',
--	[campaignname] AS 'Campaign',
--	[campaignstatus] AS 'Campaign Status',
--	[campaigntype] AS 'Campaign Type',
--	[clicks] AS 'Clicks',
--	[cost] AS 'Spend',
--	[date] AS 'Date',
--	[impressions] AS 'Impressions',
--	[keywordtext] AS 'Keyword',
--	[matchtype] AS 'Match Type',
--	[targetingtype] AS 'Targeting Data Source',
--	NULL AS 'ASIN',
--	[attributedunitsordered14d] AS 'Units Ordered',
--	NULL AS 'Sales Other SKU',
--	NULL AS 'Units Ordered Other SKU',
--	NULL AS 'Other ASIN' ,
--	NULL AS 'Profile Brand Name',
--	NULL AS 'SKU',
--	'CD_Ams_S_Products_KW' AS [table]
--FROM [dbo].[CD_AMN_S_Pro_KW]

--UNION ALL

--SELECT  
--	NULL AS 'Ad Group Name',
--	[attributedconversions14d] AS 'Conversions',
--	[attributedconversions14dsamesku] AS 'Conversions Same SKU',
--	[attributedsales14d] AS 'Sales',
--	[attributedsales14dsamesku] AS 'Sales Same SKU',
--	[campaignname] AS 'Campaign',
--	[campaignstatus] AS 'Campaign Status',
--	[campaigntype] AS 'Campaign Type',
--	[clicks] AS 'Clicks',
--	[cost] AS 'Spend',
--	[date] AS 'Date',
--	[impressions] AS 'Impressions',
--	NULL AS 'Keyword',
--	'UNKNOWN' AS 'Match Type' ,
--	[targetingtype] AS 'Targeting Data Source',
--	[asin] AS 'ASIN',
--	[attributedunitsordered14d] AS 'Units Ordered',
--	NULL AS 'Sales Other SKU',
--	NULL AS 'Units Ordered Other SKU',
--	NULL AS 'Other ASIN' ,
--	[profilebrandname] AS 'Profile Brand Name',
--	[sku] AS 'SKU',
--	'CD_Ams_S_Products_Prod_Ads' AS [table]
--FROM [dbo].[CD_AMN_S_Pro_ProAds]
)
	),
Amazon_Search_Table_Mapped 
AS
( SELECT d.*, 
            e.Campaign_Name  AS 'Mapped Campaign Name'
	
  FROM Amazon_Search_Table as d 
  LEFT JOIN   [dbo].[CD_Mapping]AS e 
  ON  d.[Campaign] = e.Campaign_Name 
		
		)
		,
Amazon_Search_Brand_Table

AS (
	SELECT *, 
		CASE
		
			WHEN LOWER(Campaign) LIKE '%anusol%' OR LOWER([Mapped Campaign Name]) LIKE '%anusol%' THEN 'Anusol'	
            WHEN LOWER(Campaign) LIKE '%baking%' OR LOWER([Mapped Campaign Name]) LIKE '%baking%' THEN 'Arm & Hammer Baking Soda'
            WHEN LOWER(Campaign) LIKE '%litter%' OR LOWER([Mapped Campaign Name]) LIKE '%litter%' THEN  'Arm & Hammer Cat Litter'
            WHEN LOWER(Campaign) LIKE '%laundry%' OR LOWER([Mapped Campaign Name]) LIKE '%laundry%' THEN 'Arm & Hammer Laundry'
            WHEN LOWER(Campaign) LIKE '%master%' OR LOWER([Mapped Campaign Name]) LIKE '%master%' THEN 'Arm & Hammer Masterbrand'
            WHEN LOWER(Campaign) LIKE '%spinbrush%' OR LOWER([Mapped Campaign Name]) LIKE '%spinbrush%' THEN 'Arm & Hammer Spinbrush'
            WHEN (LOWER(Campaign) LIKE '%tooth%' OR LOWER([Mapped Campaign Name]) LIKE '%tooth%')  AND (LOWER(Campaign) NOT LIKE '%orajel%' OR LOWER([Mapped Campaign Name]) NOT LIKE '%orajel%') THEN 'Arm & Hammer Toothpaste'
            WHEN LOWER(Campaign) LIKE '%batiste%' OR LOWER([Mapped Campaign Name]) LIKE '%batiste%' THEN 'Batiste'
			WHEN LOWER(Campaign) LIKE '%prenatal%' OR LOWER([Mapped Campaign Name]) LIKE '%prenatal%' THEN 'PreNatal'
            WHEN (LOWER(Campaign) LIKE '%response%' OR LOWER([Mapped Campaign Name]) LIKE '%response%' ) AND (LOWER(Campaign) NOT LIKE '%prenatal%' OR LOWER([Mapped Campaign Name]) NOT LIKE '%prenatal%')THEN 'First Response'
            WHEN LOWER(Campaign) LIKE '%gravol%' OR LOWER([Mapped Campaign Name]) LIKE '%gravol%' THEN 'Gravol'
            WHEN LOWER(Campaign) LIKE '%nair%' OR LOWER([Mapped Campaign Name]) LIKE '%nair%' THEN 'Nair'
            WHEN LOWER(Campaign) LIKE '%orajel%' OR LOWER([Mapped Campaign Name]) LIKE '%orajel%' THEN 'Orajel'
            WHEN LOWER(Campaign) LIKE '%oxi%' OR LOWER([Mapped Campaign Name]) LIKE '%oxi%' THEN 'OxiClean'
            WHEN LOWER(Campaign) LIKE '%rephresh%' OR LOWER([Mapped Campaign Name]) LIKE '%rephresh%' THEN 'RepHresh'
            WHEN LOWER(Campaign) LIKE '%replens%' OR LOWER([Mapped Campaign Name]) LIKE '%replens%' THEN 'Replens'
            WHEN LOWER(Campaign) LIKE '%rub%' OR LOWER([Mapped Campaign Name]) LIKE '%rub%' THEN 'Rub A535'
            WHEN LOWER(Campaign) LIKE '%toppik%' OR LOWER([Mapped Campaign Name]) LIKE '%toppik%' THEN 'Toppik'
            WHEN LOWER(Campaign) LIKE '%trojan%' OR LOWER([Mapped Campaign Name]) LIKE '%trojan%' THEN 'Trojan'
			WHEN LOWER(Campaign) LIKE '%flawless%' OR LOWER([Mapped Campaign Name]) LIKE '%flawless%' THEN 'Flawless'
            WHEN ( LOWER(Campaign) LIKE '%vitafusion%' OR LOWER([Mapped Campaign Name]) LIKE '%vitafusion%' ) AND (LOWER(Campaign) NOT LIKE '%critters%' AND LOWER([Mapped Campaign Name]) NOT LIKE '%critters%') THEN 'Vitafusion'
            WHEN (LOWER(Campaign) LIKE '%critters%' OR LOWER([Mapped Campaign Name]) LIKE '%critters%') THEN 'Vitafusion L''il Critters'
            WHEN LOWER(Campaign) LIKE '%viviscal%' OR LOWER([Mapped Campaign Name]) LIKE '%viviscal%' THEN 'Viviscal'
            WHEN (LOWER(Campaign) LIKE '%waterpik%' OR LOWER([Mapped Campaign Name]) LIKE '%waterpik%') AND (LOWER(Campaign) NOT LIKE '%shower%' AND LOWER([Mapped Campaign Name]) NOT LIKE '%shower%') THEN 'Waterpik Flossers'
            WHEN (LOWER(Campaign) LIKE '%shower%' OR LOWER([Mapped Campaign Name]) LIKE '%shower%') AND (LOWER(Campaign) LIKE '%waterpik%' OR LOWER([Mapped Campaign Name]) LIKE '%waterpik%')THEN 'Waterpik Shower Heads'
			ELSE 'No Association'
			END
			AS FilterName, 
--Social - The campaign names mostly has english , french, FR, EN values - 
--setting up column language based on  pattern matching
		 CASE
         WHEN [Campaign] LIKE '%|SB|%'  THEN 'Sponsored Brands'
		 WHEN  [Campaign] LIKE '%|SP|%'  THEN 'Sponsored Products'
		 ELSE 'Other'
			END AS [Ad Type],
      
        CASE
        WHEN LOWER(Campaign) LIKE '%auto%' OR Lower([Mapped Campaign Name]) LIKE '%auto%' THEN 'Automatic'
		 WHEN  Lower(Campaign) LIKE '%generic%' THEN 'Generic'
		 WHEN LOWER(Campaign) LIKE '%competitive%' OR Lower([Mapped Campaign Name]) LIKE '%competitive%' THEN 'Competitive'
		 WHEN LOWER(Campaign) LIKE '%competitve%' OR Lower([Mapped Campaign Name]) LIKE '%competitve%' THEN 'Competitive'
		 WHEN LOWER(Campaign) LIKE '%category%' OR Lower([Mapped Campaign Name]) LIKE '%category%' THEN 'Category'
		 WHEN Lower(Campaign) LIKE '%brand%' THEN 'Brand'
		 WHEN (LOWER(Campaign) LIKE '%product%' OR Lower([Mapped Campaign Name]) LIKE '%product%')  THEN 'Product'
		 WHEN LOWER(Campaign) LIKE '%shopping%' OR Lower([Mapped Campaign Name]) LIKE '%shopping%' THEN 'Shopping'
		 WHEN LOWER(Campaign) LIKE '%affinity%' OR Lower([Mapped Campaign Name]) LIKE '%affinity%' THEN 'Affinity'
		 WHEN LOWER(Campaign) LIKE '%rlsa%' OR Lower([Mapped Campaign Name]) LIKE '%rlsa%' THEN 'RLSA'
		 WHEN LOWER(Campaign) LIKE '%retargeting%' OR Lower([Mapped Campaign Name]) LIKE '%retargeting%' THEN 'Retargeting'
		 WHEN LOWER(Campaign) LIKE '%articles%' OR Lower([Mapped Campaign Name]) LIKE '%articles%' THEN 'Articles'
		 ELSE 'Other'
		 END AS [Targeting]

		 FROM Amazon_Search_Table_Mapped 


	) ,

	Amazon_Search_Brand_Filter_Table  
AS
(
 (

SELECT *, 
	       CASE
            WHEN ((Campaign) LIKE '%vitafusio%' OR LOWER([Mapped Campaign Name]) LIKE '%vitafusio%'  ) AND (FilterName  LIKE '%Association%') THEN 'Vitafusion'
			ELSE FilterName
			END AS FilterNameUpdated
			FROM Amazon_Search_Brand_Table
			)
)
			
SELECT *
FROM 
Amazon_Search_Brand_Filter_Table  AS a
RIGHT JOIN [dbo].[Brands] AS b ON a.FilterNameUpdated = b.Brand WHERE (b.Brand NOT LIKE '%Viviscal%' AND b.Brand NOT LIKE '%Waterpik%') AND [Date] >= '2020-01-01'