

CREATE VIEW [dbo].[Test_SP_Nestle_Search_Google_NewConv_View_KP]
AS

WITH GoogleAds_Keywords_Table
AS (
	(

SELECT	[account] AS 'Account',
		[all_conv] AS 'All Conversions',
		[all_conv_value] AS 'All Conversions Value',
		[campaign] AS 'Campaign',
		[clicks] AS 'Clicks',
		[client_customer_name] AS 'Client Customer Name',
		[conversions] AS 'Conversions',
		[cost] AS 'Cost',
		[day]AS 'Date',
		[device] AS 'Device',
		[impressions] AS 'Impressions',
		[labels] AS 'Labels',
		[network] AS 'Network',
		[network_with_search_partners] AS 'Network With Search Partners',
		NULL AS 'Ad Group',
		NULL AS 'Keyword',
		NULL AS 'Keyword State',
CASE 
	     
	WHEN LOWER(Campaign) LIKE '%auto%' OR Lower(Labels) LIKE '%auto%' THEN 'Automatic'
	WHEN LOWER(Campaign) LIKE '%generic%' OR Lower(Labels) LIKE '%generic%' THEN 'Generic'
	WHEN ( LOWER(Campaign) LIKE '%competitive%' OR LOWER(Campaign) LIKE '%_comp%' )  THEN 'Competitive'
	WHEN (Campaign LIKE '%/_NB%' Escape '/' )   OR LOWER(Campaign) LIKE '%non brand%' OR LOWER(Campaign) LIKE '%nonbrand%' OR LOWER(Labels) LIKE '%non-brand%'  THEN 'Non-Brand'
	WHEN (Campaign Like '%/_BR%'  Escape '/' )  OR LOWER(Campaign) LIKE '%brand%'  THEN 'Brand'
	WHEN LOWER(Campaign) LIKE '%category%' OR Lower(Labels) LIKE 'category' THEN 'Category'
	ELSE 'Other'
	END AS [Targeting],
		CASE
			WHEN LOWER(Campaign)  LIKE '%broad%' THEN 'Broad'
			WHEN LOWER(Campaign)  LIKE '%exact%' THEN 'Exact'
			WHEN LOWER(Campaign)  LIKE '%phrase%' THEN 'Phrase'
			ELSE 'Unknown'
		END
		 AS 'Match Type',
		  CASE
            WHEN search_impr_share is NULL THEN 0
            WHEN search_impr_share = '< 10%' THEN 10
            ELSE CAST(LEFT(search_impr_share, len(search_impr_share)-1) AS FLOAT)
        END AS 'Search Impression Share',
CASE WHEN [campaign] like 'CA_%' and YEAR(dt_Created)='2020' THEN '2020'
	 WHEN [campaign] like 'CA_%' and YEAR(dt_Created)>'2020' THEN 'GT2020'
	ELSE 'X-Year'
END AS 'Campaign_Year',
		'Nestle_Google_Ads' as [table]
FROM [dbo].[Nestle_Search_GoogleAds]
WHERE campaign like 'CA_%' and clicks > 0 or impressions > 0

UNION all

SELECT	NULL AS 'Account',
		NULL AS 'All Conversions',
		NULL AS 'All Conversions Value',
		[campaign] AS 'Campaign',
		[clicks] AS 'Clicks',
		[client_customer_name] AS 'Client Customer Name',
		[conversions] AS 'Conversions',
		[cost] AS 'Cost',
		[day] AS 'Date',
		[device] AS 'Device',
		[impressions] AS 'Impressions',
		[labels] AS 'Labels',
		[network] AS 'Network',
		[network_with_search_partners] AS 'Network With Search Partners',
		[ad_group] AS 'Ad Group',
		[keyword] AS 'Keyword',
		[keyword_state] AS 'Keyword State',
		[match_type] AS 'Match Type',
      
CASE 
	     
	WHEN LOWER(Campaign) LIKE '%auto%' OR Lower(Labels) LIKE '%auto%' THEN 'Automatic'
	WHEN LOWER(Campaign) LIKE '%generic%' OR Lower(Labels) LIKE '%generic%' THEN 'Generic'
	WHEN ( LOWER(Campaign) LIKE '%competitive%' OR LOWER(Campaign) LIKE '%_comp%' )  THEN 'Competitive'
	WHEN (Campaign LIKE '%/_NB%' Escape '/' )   OR LOWER(Campaign) LIKE '%non brand%' OR LOWER(Campaign) LIKE '%nonbrand%' OR LOWER(Labels) LIKE '%non-brand%'  THEN 'Non-Brand'
	WHEN (Campaign Like '%/_BR%'  Escape '/' )  OR LOWER(Campaign) LIKE '%brand%'  THEN 'Brand'
	WHEN LOWER(Campaign) LIKE '%category%' OR Lower(Labels) LIKE 'category' THEN 'Category'
	ELSE 'Other'
	END AS [Targeting],
		NULL AS 'Search Impression Share',
CASE WHEN [campaign] like 'CA_%' and YEAR(dt_Created)='2020' THEN '2020'
	 WHEN [campaign] like 'CA_%' and YEAR(dt_Created)>'2020' THEN 'GT2020'
	ELSE 'X-Year'
END AS 'Campaign_Year',
		'Nestle_Google_Ads_KW' as [table]
FROM  [dbo].[Nestle_Search_GoogleAds_KW]
WHERE campaign like 'CA_%' and clicks > 0 or impressions > 0

)
	)

-- ==== Splitting Campaign into Columns ==== --
,Campaign_Split AS
	(
SELECT distinct campaign,
dbo.SplitStringDelimiter(campaign, 1, '_') as 'Country',
dbo.SplitStringDelimiter(campaign, 2, '_') as 'Master Brand',
dbo.SplitStringDelimiter(campaign, 3, '_') as 'Range Brand',
dbo.SplitStringDelimiter(campaign, 4, '_') as 'Language',
dbo.SplitStringDelimiter(campaign, 5, '_') as 'Search Engine',
dbo.SplitStringDelimiter(campaign, 6, '_') as 'Targeting Type',
dbo.SplitStringDelimiter(campaign, 7, '_') as 'Campaign Match Type',
dbo.SplitStringDelimiter(campaign, 8, '_') as 'Audience Detail',
dbo.SplitStringDelimiter(campaign, 9, '_') as 'Campaign Objective',
dbo.SplitStringDelimiter(campaign, 10, '_') as 'Sub-Segment',
dbo.SplitStringDelimiter(campaign, 11, '_') as 'Local Segment',
dbo.SplitStringDelimiter(campaign, 12, '_') as 'Campaign Free Field',
dbo.SplitStringDelimiter(campaign, 13, '_') as 'Campaign ID',
-- Decoding here for what I could not get Selection Map --
'Decoded Campaign Match Type' =
CASE
	WHEN dbo.SplitStringDelimiter(campaign, 7, '_') = 'EX' THEN 'Exact'
	WHEN dbo.SplitStringDelimiter(campaign, 7, '_') = 'PH' THEN 'Phrase'
	WHEN dbo.SplitStringDelimiter(campaign, 7, '_') = 'BR' THEN 'Broad'
	WHEN dbo.SplitStringDelimiter(campaign, 7, '_') = 'BM' THEN 'Broad Match Modified'
	WHEN dbo.SplitStringDelimiter(campaign, 7, '_') = 'NA' THEN 'NULL-Convention'
	END,
'Decoded Audience Detail' =
CASE
	WHEN dbo.SplitStringDelimiter(campaign, 8, '_') = 'AFF' THEN 'Affinity'
	WHEN dbo.SplitStringDelimiter(campaign, 8, '_') = 'CDS' THEN 'Combined Data Sources'
	WHEN dbo.SplitStringDelimiter(campaign, 8, '_') = 'Demo' THEN 'Demographic'
	WHEN dbo.SplitStringDelimiter(campaign, 8, '_') = 'InMkt' THEN 'In-Market'
	WHEN dbo.SplitStringDelimiter(campaign, 8, '_') = 'MobAp' THEN 'Mobile App Users'
	WHEN dbo.SplitStringDelimiter(campaign, 8, '_') = 'YT' THEN 'YouTube Users'
	END,
'Decoded Sub-Segment/Category' =
CASE
	WHEN dbo.SplitStringDelimiter(campaign, 10, '_') = 'ACCONC' THEN 'Acute Care & Oncology'
	WHEN dbo.SplitStringDelimiter(campaign, 10, '_') = 'ADLTMC' THEN 'Adult Medical Care'
	WHEN dbo.SplitStringDelimiter(campaign, 10, '_') = 'GHMICR' THEN 'Gut Health & Microbiome'
	WHEN dbo.SplitStringDelimiter(campaign, 10, '_') = 'HAGCNT' THEN 'Healthy Aging & Cellular Nutrition'
	WHEN dbo.SplitStringDelimiter(campaign, 10, '_') = 'METHLT' THEN 'Metabolic Health'
	WHEN dbo.SplitStringDelimiter(campaign, 10, '_') = 'PEDALG' THEN 'Pediatric Care & Food Allergy'
	WHEN dbo.SplitStringDelimiter(campaign, 10, '_') = 'VITFLO' THEN 'VITAFLO'
	WHEN dbo.SplitStringDelimiter(campaign, 10, '_') = 'VITMIN' THEN 'Vitamins & Mineral Supplements'
	END

FROM [dbo].[Nestle_Search_GoogleAds]
where campaign like 'CA_%'
	)
-- ==== Master Brand Code ==== ---
,MasterBrand_Table 
AS 
(
select B.*, A.[Master Brand] AS [Decoded Master Brand]
from [dbo].[Nestle_SelectionMap_NewConv] A RIGHT JOIN Campaign_Split B on A.[Master Brand Code] = B.[Master Brand]
)
-- ==== Range Code ==== ---
,RangeBrand_Table 
AS
(
select B.*, A.[Range Brand] As [Decoded Range Brand]
from [dbo].[Nestle_SelectionMap_NewConv] A RIGHT JOIN MasterBrand_Table B on A.[Range Brand Code] = B.[Range Brand]
) 
-- ==== Campaign Objective Code ==== ---
,CampaignObjective_Table 
AS
(
select B.*, A.[Campaign Objective] As [Decoded Campaign Objective]
from [dbo].[Nestle_SelectionMap_NewConv] A RIGHT JOIN RangeBrand_Table B on A.[Campaign Objective Code] = B.[Campaign Objective]
) 
/*
-- ==== Search Engine Code ==== ---
,CampaignObjective_Table 
AS
(
select B.*, A.[Campaign Objective] As [Decoded Campaign Objective]
from [dbo].[Nestle_SelectionMap_Social_NewConv] A RIGHT JOIN CampaignType_Table B on A.[Campaign Objective Code] = B.[Campaign Objective]
) 

*/
-- ======== Final View ======== --
,SEM_New_View1
AS
(
select distinct T2.campaign,  
T2.Country, T2.[Master Brand], T2.[Range Brand], T2.[Language], 
T2.[Search Engine], T2.[Targeting Type], T2.[Campaign Match Type], 
T2.[Audience Detail], T2.[Campaign Objective], T2.[Sub-Segment], 
T2.[Local Segment], T2.[Campaign Free Field], T2.[Campaign ID],
T2.[Decoded Campaign Match Type], T2.[Decoded Audience Detail], 
T2.[Decoded Sub-Segment/Category], T2.[Decoded Master Brand], 
T2.[Decoded Range Brand], T2.[Decoded Campaign Objective]
from CampaignObjective_Table T2
--ON T1.campaign = T2.campaign
)
,

SEM_New_View 
AS
(
select T1.*, 
T2.Country, T2.[Master Brand], T2.[Range Brand], T2.[Language], 
T2.[Search Engine], T2.[Targeting Type], T2.[Campaign Match Type], 
T2.[Audience Detail], T2.[Campaign Objective], T2.[Sub-Segment], 
T2.[Local Segment], T2.[Campaign Free Field], T2.[Campaign ID],
T2.[Decoded Campaign Match Type], T2.[Decoded Audience Detail], 
T2.[Decoded Sub-Segment/Category], T2.[Decoded Master Brand], 
T2.[Decoded Range Brand], T2.[Decoded Campaign Objective]
from GoogleAds_Keywords_Table T1 LEFT JOIN SEM_New_View1 T2
ON T1.campaign = T2.campaign
)
,

GoogleAds_Keywords_Brand_Table

AS (
	SELECT *,
		CASE
		--------------------------------BEVERAGES--------------------------------------------------------------
			WHEN LOWER([Decoded Range Brand]) LIKE '%bliss%' OR LOWER([Client Customer Name]) LIKE '%bliss%' THEN 'Beverages-Bliss'
			WHEN (LOWER([Decoded Range Brand]) LIKE '%mate%' OR LOWER([Client Customer Name]) LIKE '%mate%') AND (LOWER(Campaign) LIKE '%coffee%' OR LOWER([Client Customer Name]) LIKE '%coffee%' ) THEN 'Beverages-Coffee Mate'
			WHEN LOWER([Decoded Range Brand]) LIKE '%dolce%' OR LOWER([Client Customer Name]) LIKE '%dolce%' THEN 'Beverages-Dolce Gusto'
			WHEN LOWER([Decoded Range Brand]) LIKE '%gold%' OR LOWER([Client Customer Name]) LIKE '%gold%' THEN 'Beverages-Nescafe Gold'
			WHEN (LOWER([Decoded Range Brand]) LIKE '%time%' OR LOWER([Client Customer Name]) LIKE '%time%') AND (LOWER(Campaign) LIKE '%good%' OR LOWER([Client Customer Name]) LIKE '%good%')  THEN 'Beverages-Good Time'
			WHEN (LOWER([Decoded Range Brand]) LIKE '%sweet%' OR LOWER([Client Customer Name]) LIKE '%sweet%') AND LOWER(Campaign) LIKE '%cream%' OR LOWER([Client Customer Name]) LIKE '%cream%' THEN 'Beverages-Nescafe Sweet & Creamy'
			WHEN LOWER([Decoded Range Brand]) LIKE '%capuccino%' OR LOWER([Client Customer Name]) LIKE '%capuccino%' THEN 'Beverages-Nescafe Capuccino'
		    WHEN LOWER([Decoded Range Brand]) LIKE '%rich%' OR LOWER([Client Customer Name]) LIKE '%rich%' THEN 'Beverages-Nescafe Rich'
			WHEN LOWER([Decoded Range Brand]) LIKE '%kcup%' OR LOWER([Client Customer Name]) LIKE '%kcup%' THEN 'Beverages-Starbucks Kcup'
		    WHEN LOWER([Decoded Range Brand]) LIKE '%nespresso%' OR LOWER([Client Customer Name]) LIKE '%nespresso%' THEN 'Beverages-Starbucks by Nespresso'
		    WHEN LOWER([Decoded Range Brand]) LIKE '%nesquik%' OR LOWER([Client Customer Name]) LIKE '%nesquik%' THEN  'Beverages-Nesquik'
		    WHEN (LOWER([Decoded Range Brand]) LIKE '%cpg%' OR LOWER([Client Customer Name]) LIKE '%cpg%') AND (LOWER(Campaign) LIKE '%starbucks%' OR LOWER([Client Customer Name]) LIKE '%starbucks%')  THEN 'Beverages-Starbucks-CPG At Home Coffee'
	
			-----------------------------------CONFECTIONERY------------------------------------------------------------
			WHEN LOWER([Decoded Range Brand]) LIKE '%aero%' OR LOWER([Client Customer Name]) LIKE  '%aero%' THEN 'Confectionery-Aero'
			WHEN LOWER([Decoded Range Brand]) LIKE '%baci%' OR LOWER([Client Customer Name]) LIKE '%baci%' THEN 'Confectionery-Baci'
			WHEN (LOWER([Decoded Range Brand]) LIKE '%crisp%' OR LOWER([Client Customer Name]) LIKE '%crisp%') AND (LOWER(Campaign) LIKE '%coffee%' OR LOWER([Client Customer Name]) LIKE '%coffee%') THEN 'Confectionery-Coffee Crisp'
			WHEN (LOWER([Decoded Range Brand]) LIKE '%kit%' OR LOWER([Client Customer Name]) LIKE '%kit%') AND (LOWER(Campaign) LIKE '%kat%' OR LOWER([Client Customer Name]) LIKE '%kat%')  THEN 'Confectionery-Kit Kat'
			WHEN LOWER([Decoded Range Brand]) LIKE '%telier%' OR LOWER([Client Customer Name]) LIKE '%telier%' THEN 'Confectionery-L''Atelier'
			WHEN LOWER([Decoded Range Brand]) LIKE '%minis%' OR LOWER([Client Customer Name]) LIKE '%minis%' THEN 'Confectionery-Minis'
			WHEN LOWER([Decoded Range Brand]) LIKE '%smarties%' OR LOWER([Client Customer Name]) LIKE '%smarties%'THEN 'Confectionery-Smarties'
			WHEN LOWER([Decoded Range Brand]) LIKE '%turtles%' OR LOWER([Client Customer Name]) LIKE '%turtles%' THEN 'Confectionery-Turtles'
			-----------------------------------CORPORATE--------------------------------------------------------------------
			--WHEN (LOWER(Campaign) LIKE '%corp%' OR LOWER([Client Customer Name]) LIKE  '%corp%') AND FilterName is NULL THEN 'Corporate-Corporate'

            -----------------------------------FROZEN-----------------------------------------------------------------------
			WHEN LOWER([Decoded Range Brand]) LIKE '%delissio%'  OR LOWER([Client Customer Name]) LIKE '%delissio%' THEN 'Frozen-Delissio'
			WHEN (LOWER([Decoded Range Brand]) LIKE '%lean%'  OR LOWER([Client Customer Name]) LIKE '%lean%') AND (LOWER(Campaign) LIKE '%cuisine%' OR LOWER([Client Customer Name]) LIKE '%cuisine%') THEN 'Frozen-Lean Cuisine'
			WHEN LOWER([Decoded Range Brand]) LIKE '%market%'  OR LOWER([Client Customer Name]) LIKE '%market%' AND (LOWER(Campaign) LIKE '%cuisine%' OR LOWER([Client Customer Name]) LIKE '%cuisine%')  THEN 'Frozen-Marketplace Cuisine'
			WHEN LOWER([Decoded Range Brand]) LIKE '%stouffer%'  OR LOWER([Client Customer Name]) LIKE '%stouffer%'  THEN 'Frozen-Stouffers'
			

			-----------------------------------HEALTH-SCIENCES-------------------------------------------------------------

			WHEN LOWER([Decoded Range Brand]) LIKE '%boost%' OR LOWER([Client Customer Name]) LIKE '%boost%'  THEN 'Health Sciences-Boost'
			WHEN ( LOWER([Decoded Range Brand]) LIKE '%break%' OR LOWER([Client Customer Name]) LIKE '%break%') AND ( LOWER(Campaign) LIKE '%carnation%' OR LOWER([Client Customer Name]) LIKE '%carnation%') THEN 'Health Sciences-Carnation Breakfast'
			WHEN (LOWER([Decoded Range Brand]) LIKE '%adult%' OR LOWER([Client Customer Name]) LIKE '%adult%' ) AND (LOWER(Campaign) LIKE '%compleat%' OR LOWER([Client Customer Name]) LIKE '%compleat%' ) THEN 'Health Sciences-Compleat Adult'
			WHEN LOWER([Decoded Range Brand]) LIKE '%pediatric%' OR LOWER([Client Customer Name]) LIKE '%pediatric%' THEN 'Health Sciences-Compleat Pediatric'
			WHEN LOWER([Decoded Range Brand]) LIKE '%resource%' OR LOWER([Client Customer Name]) LIKE '%resource%'  THEN 'Health Sciences-Resources2.0'
			WHEN LOWER([Decoded Range Brand]) LIKE '%thicken%' OR LOWER([Client Customer Name]) LIKE '%thicken%'  THEN 'Health Sciences-Thicken Up'
			WHEN (LOWER([Decoded Range Brand]) LIKE '%soothe%' OR LOWER([Client Customer Name]) LIKE '%soothe%') AND (LOWER(Campaign) LIKE '%boost%' OR LOWER([Client Customer Name]) LIKE '%boost%' )  THEN 'Health Sciences-Boost Soothe'
		    WHEN (LOWER([Decoded Range Brand]) LIKE '%complete%' OR LOWER([Client Customer Name]) LIKE '%complete%') AND (LOWER(Campaign) LIKE '%boost%' OR LOWER([Client Customer Name]) LIKE '%boost%' )  THEN 'Health Sciences-Boost Complete+'
			
			---------------------------------------ICE-CREAM-------------------------------------------------------------------

			WHEN (LOWER([Decoded Range Brand]) LIKE '%north%' OR LOWER([Client Customer Name]) LIKE '%north%') AND (LOWER(Campaign) LIKE '%good%' OR LOWER([Client Customer Name]) LIKE '%good%' )  THEN 'Ice Cream-Good North'
			WHEN LOWER([Decoded Range Brand]) LIKE '%haagen%' OR LOWER([Client Customer Name]) LIKE '%haagen%'  THEN 'Ice Cream-Haagen-Dazs'
		    WHEN LOWER([Decoded Range Brand]) LIKE '%drumstick%' OR LOWER([Client Customer Name]) LIKE '%drumstick%' THEN  'Ice Cream-Drumstick'
			
			-------------------------------------------------INFANT-------------------------------------------------------------------
			
			WHEN LOWER([Decoded Range Brand]) LIKE '%gerber%' OR LOWER([Client Customer Name]) LIKE '%gerber%' THEN 'Infant Nutrition-Gerber'
			WHEN (LOWER([Decoded Range Brand]) LIKE '%start%' OR LOWER([Client Customer Name]) LIKE '%start%') AND (LOWER(Campaign) LIKE '%good%' OR LOWER([Client Customer Name]) LIKE '%good%') THEN 'Infant Nutrition-Good Start'
			WHEN LOWER([Decoded Range Brand]) LIKE '%materna%' OR LOWER([Client Customer Name]) LIKE '%materna%'  THEN 'Infant Nutrition-Materna'
			WHEN (LOWER([Decoded Range Brand]) LIKE '%baby%' OR LOWER([Account]) LIKE '%baby%' OR LOWER(Campaign) LIKE '%swsw%' OR LOWER([Account]) LIKE '%swsw%') AND (LOWER(Campaign) NOT LIKE '%cetaphil%' OR LOWER([Account]) NOT LIKE '%cetaphil%' ) THEN 'Infant-Nestle Baby'
			
        
		    ----------------------------------------PURINA------------------------------------------------------------------------------

			WHEN LOWER([Decoded Range Brand]) LIKE '%beneful%' OR LOWER([Client Customer Name]) LIKE '%beneful%'  THEN 'Purina-Beneful'
			WHEN LOWER([Decoded Range Brand]) LIKE '%catchow%' OR LOWER([Client Customer Name]) LIKE '%catchow%' THEN 'Purina-Cat Chow'
			WHEN LOWER([Decoded Range Brand]) LIKE '%dogchow%' OR LOWER([Client Customer Name]) LIKE '%dogchow%' THEN 'Purina-Dog Chow'
			WHEN LOWER([Decoded Range Brand]) LIKE '%fancy%' OR LOWER([Client Customer Name]) LIKE '%fancy%' THEN 'Purina-Fancy Feast'
			WHEN LOWER([Decoded Range Brand]) LIKE '%ONE%' OR LOWER([Client Customer Name]) LIKE '%ONE%'  THEN 'Purina-ONE'
			WHEN (LOWER([Decoded Range Brand]) LIKE '%pro%' OR LOWER([Client Customer Name]) LIKE '%pro%') AND (LOWER(Campaign) LIKE '%plan%' OR LOWER([Client Customer Name]) LIKE '%plan%') THEN 'Purina-Pro Plan'
			WHEN LOWER([Decoded Range Brand]) LIKE '%tidy%' OR LOWER([Client Customer Name]) LIKE '%tidy%'  THEN 'Purina-Tidy Cats'
			WHEN LOWER([Decoded Range Brand]) LIKE '%beyond%' OR LOWER([Client Customer Name])  LIKE '%beyond%'  THEN 'Purina -Beyond'
		    WHEN LOWER([Decoded Range Brand]) LIKE '%denta%' OR LOWER([Client Customer Name]) LIKE '%denta%'  THEN 'Purina-DentaLife'
		
			-------------------------------------------SKIN-HEALTH--------------------------------------------------------------------------
			WHEN  (LOWER([Decoded Range Brand]) LIKE '%baby%') OR (LOWER([Client Customer Name]) LIKE '%baby%' )AND (LOWER([Client Customer Name]) LIKE '%cetaphil%') THEN 'Skin Health-Cetaphil Baby'
			WHEN  (LOWER([Decoded Range Brand]) LIKE '%core%') OR (LOWER([Client Customer Name]) LIKE '%core%')  AND (LOWER([Client Customer Name]) LIKE '%cetaphil%') THEN 'Skin Health-Cetaphil Core'
			WHEN (LOWER([Decoded Range Brand]) LIKE '%master%') OR (LOWER([Client Customer Name]) LIKE '%master%' AND (LOWER([Client Customer Name]) LIKE '%cetaphil%'))  THEN 'Skin Health-Cetaphil Master brand'
			WHEN LOWER([Decoded Range Brand]) LIKE '%dysport%' OR LOWER([Client Customer Name]) LIKE '%dysport%'  THEN 'Skin Health-Dysport'
			WHEN LOWER([Decoded Range Brand]) LIKE '%excipial%' OR LOWER([Client Customer Name]) LIKE '%excipial%' THEN 'Skin Health-Excipial'
			WHEN LOWER([Decoded Range Brand]) LIKE '%restylane%' OR LOWER([Client Customer Name]) LIKE '%restylane%'  THEN 'Skin Health-Restylane'
			WHEN LOWER([Decoded Range Brand]) LIKE '%rosacea%' OR LOWER([Client Customer Name]) LIKE '%rosacea%' THEN 'Skin Health-Rosacea'
			
			------------------------------------WATERS--------------------------------------------------------------------------------------
	        WHEN LOWER([Decoded Range Brand]) LIKE '%pana%' OR LOWER([Client Customer Name]) LIKE '%pana%'   THEN 'Waters-Aqua Pana'
			WHEN LOWER([Decoded Range Brand]) LIKE '%perrier%' OR LOWER([Client Customer Name]) LIKE '%perrier%'  THEN 'Waters-Perrier'
			WHEN (LOWER([Decoded Range Brand]) LIKE '%life%' OR LOWER([Client Customer Name]) LIKE '%life%' ) 
			     AND ((LOWER([Decoded Range Brand]) NOT LIKE '%fruit%' AND LOWER([Client Customer Name]) NOT LIKE '%fruit%') ) 
			     AND ((LOWER([Decoded Range Brand]) NOT LIKE '%spark%' AND LOWER([Client Customer Name]) NOT LIKE '%spark%') ) THEN 'Waters-Pure Life'
			WHEN LOWER([Decoded Range Brand]) LIKE '%spark%' OR LOWER([Client Customer Name]) LIKE '%spark%'  THEN 'Waters-Pure Life Sparkling'
			WHEN ((LOWER([Decoded Range Brand]) LIKE '%san%' OR LOWER([Client Customer Name]) LIKE '%san%') OR (LOWER(Campaign)  LIKE '%pellegrino%' OR LOWER([Client Customer Name])  LIKE '%pellegrino%')) 
			     AND ((LOWER([Decoded Range Brand]) NOT LIKE '%fruit%' AND LOWER([Client Customer Name]) NOT LIKE '%fruit%') ) 
				 AND ((LOWER([Decoded Range Brand]) NOT LIKE '%spark%' AND LOWER([Client Customer Name]) NOT LIKE '%spark%') ) THEN 'Waters-San Pellegrino'
			WHEN LOWER([Decoded Range Brand]) LIKE '%fruit%' OR LOWER([Client Customer Name]) LIKE '%fruit%' THEN 'Waters-San Pellegrino Fruit'
			
			---------------------------------------OTHERS---------------------------------------------------------------------------------
			ELSE 'Other'
			
			END AS FilterName

	FROM SEM_New_View 

	),
		---- Corp Check loop 2 

GoogleAds_Keywords_Brand_Filter_Table  
AS
(
 (

SELECT *, 
	       CASE
            WHEN (LOWER([Decoded Range Brand]) LIKE '%starbucks%' OR LOWER([Client Customer Name]) LIKE '%starbucks%')AND (FilterName NOT LIKE '%Beverages%') THEN 'Beverages-Starbucks'
			WHEN (((LOWER([Decoded Range Brand]) LIKE '%bev%') AND (LOWER(Campaign) LIKE '%corp%')) OR (LOWER([Client Customer Name]) LIKE '%bev%' AND LOWER([Client Customer Name]) LIKE '%corp%')) AND (FilterName NOT LIKE '%Beverages%') THEN 'Beverages-Beverages Corporate'
			WHEN ((LOWER([Decoded Range Brand]) LIKE '%nescafe%' OR LOWER([Client Customer Name]) LIKE '%nescafe%') AND (FilterName NOT LIKE '%Nescafe%'))THEN 'Beverages-Nescafe'
			WHEN ((LOWER([Decoded Range Brand]) LIKE '%confect%') AND (LOWER(Campaign) LIKE '%corp%')) OR (LOWER([Client Customer Name]) LIKE '%confect%' AND (LOWER([Client Customer Name]) LIKE '%corp%')) AND ( FilterName NOT LIKE '%Confect%')THEN 'Confectionery-Confectionery Corporate'
			WHEN (LOWER([Decoded Range Brand]) LIKE '%corp%' OR LOWER([Client Customer Name]) LIKE  '%corp%') AND FilterName = 'other' THEN 'Corporate-Corporate'
			WHEN ((LOWER([Decoded Range Brand]) LIKE '%frozen%') AND (LOWER(Campaign) LIKE '%corp%')) OR (LOWER([Client Customer Name]) LIKE '%frozen%' AND (LOWER([Client Customer Name]) LIKE '%corp%')) AND (FilterName NOT LIKE '%Frozen%') THEN 'Frozen-Frozen Corporate'
			WHEN ((LOWER([Decoded Range Brand]) LIKE '%frozen%') AND (LOWER(Campaign) LIKE '%corp%')) OR (LOWER([Client Customer Name]) LIKE '%frozen%' AND (LOWER([Client Customer Name]) LIKE '%corp%')) AND (FilterName NOT LIKE '%Frozen%') THEN 'Frozen-Frozen Corporate'
			WHEN ((LOWER([Decoded Range Brand]) LIKE '%health%') AND (LOWER(Campaign) LIKE '%corp%')) OR (LOWER([Client Customer Name]) LIKE '%health%' AND (LOWER([Client Customer Name]) LIKE '%corp%')) AND (FilterName NOT LIKE '%Health%') THEN 'Health Sciences-Health Sciences Corporate'
			WHEN ((LOWER([Decoded Range Brand]) LIKE '%ice%') AND (LOWER(Campaign) LIKE '%corp%')) OR (LOWER([Client Customer Name]) LIKE '%ice%' AND (LOWER([Client Customer Name]) LIKE '%corp%')) AND (FilterName NOT LIKE '%Ice%') THEN 'Ice Cream-Ice Cream Corporate'
			WHEN ((LOWER([Decoded Range Brand]) LIKE '%infant%') AND (LOWER(Campaign) LIKE '%corp%')) OR (LOWER([Client Customer Name]) LIKE '%infant%' AND (LOWER([Client Customer Name]) LIKE '%corp%')) AND( FilterName NOT LIKE '%Infant%') THEN 'Infant Nutrition-Infant Nutrition Corporate'
			WHEN(LOWER([Decoded Range Brand]) LIKE '%water%') AND (LOWER(Campaign) LIKE '%corp%') OR (LOWER([Client Customer Name]) LIKE '%water%' AND (LOWER([Client Customer Name]) LIKE '%corp%')) AND (FilterName NOT LIKE '%Waters%') THEN 'Waters-Waters Corporate'
			WHEN (LOWER([Decoded Range Brand]) LIKE '%skin%') AND (LOWER(Campaign) LIKE '%corp%') OR (LOWER([Client Customer Name]) LIKE '%skin%' AND (LOWER([Client Customer Name]) LIKE '%corp%')) AND( FilterName NOT LIKE '%Skin%')  THEN 'Skin Health-Skin Health Corporate'
			WHEN ((LOWER([Decoded Range Brand]) LIKE '%purina%') AND (LOWER(Campaign) LIKE '%corp%')) OR (LOWER([Client Customer Name]) LIKE '%purina%' AND (LOWER([Client Customer Name]) LIKE '%corp%')) AND (FilterName NOT LIKE '%Purina%') THEN 'Purina-Purina Corporate'
			WHEN ((LOWER([Decoded Range Brand]) LIKE '%master%' OR LOWER([Client Customer Name])  LIKE '%purina%') AND (LOWER(Campaign) LIKE '%master%' OR LOWER([Client Customer Name])  LIKE '%purina%')) AND (FilterName NOT LIKE '%Purina%' AND FilterName NOT LIKE '%Skin%') THEN 'Purina-Purina Master Brand'
			ELSE FilterName
			END AS FilterNameUpdated
			FROM GoogleAds_Keywords_Brand_Table
			where (Network not in ('YouTube Videos','Cross-network','Display Network'))
			)
),

SEM_Final_View
AS
(
SELECT *
FROM GoogleAds_Keywords_Brand_Filter_Table AS a
RIGHT JOIN [dbo].[Nestle_All_Brand_List] AS b ON a.FilterNameUpdated = b.Brand
where Date is not null
)

select * from SEM_Final_View
