
CREATE VIEW [dbo].[Nestle_Prog_DV360_View]
AS
WITH DV360_Table
AS (
	(
SELECT campaign AS 'Campaign',
advertiser AS 'Advertiser',
	creative AS 'Creative',
	creative_type,
	[date] AS 'Date' ,
	ad_type AS 'Ad Type',
	creative_attributes AS 'Creative Attribute',
	impressions AS 'Impressions',
	clicks AS 'Clicks',
	total_conversions AS 'Conversions',
	postclick_conversions AS 'Post Click Conversions',
	engagements AS 'Engagements',
	firstquartile_views_video AS 'Video Views - 25%',
	midpoint_views_video AS 'Video Views - 50%',
	thirdquartile_views_video AS 'Video Views - 75%',
	complete_views_video AS 'Video Views - 100%',
	trueview_views AS 'True View Views',
	trueview_view_rate AS 'True View View Rate',
	companion_clicks_video AS 'Companion Clicks Video',
	companion_views_video AS 'Companion Views Video',
	total_media_cost_advertiser_currency AS 'Cost',
	revenue_adv_currency AS 'Revenue',
CASE WHEN campaign LIKE '2020%' THEN '2020'
	 WHEN campaign LIKE '2019%' THEN '2019'
ELSE 'X-Year'
END AS 'Campaign_Year'
FROM dbo.Nestle_Prog_DV360
where lower(advertiser) not like '%for billing purposes%'
and campaign not like 'CAN_%' --excluding Danone campaigns
and (clicks >0 or impressions > 0)
)
	),
DV360_Brand_Table

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
			WHEN LOWER(Creative) LIKE '%english%' OR (Creative LIKE '%/_EN%' Escape '/') THEN 'English'
			WHEN LOWER(Creative) LIKE '%french%' OR  (Creative LIKE '%/_FR%'  Escape '/' ) THEN 'French'
			ELSE 'Unknown'
			END AS [Language],

        CASE
              WHEN LOWER(Creative) LIKE '%catalyst%' THEN 'Catalyst Search'
              WHEN (LOWER(Creative) LIKE '%double%' OR (Campaign like '%RTBV%' AND LOWER(Creative) = 'unknown')) THEN 'Double Click Bid Manager'
              WHEN LOWER(Creative) LIKE '%google%' THEN 'Google'
			  WHEN LOWER(Creative) LIKE '%rogers%' THEN 'Rogers'
			  WHEN LOWER(Creative) LIKE '%bell%' THEN 'Bell'
			  WHEN LOWER(Creative) LIKE '%flip%' THEN 'Flip'
			  WHEN (LOWER(Creative) LIKE '%radiocanada%'  OR LOWER(Creative) LIKE '%radio canada%' ) THEN 'Radio Canada'
			  WHEN (LOWER(Creative) LIKE '%quebecor%'  OR LOWER(Creative) LIKE '%quebec or%' ) THEN 'Quebecor'
			  WHEN (LOWER(Creative) LIKE '%lapresse%'  OR LOWER(Creative) LIKE '%la presse%' ) THEN 'LaPresse'
              ELSE 'Other'
              END AS [Search Partner]

-- Ad Type Category - KB
,CASE
WHEN creative_type = 'Video' THEN 'Video'
WHEN creative_type = 'Audio' THEN 'Audio'
WHEN creative_type = 'Native site' THEN 'Native'
WHEN creative_type = 'Standard' THEN 'Standard'
ELSE 'Others'
END as [Ad_Type_Category]
,
CASE
 WHEN Campaign like '%Pref%' THEN 'GP'
 WHEN Campaign like '%Prog%' THEN 'PG'
END AS 'Campaign Label'

	FROM DV360_Table
	) 

,

---- Corp Check loop 2 

DV360_Brand_Filter_Table  
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
			FROM DV360_Brand_Table
			)
)

SELECT *
FROM 
DV360_Brand_Filter_Table   AS a
RIGHT JOIN [dbo].[Nestle_All_Brand_List] AS b ON a.FilterNameUpdated = b.Brand 
WHERE Advertiser NOT LIKE '%Nespresso%'
			
