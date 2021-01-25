

CREATE VIEW [dbo].[Nestle_Prog_GCM_Spend_NewConv_View]
AS

WITH 
DCM_Table 
AS (
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
-- Ad_Type_Category - Kamy
,CASE 
	WHEN creative_type in ('Display','Display redirect') THEN 'Display'
	WHEN creative_type = 'In-Stream Audio' THEN 'Audio'
	WHEN creative_type = 'In-Stream Video' THEN 'Video'
	WHEN (creative_type = 'Tracking' AND creative_pixel_size not in ('0x0','1x1')) THEN 'Banner'
	WHEN (creative_type = 'Tracking' AND (lower(creative) like '%amazon%' OR lower(placement) like '%banner%')) THEN 'Banner'
	WHEN (creative_type = 'Tracking' AND (lower(creative) like '%video%' OR lower(placement) like '%video%')) THEN 'Video'
	ELSE 'Others'
END as [Ad_Type_Category],
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
		FROM [dbo].[Nestle_Prog_GCM]
		where ( clicks >0 or impressions > 0 )
		GROUP BY placement,
			placement_id,
			[date],
			campaign,
			creative,
			creative_type,
			creative_pixel_size

	),

/*
DCM_Spend_Table AS (
	SELECT d.*,
		s.Flight_Capped_Spend AS 'Spend',
		s.Flight_Budget AS 'Budget'
	FROM Nestle_GCM_Spend s
	INNER JOIN DCM_Table d ON s.placement = d.placement
		AND s.[date] = d.[date]
	),
*/
Campaign_Split
AS
(
select distinct
campaign,
dbo.SplitStringDelimiter(campaign, 1, '|') as 'CPE',
dbo.SplitStringDelimiter(campaign, 2, '|') as 'Campaign Name',
right((dbo.SplitStringDelimiter(campaign, 2, '|')),2) as 'Language',
dbo.SplitStringDelimiter(campaign, 3, '|') as 'FreeForm2',
left(dbo.SplitStringDelimiter(campaign, 3, '|'),4) as 'Campaign_Year',
right(dbo.SplitStringDelimiter(campaign, 3, '|'),2) as 'Period',
dbo.SplitStringDelimiter(campaign, 4, '|') as 'Buy Type',
dbo.SplitStringDelimiter(campaign, 5, '|') as 'Agency Holding Group',
dbo.SplitStringDelimiter(campaign, 6, '|') as 'Master Brand',
dbo.SplitStringDelimiter(campaign, 7, '|') as 'Range Brand',
dbo.SplitStringDelimiter(campaign, 8, '|') as 'Segment',
dbo.SplitStringDelimiter(campaign, 9, '|') as 'Market',
dbo.SplitStringDelimiter(campaign, 10, '|') as 'Campaign Type',
dbo.SplitStringDelimiter(campaign, 11, '|') as 'Campaign Objective'
from [dbo].[Nestle_Prog_GCM]
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
-- ==== Segment Code ==== ---
,Segment_Table 
AS
(
select B.*, A.[Segment] As [Decoded Segment]
from [dbo].[Nestle_SelectionMap_NewConv] A RIGHT JOIN RangeBrand_Table B on A.[Segment Code] = B.[Segment]
) 
-- ==== Campaign Type Code ==== ---
,CampaignType_Table 
AS
(
select B.*, A.[Campaign Type] As [Decoded Campaign Type]
from [dbo].[Nestle_SelectionMap_NewConv] A RIGHT JOIN Segment_Table B on A.[Campaign Type Code] = B.[Campaign Type]
) 
-- ==== Campaign Objective Code ==== ---
,CampaignObjective_Table 
AS
(
select B.*, A.[Campaign Objective] As [Decoded Campaign Objective]
from [dbo].[Nestle_SelectionMap_NewConv] A RIGHT JOIN CampaignType_Table B on A.[Campaign Objective Code] = B.[Campaign Objective]
) 
-- ======== Final View ======== --
,GCM_NewConv_View 
AS
(
select T1.*, T2.CPE, T2.[Language], T2.Campaign_Year, T2.[Period], T2.[Buy Type], T2.[Agency Holding Group], T2.[Decoded Master Brand]
, T2.[Decoded Range Brand], T2.[Decoded Segment], T2.[Market], T2.[Decoded Campaign Type], T2.[Decoded Campaign Objective]
from DCM_Table T1 LEFT JOIN CampaignObjective_Table T2
ON T1.campaign = T2.campaign
),
DCM_Brand_Table AS (
		SELECT *,
		CASE
		--------------------------------BEVERAGES--------------------------------------------------------------
			WHEN LOWER([Decoded Range Brand]) LIKE '%bliss%'  THEN 'Beverages-Bliss'
			WHEN (LOWER([Decoded Range Brand]) LIKE '%mate%' ) AND (LOWER([Decoded Range Brand]) LIKE '%coffee%') THEN 'Beverages-Coffee Mate'
			WHEN LOWER([Decoded Range Brand]) LIKE '%dolce%'  THEN 'Beverages-Dolce Gusto'
			WHEN LOWER([Decoded Range Brand]) LIKE '%gold%'  THEN 'Beverages-Nescafe Gold'
			WHEN (LOWER([Decoded Range Brand]) LIKE '%time%' ) AND (LOWER([Decoded Range Brand]) LIKE '%good%')  THEN 'Beverages-Good Time'
			WHEN (LOWER([Decoded Range Brand]) LIKE '%sweet%' ) AND LOWER([Decoded Range Brand]) LIKE '%cream%'  THEN 'Beverages-Nescafe Sweet & Creamy'
			WHEN LOWER([Decoded Range Brand]) LIKE '%capuccino%'  THEN 'Beverages-Nescafe Capuccino'
		    WHEN LOWER([Decoded Range Brand]) LIKE '%rich%'  THEN 'Beverages-Nescafe Rich'
			WHEN LOWER([Decoded Range Brand]) LIKE '%kcup%'  THEN 'Beverages-Starbucks Kcup'
		    WHEN LOWER([Decoded Range Brand]) LIKE '%nespresso%'  THEN 'Beverages-Starbucks by Nespresso'
		    WHEN LOWER([Decoded Range Brand]) LIKE '%nesquik%'  THEN  'Beverages-Nesquik'
		    WHEN (LOWER([Decoded Range Brand]) LIKE '%cpg%' ) AND (LOWER([Decoded Range Brand]) LIKE '%starbucks%' )  THEN 'Beverages-Starbucks-CPG At Home Coffee'
	
			-----------------------------------CONFECTIONERY------------------------------------------------------------
			WHEN LOWER([Decoded Range Brand]) LIKE '%aero%'  THEN 'Confectionery-Aero'
			WHEN LOWER([Decoded Range Brand]) LIKE '%baci%'  THEN 'Confectionery-Baci'
			WHEN (LOWER([Decoded Range Brand]) LIKE '%crisp%' ) AND (LOWER([Decoded Range Brand]) LIKE '%coffee%' ) THEN 'Confectionery-Coffee Crisp'
			WHEN (LOWER([Decoded Range Brand]) LIKE '%kit%' ) AND (LOWER([Decoded Range Brand]) LIKE '%kat%' )  THEN 'Confectionery-Kit Kat'
			WHEN LOWER([Decoded Range Brand]) LIKE '%telier%' THEN 'Confectionery-L''Atelier'
			WHEN LOWER([Decoded Range Brand]) LIKE '%minis%'  THEN 'Confectionery-Minis'
			WHEN LOWER([Decoded Range Brand]) LIKE '%smarties%' THEN 'Confectionery-Smarties'
			WHEN LOWER([Decoded Range Brand]) LIKE '%turtles%' THEN 'Confectionery-Turtles'
			-----------------------------------CORPORATE--------------------------------------------------------------------
			--WHEN (LOWER(Campaign) LIKE '%corp%' OR LOWER([Client Customer Name]) LIKE  '%corp%') AND FilterName is NULL THEN 'Corporate-Corporate'

            -----------------------------------FROZEN-----------------------------------------------------------------------
			WHEN LOWER([Decoded Range Brand]) LIKE '%delissio%'   THEN 'Frozen-Delissio'
			WHEN (LOWER([Decoded Range Brand]) LIKE '%lean%'  ) AND (LOWER([Decoded Range Brand]) LIKE '%cuisine%') THEN 'Frozen-Lean Cuisine'
			WHEN LOWER([Decoded Range Brand]) LIKE '%market%'   AND (LOWER([Decoded Range Brand]) LIKE '%cuisine%' )  THEN 'Frozen-Marketplace Cuisine'
			WHEN LOWER([Decoded Range Brand]) LIKE '%stouffer%'    THEN 'Frozen-Stouffers'
			

			-----------------------------------HEALTH-SCIENCES-------------------------------------------------------------

			WHEN LOWER([Decoded Range Brand]) LIKE '%boost%'  THEN 'Health Sciences-Boost'
			WHEN ( LOWER([Decoded Range Brand]) LIKE '%break%') AND ( LOWER([Decoded Range Brand]) LIKE '%carnation%' ) THEN 'Health Sciences-Carnation Breakfast'
			WHEN (LOWER([Decoded Range Brand]) LIKE '%adult%'  ) AND (LOWER([Decoded Range Brand]) LIKE '%compleat%'  ) THEN 'Health Sciences-Compleat Adult'
			WHEN LOWER([Decoded Range Brand]) LIKE '%pediatric%'  THEN 'Health Sciences-Compleat Pediatric'
			WHEN LOWER([Decoded Range Brand]) LIKE '%resource%'   THEN 'Health Sciences-Resources2.0'
			WHEN LOWER([Decoded Range Brand]) LIKE '%thicken%'   THEN 'Health Sciences-Thicken Up'
			WHEN (LOWER([Decoded Range Brand]) LIKE '%soothe%' ) AND (LOWER([Decoded Range Brand]) LIKE '%boost%'  )  THEN 'Health Sciences-Boost Soothe'
		    WHEN (LOWER([Decoded Range Brand]) LIKE '%complete%' ) AND (LOWER([Decoded Range Brand]) LIKE '%boost%' )  THEN 'Health Sciences-Boost Complete+'
			
			---------------------------------------ICE-CREAM-------------------------------------------------------------------

			WHEN (LOWER([Decoded Range Brand]) LIKE '%north%' ) AND (LOWER([Decoded Range Brand]) LIKE '%good%' )  THEN 'Ice Cream-Good North'
			WHEN LOWER([Decoded Range Brand]) LIKE '%haagen%' THEN 'Ice Cream-Haagen-Dazs'
		    WHEN LOWER([Decoded Range Brand]) LIKE '%drumstick%'  THEN  'Ice Cream-Drumstick'
			
			-------------------------------------------------INFANT-------------------------------------------------------------------
			
			WHEN LOWER([Decoded Range Brand]) LIKE '%gerber%'  THEN 'Infant Nutrition-Gerber'
			WHEN (LOWER([Decoded Range Brand]) LIKE '%start%') AND (LOWER([Decoded Range Brand]) LIKE '%good%' ) THEN 'Infant Nutrition-Good Start'
			WHEN LOWER([Decoded Range Brand]) LIKE '%materna%'   THEN 'Infant Nutrition-Materna'
			WHEN (LOWER([Decoded Range Brand]) LIKE '%baby%' OR LOWER([Decoded Range Brand]) LIKE '%swsw%') AND (LOWER([Decoded Range Brand]) NOT LIKE '%cetaphil%' ) THEN 'Infant-Nestle Baby'
			
        
		    ----------------------------------------PURINA------------------------------------------------------------------------------

			WHEN LOWER([Decoded Range Brand]) LIKE '%beneful%'   THEN 'Purina-Beneful'
			WHEN LOWER([Decoded Range Brand]) LIKE '%catchow%'  THEN 'Purina-Cat Chow'
			WHEN LOWER([Decoded Range Brand]) LIKE '%dogchow%'  THEN 'Purina-Dog Chow'
			WHEN LOWER([Decoded Range Brand]) LIKE '%fancy%'  THEN 'Purina-Fancy Feast'
			WHEN LOWER([Decoded Range Brand]) LIKE '%ONE%'  THEN 'Purina-ONE'
			WHEN (LOWER([Decoded Range Brand]) LIKE '%pro%')  AND (LOWER([Decoded Range Brand]) LIKE '%plan%' ) THEN 'Purina-Pro Plan'
			WHEN LOWER([Decoded Range Brand]) LIKE '%tidy%'   THEN 'Purina-Tidy Cats'
			WHEN LOWER([Decoded Range Brand]) LIKE '%beyond%'  THEN 'Purina -Beyond'
		    WHEN LOWER([Decoded Range Brand]) LIKE '%denta%'  THEN 'Purina-DentaLife'
		
			-------------------------------------------SKIN-HEALTH--------------------------------------------------------------------------
			WHEN  (LOWER([Decoded Range Brand]) LIKE '%baby%') AND (LOWER([Decoded Range Brand]) LIKE '%cetaphil%') THEN 'Skin Health-Cetaphil Baby'
			WHEN  (LOWER([Decoded Range Brand]) LIKE '%core%')   AND (LOWER([Decoded Range Brand]) LIKE '%cetaphil%') THEN 'Skin Health-Cetaphil Core'
			WHEN (LOWER([Decoded Range Brand]) LIKE '%master%') AND (LOWER([Decoded Range Brand]) LIKE '%cetaphil%')  THEN 'Skin Health-Cetaphil Master brand'
			WHEN LOWER([Decoded Range Brand]) LIKE '%dysport%'  THEN 'Skin Health-Dysport'
			WHEN LOWER([Decoded Range Brand]) LIKE '%excipial%'  THEN 'Skin Health-Excipial'
			WHEN LOWER([Decoded Range Brand]) LIKE '%restylane%'   THEN 'Skin Health-Restylane'
			WHEN LOWER([Decoded Range Brand]) LIKE '%rosacea%'  THEN 'Skin Health-Rosacea'
			
			------------------------------------WATERS--------------------------------------------------------------------------------------
	        WHEN LOWER([Decoded Range Brand]) LIKE '%pana%'    THEN 'Waters-Aqua Pana'
			WHEN LOWER([Decoded Range Brand]) LIKE '%perrier%'  THEN 'Waters-Perrier'
			WHEN (LOWER([Decoded Range Brand]) LIKE '%life%' ) 
			     AND ((LOWER([Decoded Range Brand]) NOT LIKE '%fruit%' ) )
			     AND ((LOWER([Decoded Range Brand]) NOT LIKE '%spark%') ) THEN 'Waters-Pure Life'
			WHEN LOWER([Decoded Range Brand]) LIKE '%spark%' THEN 'Waters-Pure Life Sparkling'
			WHEN ((LOWER([Decoded Range Brand]) LIKE '%san%' ) OR (LOWER(Campaign)  LIKE '%pellegrino%' )) 
			     AND ((LOWER([Decoded Range Brand]) NOT LIKE '%fruit%' )) 
				 AND ((LOWER([Decoded Range Brand]) NOT LIKE '%spark%' )) THEN 'Waters-San Pellegrino'
			WHEN LOWER([Decoded Range Brand]) LIKE '%fruit%'  THEN 'Waters-San Pellegrino Fruit'
			
			---------------------------------------OTHERS---------------------------------------------------------------------------------
			ELSE 'Other'
			
			END AS FilterName


	FROM GCM_NewConv_View
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
,GCM_Final_View AS

(
--Adding Missing Brand names from the default brand list table

SELECT *
FROM 
DCM_Spend_Table_Filter_Table   AS a
RIGHT JOIN [dbo].[Nestle_All_Brand_List] AS b ON a.FilterNameUpdated = b.Brand
-- Removing SOCIAL Camp from Prog View
WHERE Campaign not like '%SOCIAL%'
)

select * from GCM_Final_View

