

CREATE VIEW [dbo].[Nestle_Prog_GCM_Spend_OldConv_View]
AS
WITH DCM_Table AS (
	(
		SELECT placement AS 'Placement',
			placement_id AS 'Placement ID',
			[date] AS 'Date',
			campaign AS 'Campaign',
			creative,
			creative_type,
			creative_pixel_size,
			sum(impressions) AS 'Impressions',
			sum(clicks) AS 'Clicks',
			sum(total_conversions) AS 'Conversions',
			sum(video_first_quartile_completions) AS 'Video Views - 25%',
			sum(video_midpoints) AS 'Video Views - 50%',
			sum(video_third_quartile_completions) AS 'Video Views - 75%',
			sum(video_completions) AS 'Video Views - 100%',
			sum(total_interactions) AS 'Interactions',
			sum(video_views) AS 'Video Views',
			sum(video_plays) AS 'Video Plays',
			sum(total_revenue) AS 'Revenue'
,CASE WHEN (campaign LIKE '2020%' OR campaign like 'T-N20%' OR campaign like 'L-N20%' OR campaign like 'I-N20%') THEN '2020'
	 WHEN campaign LIKE '2019%' THEN '2019'
	 WHEN (campaign LIKE '18%' OR campaign LIKE '2018%') THEN '2018'
	 WHEN campaign LIKE '2017%' THEN '2017'
	 WHEN campaign LIKE '2016%' THEN '2016'
ELSE 'X-Year'
END AS 'Campaign_Year'

		FROM [dbo].[Nestle_Prog_GCM]
		WHERE campaign not like '%_SOCIAL'
		and (clicks > 0 or impressions > 0)
		GROUP BY placement,
			placement_id,
			[date],
			campaign,
			creative,
			creative_type,
			creative_pixel_size
		)
	),

DCM_Spend_Table AS (
	SELECT d.*,
		s.Flight_Capped_Spend AS 'Spend',
		s.Flight_Budget AS 'Budget'
	FROM [dbo].[Nestle_Prog_GCM_Spend] s
	INNER JOIN DCM_Table d ON s.placement = d.placement
		AND s.[date] = d.[date]
	),


	
DCM_Brand_Table AS (
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
			WHEN LOWER(Placement) LIKE '%english%' OR (Placement LIKE '%/_EN%' Escape '/') THEN 'English'
			WHEN LOWER(Placement) LIKE '%french%' OR  (Placement LIKE '%/_FR%'  Escape '/' ) THEN 'French'
			ELSE 'Unknown'
			END AS [Language],

-- Search Partner 
        CASE
		WHEN LOWER(Placement) LIKE '%amazon%' THEN 'Amazon'
		WHEN (LOWER(Placement) LIKE '%double%' OR LOWER(Placement) LIKE '%dbm%') THEN 'Double Click Bid Manager'
		WHEN LOWER(Placement) LIKE '%google%' THEN 'Google'
		WHEN LOWER(Placement) LIKE '%facebook%' THEN 'Facebook'
		WHEN LOWER(Placement) LIKE '%twitter%' THEN 'Twitter'
		WHEN LOWER(Placement) LIKE '%bell%' THEN 'Bell Media'		
		WHEN (LOWER(Placement) LIKE '%checkout 51%' OR LOWER(Placement) LIKE '%checkout51%') THEN 'Checkout 51'
		WHEN LOWER(Placement) LIKE '%cluep%' THEN 'Cluep'
		WHEN (LOWER(Placement) LIKE '%youtube%' OR LOWER(Placement) LIKE '%yt%' OR LOWER(Placement) LIKE '%you tube%') THEN 'YouTube'
		WHEN LOWER(Placement) LIKE '%rogers%' THEN 'Rogers'
		WHEN LOWER(Placement) LIKE '%verizon%' THEN 'Verizon'
		WHEN LOWER(Placement) LIKE '%flip%' THEN 'Flip'
		WHEN (LOWER(Placement) LIKE '%tradedesk%' OR LOWER(Placement) LIKE '%trade desk%') THEN 'TradeDesk'
		WHEN (LOWER(Placement) LIKE '%petfinder%' OR LOWER(Placement) LIKE '%pet finder%') THEN 'PetFinder'
		WHEN LOWER(Placement) LIKE '%quebecor%' THEN 'Quebecor'
		WHEN LOWER(Placement) LIKE '%lapresse%' THEN 'LaPresse'
		WHEN LOWER(Placement) LIKE '%radiocanada%' THEN 'RadioCanada'
		WHEN (LOWER(Placement) LIKE '%babycenter%' OR LOWER(Placement) LIKE '%baby center%') THEN 'BabyCenter'
		WHEN (LOWER(Placement) LIKE '%amzn%' OR LOWER(Placement) LIKE '%amazon%') THEN 'Amazon'
		WHEN (LOWER(Placement) LIKE '%crucialinteractive%' OR LOWER(Placement) LIKE '%crucial interactive%') THEN 'Crucial Interactive'
		WHEN (LOWER(Placement) LIKE '%newsmarketing%' OR LOWER(Placement) LIKE '%news marketing%') THEN 'News Marketing'
		WHEN LOWER(Placement) LIKE '%teads%' THEN 'Teads'
		ELSE 'Other'
		END AS [Search Partner]

-- Ad_Type_Category - Kamy
,CASE 
	WHEN creative_type = 'In-Stream Audio' THEN 'Audio'
	WHEN creative_type = 'In-Stream Video' THEN 'Video'
	WHEN (creative_type in ('Display','Display redirect')) OR (creative_type = 'Tracking' AND creative_pixel_size not in ('0x0','1x1')) THEN 'Banner'
	WHEN (creative_type = 'Tracking' AND (lower(creative) like '%amazon%' OR lower(placement) like '%banner%')) THEN 'Banner'
	WHEN (creative_type = 'Tracking' AND (lower(creative) like '%video%' OR lower(placement) like '%video%')) THEN 'Video'
	ELSE 'Others'
END as [Ad_Type_Category]

	FROM DCM_Spend_Table
	)

,

	---- Corp Check loop 2 

DCM_Spend_Table_Filter_Table 
AS
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
			FROM DCM_Brand_Table
			)

--Adding Missing Brand names from the default brand list table

SELECT *
FROM 
DCM_Spend_Table_Filter_Table   AS a
RIGHT JOIN [dbo].[Nestle_All_Brand_List] AS b ON a.FilterNameUpdated = b.Brand
-- Removing SOCIAL Camp from Prog View
WHERE Campaign not like '%SOCIAL%'

--- Purina ONE - not going to do a  ONE cat/One Dog campaign name is generic. Is it Pro plan or Pro plan vet diets, Does CBE a category under health sciences.
	


