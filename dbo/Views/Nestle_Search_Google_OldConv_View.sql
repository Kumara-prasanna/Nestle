










CREATE VIEW [dbo].[Nestle_Search_Google_OldConv_View] 

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
CASE WHEN (([campaign] like 'CA_%' and YEAR(dt_Created)='2020') OR [campaign] like '2020%' OR [campaign] like '20%') THEN '2020'
	 WHEN ([campaign] like '2019%' OR [campaign] like '19%')THEN '2019'
	 WHEN ([campaign] like '2018%' OR [campaign] like '18%') THEN '2018'
	 WHEN [campaign] like '2017%' THEN '2017'
	 ELSE 'X-Year'
END AS 'Campaign_Year',
'Nestle_Google_Ads' as [table]
FROM [Nestle_Search_GoogleAds]
WHERE  [campaign] not like 'CA_%'
and (clicks > 0 or impressions > 0)
and (Network not in ('YouTube Videos','Cross-network','Display Network'))



UNION all

SELECT	NULL AS 'Account',
		NULL AS 'All Conversions',
		NULL AS 'All Conversions Value',
		[campaign] AS 'Campaign',
		[clicks] AS 'Clicks',
		[client_customer_name] AS 'Client Customer Name',
		[conversions] AS 'Conversions',
		NULL AS 'Cost',
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
		NULL AS 'Search Impression Share',
CASE WHEN ([campaign] like 'CA_%' and YEAR(dt_Created)='2020') OR [campaign] like '2020%' OR [campaign] like '20%'THEN '2020'
	WHEN ([campaign] like '2019%' OR [campaign] like '19%')THEN '2019'
	WHEN ([campaign] like '2018%' OR [campaign] like '18%') THEN '2018'
	WHEN [campaign] like '2017%' THEN '2017'
	ELSE 'X-Year'
END AS 'Campaign_Year',
		'Nestle_Google_Ads_KW' as [table]
FROM  [Nestle_Search_GoogleAds_KW]
WHERE  [campaign] not like 'CA_%'
and (clicks > 0 or impressions > 0)
and (Network not in ('YouTube Videos','Cross-network','Display Network'))

)
	),

	
GoogleAds_Keywords_Brand_Table

AS (
	SELECT *,
		CASE
		--------------------------------BEVERAGES--------------------------------------------------------------
			WHEN LOWER(Campaign) LIKE '%bliss%' OR LOWER([Client Customer Name]) LIKE '%bliss%' THEN 'Beverages-Bliss'
			WHEN (LOWER(Campaign) LIKE '%mate%' OR LOWER([Client Customer Name]) LIKE '%mate%') AND (LOWER(Campaign) LIKE '%coffee%' OR LOWER([Client Customer Name]) LIKE '%coffee%' ) THEN 'Beverages-Coffee Mate'
			WHEN LOWER(Campaign) LIKE '%dolce%' OR LOWER([Client Customer Name]) LIKE '%dolce%' THEN 'Beverages-Dolce Gusto'
			WHEN LOWER(Campaign) LIKE '%gold%' OR LOWER([Client Customer Name]) LIKE '%gold%' THEN 'Beverages-Nescafe Gold'
			WHEN (LOWER(Campaign) LIKE '%time%' OR LOWER([Client Customer Name]) LIKE '%time%') AND (LOWER(Campaign) LIKE '%good%' OR LOWER([Client Customer Name]) LIKE '%good%')  THEN 'Beverages-Good Time'
			WHEN (LOWER(Campaign) LIKE '%sweet%' OR LOWER([Client Customer Name]) LIKE '%sweet%') AND LOWER(Campaign) LIKE '%cream%' OR LOWER([Client Customer Name]) LIKE '%cream%' THEN 'Beverages-Nescafe Sweet & Creamy'
			WHEN LOWER(Campaign) LIKE '%capuccino%' OR LOWER([Client Customer Name]) LIKE '%capuccino%' THEN 'Beverages-Nescafe Capuccino'
		    WHEN LOWER(Campaign) LIKE '%rich%' OR LOWER([Client Customer Name]) LIKE '%rich%' THEN 'Beverages-Nescafe Rich'
			WHEN LOWER(Campaign) LIKE '%kcup%' OR LOWER([Client Customer Name]) LIKE '%kcup%' THEN 'Beverages-Starbucks Kcup'
		    WHEN LOWER(Campaign) LIKE '%nespresso%' OR LOWER([Client Customer Name]) LIKE '%nespresso%' THEN 'Beverages-Starbucks by Nespresso'
		    WHEN LOWER(Campaign) LIKE '%nesquik%' OR LOWER([Client Customer Name]) LIKE '%nesquik%' THEN  'Beverages-Nesquik'
		    WHEN (LOWER(Campaign) LIKE '%cpg%' OR LOWER([Client Customer Name]) LIKE '%cpg%') AND (LOWER(Campaign) LIKE '%starbucks%' OR LOWER([Client Customer Name]) LIKE '%starbucks%')  THEN 'Beverages-Starbucks-CPG At Home Coffee'
	
			-----------------------------------CONFECTIONERY------------------------------------------------------------
			WHEN LOWER(Campaign) LIKE '%aero%' OR LOWER([Client Customer Name]) LIKE  '%aero%' THEN 'Confectionery-Aero'
			WHEN LOWER(Campaign) LIKE '%baci%' OR LOWER([Client Customer Name]) LIKE '%baci%' THEN 'Confectionery-Baci'
			WHEN (LOWER(Campaign) LIKE '%crisp%' OR LOWER([Client Customer Name]) LIKE '%crisp%') AND (LOWER(Campaign) LIKE '%coffee%' OR LOWER([Client Customer Name]) LIKE '%coffee%') THEN 'Confectionery-Coffee Crisp'
			WHEN (LOWER(Campaign) LIKE '%kit%' OR LOWER([Client Customer Name]) LIKE '%kit%') AND (LOWER(Campaign) LIKE '%kat%' OR LOWER([Client Customer Name]) LIKE '%kat%')  THEN 'Confectionery-Kit Kat'
			WHEN LOWER(Campaign) LIKE '%telier%' OR LOWER([Client Customer Name]) LIKE '%telier%' THEN 'Confectionery-L''Atelier'
			WHEN LOWER(Campaign) LIKE '%minis%' OR LOWER([Client Customer Name]) LIKE '%minis%' THEN 'Confectionery-Minis'
			WHEN LOWER(Campaign) LIKE '%smarties%' OR LOWER([Client Customer Name]) LIKE '%smarties%'THEN 'Confectionery-Smarties'
			WHEN LOWER(Campaign) LIKE '%turtles%' OR LOWER([Client Customer Name]) LIKE '%turtles%' THEN 'Confectionery-Turtles'
			-----------------------------------CORPORATE--------------------------------------------------------------------
			--WHEN (LOWER(Campaign) LIKE '%corp%' OR LOWER([Client Customer Name]) LIKE  '%corp%') AND FilterName is NULL THEN 'Corporate-Corporate'

            -----------------------------------FROZEN-----------------------------------------------------------------------
			WHEN LOWER(Campaign) LIKE '%delissio%'  OR LOWER([Client Customer Name]) LIKE '%delissio%' THEN 'Frozen-Delissio'
			WHEN (LOWER(Campaign) LIKE '%lean%'  OR LOWER([Client Customer Name]) LIKE '%lean%') AND (LOWER(Campaign) LIKE '%cuisine%' OR LOWER([Client Customer Name]) LIKE '%cuisine%') THEN 'Frozen-Lean Cuisine'
			WHEN LOWER(Campaign) LIKE '%market%'  OR LOWER([Client Customer Name]) LIKE '%market%' AND (LOWER(Campaign) LIKE '%cuisine%' OR LOWER([Client Customer Name]) LIKE '%cuisine%')  THEN 'Frozen-Marketplace Cuisine'
			WHEN LOWER(Campaign) LIKE '%stouffer%'  OR LOWER([Client Customer Name]) LIKE '%stouffer%'  THEN 'Frozen-Stouffers'
			

			-----------------------------------HEALTH-SCIENCES-------------------------------------------------------------

			WHEN LOWER(Campaign) LIKE '%boost%' OR LOWER([Client Customer Name]) LIKE '%boost%'  THEN 'Health Sciences-Boost'
			WHEN ( LOWER(Campaign) LIKE '%break%' OR LOWER([Client Customer Name]) LIKE '%break%') AND ( LOWER(Campaign) LIKE '%carnation%' OR LOWER([Client Customer Name]) LIKE '%carnation%') THEN 'Health Sciences-Carnation Breakfast'
			WHEN (LOWER(Campaign) LIKE '%adult%' OR LOWER([Client Customer Name]) LIKE '%adult%' ) AND (LOWER(Campaign) LIKE '%compleat%' OR LOWER([Client Customer Name]) LIKE '%compleat%' ) THEN 'Health Sciences-Compleat Adult'
			WHEN LOWER(Campaign) LIKE '%pediatric%' OR LOWER([Client Customer Name]) LIKE '%pediatric%' THEN 'Health Sciences-Compleat Pediatric'
			WHEN LOWER(Campaign) LIKE '%resource%' OR LOWER([Client Customer Name]) LIKE '%resource%'  THEN 'Health Sciences-Resources2.0'
			WHEN LOWER(Campaign) LIKE '%thicken%' OR LOWER([Client Customer Name]) LIKE '%thicken%'  THEN 'Health Sciences-Thicken Up'
			WHEN (LOWER(Campaign) LIKE '%soothe%' OR LOWER([Client Customer Name]) LIKE '%soothe%') AND (LOWER(Campaign) LIKE '%boost%' OR LOWER([Client Customer Name]) LIKE '%boost%' )  THEN 'Health Sciences-Boost Soothe'
		    WHEN (LOWER(Campaign) LIKE '%complete%' OR LOWER([Client Customer Name]) LIKE '%complete%') AND (LOWER(Campaign) LIKE '%boost%' OR LOWER([Client Customer Name]) LIKE '%boost%' )  THEN 'Health Sciences-Boost Complete+'
			
			---------------------------------------ICE-CREAM-------------------------------------------------------------------

			WHEN (LOWER(Campaign) LIKE '%north%' OR LOWER([Client Customer Name]) LIKE '%north%') AND (LOWER(Campaign) LIKE '%good%' OR LOWER([Client Customer Name]) LIKE '%good%' )  THEN 'Ice Cream-Good North'
			WHEN LOWER(Campaign) LIKE '%haagen%' OR LOWER([Client Customer Name]) LIKE '%haagen%'  THEN 'Ice Cream-Haagen-Dazs'
		    WHEN LOWER(Campaign) LIKE '%drumstick%' OR LOWER([Client Customer Name]) LIKE '%drumstick%' THEN  'Ice Cream-Drumstick'
			
			-------------------------------------------------INFANT-------------------------------------------------------------------
			
			WHEN LOWER(Campaign) LIKE '%gerber%' OR LOWER([Client Customer Name]) LIKE '%gerber%' THEN 'Infant Nutrition-Gerber'
			WHEN (LOWER(Campaign) LIKE '%start%' OR LOWER([Client Customer Name]) LIKE '%start%') AND (LOWER(Campaign) LIKE '%good%' OR LOWER([Client Customer Name]) LIKE '%good%') THEN 'Infant Nutrition-Good Start'
			WHEN LOWER(Campaign) LIKE '%materna%' OR LOWER([Client Customer Name]) LIKE '%materna%'  THEN 'Infant Nutrition-Materna'
			WHEN (LOWER(Campaign) LIKE '%baby%' OR LOWER([Account]) LIKE '%baby%' OR LOWER(Campaign) LIKE '%swsw%' OR LOWER([Account]) LIKE '%swsw%') AND (LOWER(Campaign) NOT LIKE '%cetaphil%' OR LOWER([Account]) NOT LIKE '%cetaphil%' ) THEN 'Infant-Nestle Baby'
			
        
		    ----------------------------------------PURINA------------------------------------------------------------------------------

			WHEN LOWER(Campaign) LIKE '%beneful%' OR LOWER([Client Customer Name]) LIKE '%beneful%'  THEN 'Purina-Beneful'
			WHEN LOWER(Campaign) LIKE '%catchow%' OR LOWER([Client Customer Name]) LIKE '%catchow%' THEN 'Purina-Cat Chow'
			WHEN LOWER(Campaign) LIKE '%dogchow%' OR LOWER([Client Customer Name]) LIKE '%dogchow%' THEN 'Purina-Dog Chow'
			WHEN LOWER(Campaign) LIKE '%fancy%' OR LOWER([Client Customer Name]) LIKE '%fancy%' THEN 'Purina-Fancy Feast'
			WHEN LOWER(Campaign) LIKE '%ONE%' OR LOWER([Client Customer Name]) LIKE '%ONE%'  THEN 'Purina-ONE'
			WHEN (LOWER(Campaign) LIKE '%pro%' OR LOWER([Client Customer Name]) LIKE '%pro%') AND (LOWER(Campaign) LIKE '%plan%' OR LOWER([Client Customer Name]) LIKE '%plan%') THEN 'Purina-Pro Plan'
			WHEN LOWER(Campaign) LIKE '%tidy%' OR LOWER([Client Customer Name]) LIKE '%tidy%'  THEN 'Purina-Tidy Cats'
			WHEN LOWER(Campaign) LIKE '%beyond%' OR LOWER([Client Customer Name])  LIKE '%beyond%'  THEN 'Purina -Beyond'
		    WHEN LOWER(Campaign) LIKE '%denta%' OR LOWER([Client Customer Name]) LIKE '%denta%'  THEN 'Purina-DentaLife'
		
			-------------------------------------------SKIN-HEALTH--------------------------------------------------------------------------
			WHEN  (LOWER(Campaign) LIKE '%baby%') OR (LOWER([Client Customer Name]) LIKE '%baby%' )AND (LOWER([Client Customer Name]) LIKE '%cetaphil%') THEN 'Skin Health-Cetaphil Baby'
			WHEN  (LOWER(Campaign) LIKE '%core%') OR (LOWER([Client Customer Name]) LIKE '%core%')  AND (LOWER([Client Customer Name]) LIKE '%cetaphil%') THEN 'Skin Health-Cetaphil Core'
			WHEN (LOWER(Campaign) LIKE '%master%') OR (LOWER([Client Customer Name]) LIKE '%master%' AND (LOWER([Client Customer Name]) LIKE '%cetaphil%'))  THEN 'Skin Health-Cetaphil Master brand'
			WHEN LOWER(Campaign) LIKE '%dysport%' OR LOWER([Client Customer Name]) LIKE '%dysport%'  THEN 'Skin Health-Dysport'
			WHEN LOWER(Campaign) LIKE '%excipial%' OR LOWER([Client Customer Name]) LIKE '%excipial%' THEN 'Skin Health-Excipial'
			WHEN LOWER(Campaign) LIKE '%restylane%' OR LOWER([Client Customer Name]) LIKE '%restylane%'  THEN 'Skin Health-Restylane'
			WHEN LOWER(Campaign) LIKE '%rosacea%' OR LOWER([Client Customer Name]) LIKE '%rosacea%' THEN 'Skin Health-Rosacea'
			
			------------------------------------WATERS--------------------------------------------------------------------------------------
	        WHEN LOWER(Campaign) LIKE '%pana%' OR LOWER([Client Customer Name]) LIKE '%pana%'   THEN 'Waters-Aqua Pana'
			WHEN LOWER(Campaign) LIKE '%perrier%' OR LOWER([Client Customer Name]) LIKE '%perrier%'  THEN 'Waters-Perrier'
			WHEN (LOWER(Campaign) LIKE '%life%' OR LOWER([Client Customer Name]) LIKE '%life%' ) 
			     AND ((LOWER(Campaign) NOT LIKE '%fruit%' AND LOWER([Client Customer Name]) NOT LIKE '%fruit%') ) 
			     AND ((LOWER(Campaign) NOT LIKE '%spark%' AND LOWER([Client Customer Name]) NOT LIKE '%spark%') ) THEN 'Waters-Pure Life'
			WHEN LOWER(Campaign) LIKE '%spark%' OR LOWER([Client Customer Name]) LIKE '%spark%'  THEN 'Waters-Pure Life Sparkling'
			WHEN ((LOWER(Campaign) LIKE '%san%' OR LOWER([Client Customer Name]) LIKE '%san%') OR (LOWER(Campaign)  LIKE '%pellegrino%' OR LOWER([Client Customer Name])  LIKE '%pellegrino%')) 
			     AND ((LOWER(Campaign) NOT LIKE '%fruit%' AND LOWER([Client Customer Name]) NOT LIKE '%fruit%') ) 
				 AND ((LOWER(Campaign) NOT LIKE '%spark%' AND LOWER([Client Customer Name]) NOT LIKE '%spark%') ) THEN 'Waters-San Pellegrino'
			WHEN LOWER(Campaign) LIKE '%fruit%' OR LOWER([Client Customer Name]) LIKE '%fruit%' THEN 'Waters-San Pellegrino Fruit'
			
			---------------------------------------OTHERS---------------------------------------------------------------------------------
			ELSE 'Other'
			
			END AS FilterName,
--Social - The campaign names mostly has english , french, FR, EN values - 
--setting up column language based on  pattern matching
		CASE
			WHEN LOWER(Campaign) LIKE '%english%' OR (Campaign LIKE '%/_EN%' Escape '/') OR (Campaign LIKE '%| EN%') OR (Campaign LIKE '%|EN%') THEN 'English'
			WHEN LOWER(Campaign) LIKE '%french%' OR  (Campaign LIKE '%/_FR%'  Escape '/' ) OR (Campaign LIKE '%| FR%' Escape '|') OR (Campaign LIKE '%|FR%' Escape '|') THEN 'French'
			ELSE 'Unknown'
			END AS [Language],
      
		CASE 
	     
	WHEN LOWER(Campaign) LIKE '%auto%' OR Lower(Labels) LIKE '%auto%' THEN 'Automatic'
	WHEN LOWER(Campaign) LIKE '%generic%' OR Lower(Labels) LIKE '%generic%' THEN 'Non-Brand'
	WHEN ( LOWER(Campaign) LIKE '%competitive%' OR LOWER(Campaign) LIKE '%_comp%' )  THEN 'Competitive'
	WHEN (Campaign LIKE '%/_NB%' Escape '/' )   OR LOWER(Campaign) LIKE '%non brand%' OR LOWER(Campaign) LIKE '%nonbrand%' OR LOWER(Labels) LIKE '%non-brand%'  THEN 'Non-Brand'
	WHEN (Campaign Like '%/_BR%'  Escape '/' )  OR LOWER(Campaign) LIKE '%brand%'  THEN 'Brand'
	WHEN LOWER(Campaign) LIKE '%category%' OR Lower(Labels) LIKE 'category' THEN 'Non-Brand'
	ELSE 'Other'
	END AS [Targeting]

	FROM GoogleAds_Keywords_Table 

	)

,

	---- Corp Check loop 2 

GoogleAds_Keywords_Brand_Filter_Table  
AS
(
 (

SELECT *, 
	       CASE
            WHEN (LOWER(Campaign) LIKE '%starbucks%' OR LOWER([Client Customer Name]) LIKE '%starbucks%')AND (FilterName NOT LIKE '%Beverages%') THEN 'Beverages-Starbucks'
			WHEN (((LOWER(Campaign) LIKE '%bev%') AND (LOWER(Campaign) LIKE '%corp%')) OR (LOWER([Client Customer Name]) LIKE '%bev%' AND LOWER([Client Customer Name]) LIKE '%corp%')) AND (FilterName NOT LIKE '%Beverages%') THEN 'Beverages-Beverages Corporate'
			WHEN ((LOWER(Campaign) LIKE '%nescafe%' OR LOWER([Client Customer Name]) LIKE '%nescafe%') AND (FilterName NOT LIKE '%Nescafe%'))THEN 'Beverages-Nescafe'
			WHEN ((LOWER(Campaign) LIKE '%confect%') AND (LOWER(Campaign) LIKE '%corp%')) OR (LOWER([Client Customer Name]) LIKE '%confect%' AND (LOWER([Client Customer Name]) LIKE '%corp%')) AND ( FilterName NOT LIKE '%Confect%')THEN 'Confectionery-Confectionery Corporate'
			WHEN (LOWER(Campaign) LIKE '%corp%' OR LOWER([Client Customer Name]) LIKE  '%corp%') AND FilterName = 'other' THEN 'Corporate-Corporate'
			WHEN ((LOWER(Campaign) LIKE '%frozen%') AND (LOWER(Campaign) LIKE '%corp%')) OR (LOWER([Client Customer Name]) LIKE '%frozen%' AND (LOWER([Client Customer Name]) LIKE '%corp%')) AND (FilterName NOT LIKE '%Frozen%') THEN 'Frozen-Frozen Corporate'
			WHEN ((LOWER(Campaign) LIKE '%frozen%') AND (LOWER(Campaign) LIKE '%corp%')) OR (LOWER([Client Customer Name]) LIKE '%frozen%' AND (LOWER([Client Customer Name]) LIKE '%corp%')) AND (FilterName NOT LIKE '%Frozen%') THEN 'Frozen-Frozen Corporate'
			WHEN ((LOWER(Campaign) LIKE '%health%') AND (LOWER(Campaign) LIKE '%corp%')) OR (LOWER([Client Customer Name]) LIKE '%health%' AND (LOWER([Client Customer Name]) LIKE '%corp%')) AND (FilterName NOT LIKE '%Health%') THEN 'Health Sciences-Health Sciences Corporate'
			WHEN ((LOWER(Campaign) LIKE '%ice%') AND (LOWER(Campaign) LIKE '%corp%')) OR (LOWER([Client Customer Name]) LIKE '%ice%' AND (LOWER([Client Customer Name]) LIKE '%corp%')) AND (FilterName NOT LIKE '%Ice%') THEN 'Ice Cream-Ice Cream Corporate'
			WHEN ((LOWER(Campaign) LIKE '%infant%') AND (LOWER(Campaign) LIKE '%corp%')) OR (LOWER([Client Customer Name]) LIKE '%infant%' AND (LOWER([Client Customer Name]) LIKE '%corp%')) AND( FilterName NOT LIKE '%Infant%') THEN 'Infant Nutrition-Infant Nutrition Corporate'
			WHEN(LOWER(Campaign) LIKE '%water%') AND (LOWER(Campaign) LIKE '%corp%') OR (LOWER([Client Customer Name]) LIKE '%water%' AND (LOWER([Client Customer Name]) LIKE '%corp%')) AND (FilterName NOT LIKE '%Waters%') THEN 'Waters-Waters Corporate'
			WHEN (LOWER(Campaign) LIKE '%skin%') AND (LOWER(Campaign) LIKE '%corp%') OR (LOWER([Client Customer Name]) LIKE '%skin%' AND (LOWER([Client Customer Name]) LIKE '%corp%')) AND( FilterName NOT LIKE '%Skin%')  THEN 'Skin Health-Skin Health Corporate'
			WHEN ((LOWER(Campaign) LIKE '%purina%') AND (LOWER(Campaign) LIKE '%corp%')) OR (LOWER([Client Customer Name]) LIKE '%purina%' AND (LOWER([Client Customer Name]) LIKE '%corp%')) AND (FilterName NOT LIKE '%Purina%') THEN 'Purina-Purina Corporate'
			WHEN ((LOWER(Campaign) LIKE '%master%' OR LOWER([Client Customer Name])  LIKE '%purina%') AND (LOWER(Campaign) LIKE '%master%' OR LOWER([Client Customer Name])  LIKE '%purina%')) AND (FilterName NOT LIKE '%Purina%' AND FilterName NOT LIKE '%Skin%') THEN 'Purina-Purina Master Brand'
			ELSE FilterName
			END AS FilterNameUpdated
			FROM GoogleAds_Keywords_Brand_Table
			)
) ,

GoogleAds_View
AS
(
			
SELECT *
FROM GoogleAds_Keywords_Brand_Filter_Table  AS a
RIGHT JOIN [dbo].[Nestle_All_Brand_List] AS b ON a.FilterNameUpdated = b.Brand
)


SELECT a.*,b.[Branded_CPC], b.[Branded_Impr_Share], b.[Non_Branded_CPC], b.[Non_Branded_Impr_Share],b.[Competitive_CPC],	b.[Competitive_Impr_Share]

FROM  GoogleAds_View  AS a JOIN [dbo].[Nestle_Search_GoogleAds_KPI] as b ON a.Brand = b.Brand
where (Clicks > 0 or Impressions > 0) 


