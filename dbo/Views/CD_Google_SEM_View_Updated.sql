










CREATE VIEW [dbo].[CD_Google_SEM_View_Updated] 

AS
WITH
 [Match] AS 
(
SELECT  DISTINCT campaign, labels FROM  [dbo].[CD_Google_Ads_New]
),

GoogleAds_Keywords_Table
AS (
	(

SELECT	[account] AS 'Account',
        CASE 
		WHEN ((LOWER(Campaign)  LIKE '%toppik%') OR (LOWER(Labels)  LIKE '%toppik%') )
		     OR 
			 ((LOWER(Campaign)  LIKE '%viviscal%') OR (LOWER(Labels)  LIKE '%viviscal%') )
	    THEN conversions
		ELSE NULL
		END
		AS 'All Conversions',
		CASE 
		WHEN ((LOWER(Campaign)  LIKE '%toppik%') OR (LOWER(Labels)  LIKE '%toppik%') )
		     OR 
			 ((LOWER(Campaign)  LIKE '%viviscal%') OR (LOWER(Labels)  LIKE '%viviscal%') )
	    THEN [all_conv_value]
		ELSE NULL
		END
		AS 'All Conversions Value',
		[campaign] AS 'Campaign',
		[clicks] AS 'Clicks',
		[client_customer_name] AS 'Client Customer Name',
		[conversions] AS 'Conversions',
		[cost] AS 'Cost',
		[day]AS 'Date',
		[deviceseg] AS 'Device',
		[impressions] AS 'Impressions',
		[labels] AS 'Labels',
		[network] AS 'Network',
		[network_w_search_partners] AS 'Network With Search Partners',
		NULL AS 'Ad Group',
		NULL AS 'Keyword',
		NULL AS 'Keyword State',
		CASE
			WHEN (LOWER(Campaign)  LIKE '%broad%') OR (LOWER(Labels)  LIKE '%broad%') THEN 'Broad'
			WHEN (LOWER(Campaign)  LIKE '%exact%') OR (LOWER(Labels)  LIKE '%exact%') THEN 'Exact'
			WHEN (LOWER(Campaign)  LIKE '%phrase%') OR (LOWER(Labels)  LIKE '%exact%')  THEN 'Phrase'
			ELSE 'Unknown'
		END
		 AS 'Match Type',
		NULL AS 'Search Impression Share',
		'CD_Google_Ads' as [table]
FROM [dbo].[CD_Google_AdWords]


UNION all

SELECT	NULL AS 'Account',
		NULL AS 'All Conversions',
		NULL AS 'All Conversions Value',
		a.[campaign] AS 'Campaign',
		a.[clicks] AS 'Clicks',
		a.[client_customer_name] AS 'Client Customer Name',
		a.[conversions] AS 'Conversions',
		a.[cost] AS 'Cost',
		a.[day] AS 'Date',
		a.[device] AS 'Device',
		a.[impressions] AS 'Impressions',
		b.[labels] AS 'Labels',
		a.[network] AS 'Network',
		a.[network_with_search_partners] AS 'Network With Search Partners',
		a.[ad_group] AS 'Ad Group',
		a.[keyword] AS 'Keyword',
		a.[keyword_state] AS 'Keyword State',
		a.[match_type] AS 'Match Type',
		NULL AS 'Search Impression Share',
		'CD_Google_Ads_KW' AS [table]
FROM [dbo].[CD_Google_Ads_KW] AS a 
LEFT JOIN  [Match] AS b
ON a.campaign = b.campaign


)
	),

	
GoogleAds_Keywords_Brand_Table

AS (
	SELECT *,CASE
		
			WHEN LOWER(Campaign) LIKE '%anusol%' OR LOWER(Labels) LIKE '%anusol%' THEN 'Anusol'	
            WHEN LOWER(Campaign) LIKE '%baking%' OR LOWER(Labels) LIKE '%baking%' THEN 'Arm & Hammer Baking Soda'
            WHEN LOWER(Campaign) LIKE '%litter%' OR LOWER(Labels) LIKE '%litter%' THEN  'Arm & Hammer Cat Litter'
            WHEN LOWER(Campaign) LIKE '%laundry%' OR LOWER(Labels) LIKE '%laundry%' THEN 'Arm & Hammer Laundry'
            WHEN LOWER(Campaign) LIKE '%master%' OR LOWER(Labels) LIKE '%master%' THEN 'Arm & Hammer Masterbrand'
            WHEN LOWER(Campaign) LIKE '%spinbrush%' OR LOWER(Labels) LIKE '%spinbrush%' THEN 'Arm & Hammer Spinbrush'
            WHEN LOWER(Campaign) LIKE '%tooth%' OR LOWER(Labels) LIKE '%tooth%' THEN 'Arm & Hammer Toothpaste'
            WHEN LOWER(Campaign) LIKE '%batiste%' OR LOWER(Labels) LIKE '%batiste%' THEN 'Batiste'
			WHEN (LOWER(Campaign) LIKE '%prenatal%' OR LOWER(Labels) LIKE '%prenatal%' ) THEN 'PreNatal'
            WHEN (LOWER(Campaign) LIKE '%response%' OR LOWER(Labels) LIKE '%response%') AND ((LOWER(Campaign) NOT LIKE '%prenatal%' OR LOWER(Labels) NOT LIKE '%prenatal%' ))THEN 'First Response'
            WHEN LOWER(Campaign) LIKE '%gravol%' OR LOWER(Labels) LIKE '%gravol%' THEN 'Gravol'
            WHEN LOWER(Campaign) LIKE '%nair%' OR LOWER(Labels) LIKE '%nair%' THEN 'Nair'
            WHEN LOWER(Campaign) LIKE '%orajel%' OR LOWER(Labels) LIKE '%orajel%' THEN 'Orajel'
            WHEN LOWER(Campaign) LIKE '%oxi%' OR LOWER(Labels) LIKE '%oxi%' THEN 'OxiClean'
            WHEN LOWER(Campaign) LIKE '%rephresh%' OR LOWER(Labels) LIKE '%rephresh%' THEN 'RepHresh'
            WHEN LOWER(Campaign) LIKE '%replens%' OR LOWER(Labels) LIKE '%replens%' THEN 'Replens'
            WHEN LOWER(Campaign) LIKE '%rub%' OR LOWER(Labels) LIKE '%rub%' THEN 'Rub A535'
            WHEN LOWER(Campaign) LIKE '%toppik%' OR LOWER(Labels) LIKE '%toppik%' THEN 'Toppik'
            WHEN LOWER(Campaign) LIKE '%trojan%' OR LOWER(Labels) LIKE '%trojan%' THEN 'Trojan'
			WHEN LOWER(Campaign) LIKE '%flawless%' OR LOWER(Labels) LIKE '%flawless%' THEN 'Flawless'
            WHEN ( LOWER(Campaign) LIKE '%vitafusion%' OR LOWER(Labels) LIKE '%vitafusion%' ) AND (LOWER(Campaign) NOT LIKE '%critters%' AND LOWER(Labels) NOT LIKE '%critters%') THEN 'Vitafusion'
            WHEN (LOWER(Campaign) LIKE '%critters%' OR LOWER(Labels) LIKE '%critters%') THEN 'Vitafusion L''il Critters'
            WHEN LOWER(Campaign) LIKE '%viviscal%' OR LOWER(Labels) LIKE '%viviscal%' THEN 'Viviscal'
            WHEN (LOWER(Campaign) LIKE '%waterpik%' OR LOWER(Labels) LIKE '%waterpik%') AND (LOWER(Campaign) NOT LIKE '%shower%' AND LOWER(Labels) NOT LIKE '%shower%') THEN 'Waterpik Flossers'
            WHEN (LOWER(Campaign) LIKE '%shower%' OR LOWER(Labels) LIKE '%shower%') AND (LOWER(Campaign) LIKE '%waterpik%' OR LOWER(Labels) LIKE '%waterpik%')THEN 'Waterpik Shower Heads'
			ELSE 'No Association'
			END
			AS FilterName,

		CASE
			WHEN (Campaign) LIKE '%EN%' OR Labels LIKE '%EN%'  THEN 'English'
			WHEN (Campaign) LIKE '%FR%' OR  Labels LIKE '%FR%'  THEN 'French'
			ELSE 'Unknown'
			END AS [Language],
      CASE
      WHEN LOWER(Campaign) LIKE '%auto%' OR Lower(Labels) LIKE '%auto%' THEN 'Automatic'
		 WHEN  Lower(Labels) LIKE '%generic%' THEN 'Generic'
		 WHEN LOWER(Campaign) LIKE '%competitive%' OR Lower(Labels) LIKE '%competitive%' THEN 'Competitive'
		 WHEN LOWER(Campaign) LIKE '%category%' OR Lower(Labels) LIKE '%category%' THEN 'Category'
		 WHEN Lower(Labels) LIKE '%brand%' THEN 'Brand'
		 WHEN (LOWER(Campaign) LIKE '%product%' OR Lower(Labels) LIKE '%product%') AND (LOWER(Campaign) NOT LIKE '%toppik%' AND  Lower(Labels) NOT LIKE 'toppik') THEN 'Product'
		 WHEN LOWER(Campaign) LIKE '%shopping%' OR Lower(Labels) LIKE '%shopping%' THEN 'Shopping'
		 WHEN (LOWER(Campaign) LIKE '%product%' OR Lower(Labels) LIKE '%product%') AND (LOWER(Campaign) LIKE '%toppik%' OR Lower(Labels) LIKE 'toppik')THEN 'Shopping'
		 WHEN LOWER(Campaign) LIKE '%affinity%' OR Lower(Labels) LIKE '%affinity%' THEN 'Affinity'
		 WHEN LOWER(Campaign) LIKE '%rlsa%' OR Lower(Labels) LIKE '%rlsa%' THEN 'RLSA'
		 WHEN LOWER(Campaign) LIKE '%retargeting%' OR Lower(Labels) LIKE '%retargeting%' THEN 'Retargeting'
		 WHEN LOWER(Campaign) LIKE '%articles%' OR Lower(Labels) LIKE '%articles%' THEN 'Articles'
		 ELSE 'Other'
		 END AS [Targeting]
	FROM GoogleAds_Keywords_Table 

	)

			
SELECT *
FROM GoogleAds_Keywords_Brand_Table AS a
RIGHT JOIN [dbo].[Brands] AS b ON a.FilterName = b.Brand