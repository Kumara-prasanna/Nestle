
CREATE VIEW [dbo].[Nestle_Social_Facebook_PublisherPlatform_NewConv_View]
AS

--Combining required columns from facebook & twitter data table

WITH 
Facebook_PP_Table
AS (
SELECT date_start AS 'Date',
publisher_platform AS 'Platform',
platform_position AS 'Platform Position',
account_name AS 'Account',
adset_name AS 'Adset Name',
campaign_name AS 'Campaign',
objective AS 'Objective',
ad_creative_thumbnail_url AS 'Creative Thumbnail URL',
ad_creative_image_url AS 'Creative Image URL',
ad_creative_title AS 'Creative Title',
ad_creative_name AS 'Creative Name',
ad_creative_body AS 'Creative Body',
spend AS 'Spend',
action_valuesoffsite_conversionfb_pixel_purchase as 'Website Purchase',
impressions AS 'Impressions',
clicks AS 'Clicks',
actionslink_click AS 'Link Clicks',
actionspost_engagement AS 'Post Engagement',
video_play_actionsvideo_view AS 'Video Plays',
actionsvideo_view AS '3 Sec Video Plays',
video_p25_watched_actionsvideo_view AS 'Video Views - 25%',
video_p50_watched_actionsvideo_view AS 'Video Views - 50%',
video_p75_watched_actionsvideo_view AS 'Video Views - 75%',
video_p100_watched_actionsvideo_view AS 'Video Views - 100%',
ISNULL((spend/action_valuesoffsite_conversionfb_pixel_purchase),0) as 'CPA',
conversions as 'Conversions'
--NULL AS 'FilterName'
FROM [dbo].[Nestle_Social_Facebook_Ads_PublisherPlatform]
where campaign_name like 'L_%'
and (clicks > 0 or impressions > 0)
)
-- ==== Splitting Campaign into Columns ==== --
,Campaign_Split AS
(
SELECT 
distinct campaign_name,
dbo.SplitStringDelimiter(campaign_name, 1, '|') as 'CPE',
dbo.SplitStringDelimiter(campaign_name, 2, '|') as 'Campaign Name',
right(dbo.SplitStringDelimiter(campaign_name, 2, '|'),2) as 'Language',
dbo.SplitStringDelimiter(campaign_name, 3, '|') as 'FreeForm2',
left((dbo.SplitStringDelimiter(campaign_name, 3, '|')),4) as 'Campaign_Year',
right((dbo.SplitStringDelimiter(campaign_name, 3, '|')),2) as 'Period',
dbo.SplitStringDelimiter(campaign_name, 4, '|') as 'Buy Type',
dbo.SplitStringDelimiter(campaign_name, 5, '|') as 'Agency Holding Group',
dbo.SplitStringDelimiter(campaign_name, 6, '|') as 'Master Brand',
dbo.SplitStringDelimiter(campaign_name, 7, '|') as 'Range Brand',
dbo.SplitStringDelimiter(campaign_name, 8, '|') as 'Segment',
dbo.SplitStringDelimiter(campaign_name, 9, '|') as 'Market',
dbo.SplitStringDelimiter(campaign_name, 10, '|') as 'Campaign Type',
dbo.SplitStringDelimiter(campaign_name, 11, '|') as 'Campaign Objective'
FROM [dbo].[Nestle_Social_Facebook_Ads_PublisherPlatform]
--where campaign_name like 'L_%'
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
,Facebook_PP_View 
AS
(
select T1.*, T2.CPE, T2.[Language], T2.Campaign_Year, T2.[Period], T2.[Buy Type], T2.[Agency Holding Group], T2.[Decoded Master Brand]
, T2.[Decoded Range Brand], T2.[Decoded Segment], T2.[Market], T2.[Decoded Campaign Type], T2.[Decoded Campaign Objective]
from Facebook_PP_Table T1 LEFT JOIN CampaignObjective_Table T2
ON T1.campaign = T2.campaign_name
)
,

Facebook_PP_Brand_Table
AS (
	SELECT *,
		CASE
		--------------------------------BEVERAGES--------------------------------------------------------------
			WHEN LOWER([Decoded Range Brand] ) LIKE '%bliss%' OR LOWER([Account]) LIKE '%bliss%' THEN 'Beverages-Bliss'
			WHEN (LOWER([Decoded Range Brand] ) LIKE '%mate%' OR LOWER([Account]) LIKE '%mate%') AND (LOWER([Decoded Range Brand] ) LIKE '%coffee%' OR LOWER([Account]) LIKE '%coffee%' ) THEN 'Beverages-Coffee Mate'
			WHEN LOWER([Decoded Range Brand] ) LIKE '%dolce%' OR LOWER([Account]) LIKE '%dolce%' THEN 'Beverages-Dolce Gusto'
			WHEN LOWER([Decoded Range Brand] ) LIKE '%gold%' OR LOWER([Account]) LIKE '%gold%' THEN 'Beverages-Nescafe Gold'
			WHEN (LOWER([Decoded Range Brand] ) LIKE '%time%' OR LOWER([Account]) LIKE '%time%') AND (LOWER([Decoded Range Brand] ) LIKE '%good%' OR LOWER([Account]) LIKE '%good%')  THEN 'Beverages-Good Time'
			WHEN (LOWER([Decoded Range Brand] ) LIKE '%sweet%' OR LOWER([Account]) LIKE '%sweet%') AND LOWER([Decoded Range Brand] ) LIKE '%cream%' OR LOWER([Account]) LIKE '%cream%' THEN 'Beverages-Nescafe Sweet & Creamy'
			WHEN LOWER([Decoded Range Brand] ) LIKE '%capuccino%' OR LOWER([Account]) LIKE '%capuccino%' THEN 'Beverages-Nescafe Capuccino'
		    WHEN LOWER([Decoded Range Brand] ) LIKE '%rich%' OR LOWER([Account]) LIKE '%rich%' THEN 'Beverages-Nescafe Rich'
			WHEN LOWER([Decoded Range Brand] ) LIKE '%kcup%' OR LOWER([Account]) LIKE '%kcup%' THEN 'Beverages-Starbucks Kcup'
		    WHEN LOWER([Decoded Range Brand] ) LIKE '%nespresso%' OR LOWER([Account]) LIKE '%nespresso%' THEN 'Beverages-Starbucks by Nespresso'
		    WHEN LOWER([Decoded Range Brand] ) LIKE '%nesquik%' OR LOWER([Account]) LIKE '%nesquik%' THEN  'Beverages-Nesquik'
		    WHEN (LOWER([Decoded Range Brand] ) LIKE '%cpg%' OR LOWER([Account]) LIKE '%cpg%') AND (LOWER([Decoded Range Brand] ) LIKE '%starbucks%' OR LOWER([Account]) LIKE '%starbucks%')  THEN 'Beverages-Starbucks-CPG At Home Coffee'
	
			-----------------------------------CONFECTIONERY------------------------------------------------------------
			WHEN LOWER([Decoded Range Brand] ) LIKE '%aero%' OR LOWER([Account]) LIKE  '%aero%' THEN 'Confectionery-Aero'
			WHEN LOWER([Decoded Range Brand] ) LIKE '%baci%' OR LOWER([Account]) LIKE '%baci%' THEN 'Confectionery-Baci'
			WHEN (LOWER([Decoded Range Brand] ) LIKE '%crisp%' OR LOWER([Account]) LIKE '%crisp%') AND (LOWER([Decoded Range Brand] ) LIKE '%coffee%' OR LOWER([Account]) LIKE '%coffee%') THEN 'Confectionery-Coffee Crisp'
			WHEN (LOWER([Decoded Range Brand] ) LIKE '%kit%' OR LOWER([Account]) LIKE '%kit%') AND (LOWER([Decoded Range Brand] ) LIKE '%kat%' OR LOWER([Account]) LIKE '%kat%')  THEN 'Confectionery-Kit Kat'
			WHEN LOWER([Decoded Range Brand] ) LIKE '%telier%' OR LOWER([Account]) LIKE '%telier%' THEN 'Confectionery-L''Atelier'
			WHEN LOWER([Decoded Range Brand] ) LIKE '%minis%' OR LOWER([Account]) LIKE '%minis%' THEN 'Confectionery-Minis'
			WHEN LOWER([Decoded Range Brand] ) LIKE '%smarties%' OR LOWER([Account]) LIKE '%smarties%'THEN 'Confectionery-Smarties'
			WHEN LOWER([Decoded Range Brand] ) LIKE '%turtles%' OR LOWER([Account]) LIKE '%turtles%' THEN 'Confectionery-Turtles'
			-----------------------------------CORPORATE--------------------------------------------------------------------
			--WHEN (LOWER([Decoded Range Brand] ) LIKE '%corp%' OR LOWER([Account]) LIKE  '%corp%') AND FilterName is NULL THEN 'Corporate-Corporate'

            -----------------------------------FROZEN-----------------------------------------------------------------------
			WHEN LOWER([Decoded Range Brand] ) LIKE '%delissio%'  OR LOWER([Account]) LIKE '%delissio%' THEN 'Frozen-Delissio'
			WHEN (LOWER([Decoded Range Brand] ) LIKE '%lean%'  OR LOWER([Account]) LIKE '%lean%') AND (LOWER([Decoded Range Brand] ) LIKE '%cuisine%' OR LOWER([Account]) LIKE '%cuisine%') THEN 'Frozen-Lean Cuisine'
			WHEN LOWER([Decoded Range Brand] ) LIKE '%market%'  OR LOWER([Account]) LIKE '%market%' AND (LOWER([Decoded Range Brand] ) LIKE '%cuisine%' OR LOWER([Account]) LIKE '%cuisine%')  THEN 'Frozen-Marketplace Cuisine'
			WHEN LOWER([Decoded Range Brand] ) LIKE '%stouffer%'  OR LOWER([Account]) LIKE '%stouffer%'  THEN 'Frozen-Stouffers'
			

			-----------------------------------HEALTH-SCIENCES-------------------------------------------------------------

			WHEN LOWER([Decoded Range Brand] ) LIKE '%boost%' OR LOWER([Account]) LIKE '%boost%'  THEN 'Health Sciences-Boost'
			WHEN ( LOWER([Decoded Range Brand] ) LIKE '%break%' OR LOWER([Account]) LIKE '%break%') AND ( LOWER([Decoded Range Brand] ) LIKE '%carnation%' OR LOWER([Account]) LIKE '%carnation%') THEN 'Health Sciences-Carnation Breakfast'
			WHEN (LOWER([Decoded Range Brand] ) LIKE '%adult%' OR LOWER([Account]) LIKE '%adult%' ) AND (LOWER([Decoded Range Brand] ) LIKE '%compleat%' OR LOWER([Account]) LIKE '%compleat%' ) THEN 'Health Sciences-Compleat Adult'
			WHEN LOWER([Decoded Range Brand] ) LIKE '%pediatric%' OR LOWER([Account]) LIKE '%pediatric%' THEN 'Health Sciences-Compleat Pediatric'
			WHEN LOWER([Decoded Range Brand] ) LIKE '%resource%' OR LOWER([Account]) LIKE '%resource%'  THEN 'Health Sciences-Resources2.0'
			WHEN LOWER([Decoded Range Brand] ) LIKE '%thicken%' OR LOWER([Account]) LIKE '%thicken%'  THEN 'Health Sciences-Thicken Up'
			WHEN (LOWER([Decoded Range Brand] ) LIKE '%soothe%' OR LOWER([Account]) LIKE '%soothe%') AND (LOWER([Decoded Range Brand] ) LIKE '%boost%' OR LOWER([Account]) LIKE '%boost%' )  THEN 'Health Sciences-Boost Soothe'
		    WHEN (LOWER([Decoded Range Brand] ) LIKE '%complete%' OR LOWER([Account]) LIKE '%complete%') AND (LOWER([Decoded Range Brand] ) LIKE '%boost%' OR LOWER([Account]) LIKE '%boost%' )  THEN 'Health Sciences-Boost Complete+'
			
			---------------------------------------ICE-CREAM-------------------------------------------------------------------

			WHEN (LOWER([Decoded Range Brand] ) LIKE '%north%' OR LOWER([Account]) LIKE '%north%') AND (LOWER([Decoded Range Brand] ) LIKE '%good%' OR LOWER([Account]) LIKE '%good%' )  THEN 'Ice Cream-Good North'
			WHEN LOWER([Decoded Range Brand] ) LIKE '%haagen%' OR LOWER([Account]) LIKE '%haagen%'  THEN 'Ice Cream-Haagen-Dazs'
		    WHEN LOWER([Decoded Range Brand] ) LIKE '%drumstick%' OR LOWER([Account]) LIKE '%drumstick%' THEN  'Ice Cream-Drumstick'
			
			-------------------------------------------------INFANT-------------------------------------------------------------------
			
			WHEN LOWER([Decoded Range Brand] ) LIKE '%gerber%' OR LOWER([Account]) LIKE '%gerber%' THEN 'Infant Nutrition-Gerber'
			WHEN (LOWER([Decoded Range Brand] ) LIKE '%start%' OR LOWER([Account]) LIKE '%start%') AND (LOWER([Decoded Range Brand] ) LIKE '%good%' OR LOWER([Account]) LIKE '%good%') THEN 'Infant Nutrition-Good Start'
			WHEN LOWER([Decoded Range Brand] ) LIKE '%materna%' OR LOWER([Account]) LIKE '%materna%'  THEN 'Infant Nutrition-Materna'
			WHEN (LOWER([Decoded Range Brand] ) LIKE '%baby%' OR LOWER([Account]) LIKE '%baby%' OR LOWER([Decoded Range Brand] ) LIKE '%swsw%' OR LOWER([Account]) LIKE '%swsw%') AND (LOWER([Decoded Range Brand] ) NOT LIKE '%cetaphil%' OR LOWER([Account]) NOT LIKE '%cetaphil%' ) THEN 'Infant-Nestle Baby'
			
        
		    ----------------------------------------PURINA------------------------------------------------------------------------------

			WHEN LOWER([Decoded Range Brand] ) LIKE '%beneful%' OR LOWER([Account]) LIKE '%beneful%'  THEN 'Purina-Beneful'
			WHEN LOWER([Decoded Range Brand] ) LIKE '%catchow%' OR LOWER([Account]) LIKE '%catchow%' THEN 'Purina-Cat Chow'
			WHEN LOWER([Decoded Range Brand] ) LIKE '%dogchow%' OR LOWER([Account]) LIKE '%dogchow%' THEN 'Purina-Dog Chow'
			WHEN LOWER([Decoded Range Brand] ) LIKE '%fancy%' OR LOWER([Account]) LIKE '%fancy%' THEN 'Purina-Fancy Feast'
			WHEN (LOWER([Decoded Range Brand] ) LIKE '%one%' OR LOWER([Account]) LIKE '%one%') AND (LOWER([Decoded Range Brand] ) LIKE '%purina%' OR LOWER([Account]) LIKE '%purina%' ) THEN 'Purina-ONE'
			WHEN (LOWER([Decoded Range Brand] ) LIKE '%pro%' OR LOWER([Account]) LIKE '%pro%') AND (LOWER([Decoded Range Brand] ) LIKE '%plan%' OR LOWER([Account]) LIKE '%plan%') THEN 'Purina-Pro Plan'
			WHEN LOWER([Decoded Range Brand] ) LIKE '%tidy%' OR LOWER([Account]) LIKE '%tidy%'  THEN 'Purina-Tidy Cats'
			WHEN LOWER([Decoded Range Brand] ) LIKE '%beyond%' OR LOWER([Account])  LIKE '%beyond%'  THEN 'Purina -Beyond'
		    WHEN LOWER([Decoded Range Brand] ) LIKE '%denta%' OR LOWER([Account]) LIKE '%denta%'  THEN 'Purina-DentaLife'
		
			-------------------------------------------SKIN-HEALTH--------------------------------------------------------------------------
			WHEN  (LOWER([Decoded Range Brand] ) LIKE '%baby%') OR (LOWER([Account]) LIKE '%baby%' )AND (LOWER([Account]) LIKE '%cetaphil%') THEN 'Skin Health-Cetaphil Baby'
			WHEN  (LOWER([Decoded Range Brand] ) LIKE '%core%') OR (LOWER([Account]) LIKE '%core%')  AND (LOWER([Account]) LIKE '%cetaphil%') THEN 'Skin Health-Cetaphil Core'
			WHEN (LOWER([Decoded Range Brand] ) LIKE '%master%') OR (LOWER([Account]) LIKE '%master%' AND (LOWER([Account]) LIKE '%cetaphil%'))  THEN 'Skin Health-Cetaphil Master brand'
			WHEN LOWER([Decoded Range Brand] ) LIKE '%dysport%' OR LOWER([Account]) LIKE '%dysport%'  THEN 'Skin Health-Dysport'
			WHEN LOWER([Decoded Range Brand] ) LIKE '%excipial%' OR LOWER([Account]) LIKE '%excipial%' THEN 'Skin Health-Excipial'
			WHEN LOWER([Decoded Range Brand] ) LIKE '%restylane%' OR LOWER([Account]) LIKE '%restylane%'  THEN 'Skin Health-Restylane'
			WHEN LOWER([Decoded Range Brand] ) LIKE '%rosacea%' OR LOWER([Account]) LIKE '%rosacea%' THEN 'Skin Health-Rosacea'
			
			------------------------------------WATERS--------------------------------------------------------------------------------------
	        WHEN LOWER([Decoded Range Brand] ) LIKE '%pana%' OR LOWER([Account]) LIKE '%pana%'   THEN 'Waters-Aqua Pana'
			WHEN LOWER([Decoded Range Brand] ) LIKE '%perrier%' OR LOWER([Account]) LIKE '%perrier%'  THEN 'Waters-Perrier'
			WHEN (LOWER([Decoded Range Brand] ) LIKE '%life%' OR LOWER([Account]) LIKE '%life%' ) 
			     AND ((LOWER([Decoded Range Brand] ) NOT LIKE '%fruit%' AND LOWER([Account]) NOT LIKE '%fruit%') ) 
			     AND ((LOWER([Decoded Range Brand] ) NOT LIKE '%spark%' AND LOWER([Account]) NOT LIKE '%spark%') ) THEN 'Waters-Pure Life'
			WHEN LOWER([Decoded Range Brand] ) LIKE '%spark%' OR LOWER([Account]) LIKE '%spark%'  THEN 'Waters-Pure Life Sparkling'
			WHEN ((LOWER([Decoded Range Brand] ) LIKE '%san%' OR LOWER([Account]) LIKE '%san%') OR (LOWER([Decoded Range Brand] )  LIKE '%pellegrino%' OR LOWER([Account])  LIKE '%pellegrino%')) 
			     AND ((LOWER([Decoded Range Brand] ) NOT LIKE '%fruit%' AND LOWER([Account]) NOT LIKE '%fruit%') ) 
				 AND ((LOWER([Decoded Range Brand] ) NOT LIKE '%spark%' AND LOWER([Account]) NOT LIKE '%spark%') ) THEN 'Waters-San Pellegrino'
			WHEN LOWER([Decoded Range Brand] ) LIKE '%fruit%' OR LOWER([Account]) LIKE '%fruit%' THEN 'Waters-San Pellegrino Fruit'
			
			---------------------------------------OTHERS---------------------------------------------------------------------------------
			ELSE 'Other'
			
			END AS FilterName
	FROM Facebook_PP_View
	)

,

	---- Corp Check loop 2 

Facebook_PP_Brand_Filter_Table 
AS
(

SELECT *, 
	       CASE
            WHEN (LOWER([Decoded Range Brand] ) LIKE '%starbucks%' OR LOWER([Account]) LIKE '%starbucks%')AND (FilterName NOT LIKE '%Beverages%') THEN 'Beverages-Starbucks'
			WHEN (((LOWER([Decoded Range Brand] ) LIKE '%bev%') AND (LOWER([Decoded Range Brand] ) LIKE '%corp%')) OR (LOWER([Account]) LIKE '%bev%' AND LOWER([Account]) LIKE '%corp%')) AND (FilterName NOT LIKE '%Beverages%') THEN 'Beverages-Beverages Corporate'
			WHEN ((LOWER([Decoded Range Brand] ) LIKE '%nescafe%' OR LOWER([Account]) LIKE '%nescafe%') AND (FilterName NOT LIKE '%Nescafe%'))THEN 'Beverages-Nescafe'
			WHEN ((LOWER([Decoded Range Brand] ) LIKE '%confect%') AND (LOWER([Decoded Range Brand] ) LIKE '%corp%')) OR (LOWER([Account]) LIKE '%confect%' AND (LOWER([Account]) LIKE '%corp%')) AND ( FilterName NOT LIKE '%Confect%')THEN 'Confectionery-Confectionery Corporate'
			WHEN (LOWER([Decoded Range Brand] ) LIKE '%corp%' OR LOWER([Account]) LIKE  '%corp%') AND FilterName = 'other' THEN 'Corporate-Corporate'
			WHEN ((LOWER([Decoded Range Brand] ) LIKE '%frozen%') AND (LOWER([Decoded Range Brand] ) LIKE '%corp%')) OR (LOWER([Account]) LIKE '%frozen%' AND (LOWER([Account]) LIKE '%corp%')) AND (FilterName NOT LIKE '%Frozen%') THEN 'Frozen-Frozen Corporate'
			WHEN ((LOWER([Decoded Range Brand] ) LIKE '%frozen%') AND (LOWER([Decoded Range Brand] ) LIKE '%corp%')) OR (LOWER([Account]) LIKE '%frozen%' AND (LOWER([Account]) LIKE '%corp%')) AND (FilterName NOT LIKE '%Frozen%') THEN 'Frozen-Frozen Corporate'
			WHEN ((LOWER([Decoded Range Brand] ) LIKE '%health%') AND (LOWER([Decoded Range Brand] ) LIKE '%corp%')) OR (LOWER([Account]) LIKE '%health%' AND (LOWER([Account]) LIKE '%corp%')) AND (FilterName NOT LIKE '%Health%') THEN 'Health Sciences-Health Sciences Corporate'
			WHEN ((LOWER([Decoded Range Brand] ) LIKE '%ice%') AND (LOWER([Decoded Range Brand] ) LIKE '%corp%')) OR (LOWER([Account]) LIKE '%ice%' AND (LOWER([Account]) LIKE '%corp%')) AND (FilterName NOT LIKE '%Ice%') THEN 'Ice Cream-Ice Cream Corporate'
			WHEN ((LOWER([Decoded Range Brand] ) LIKE '%infant%') AND (LOWER([Decoded Range Brand] ) LIKE '%corp%')) OR (LOWER([Account]) LIKE '%infant%' AND (LOWER([Account]) LIKE '%corp%')) AND( FilterName NOT LIKE '%Infant%') THEN 'Infant Nutrition-Infant Nutrition Corporate'
			WHEN(LOWER([Decoded Range Brand] ) LIKE '%water%') AND (LOWER([Decoded Range Brand] ) LIKE '%corp%') OR (LOWER([Account]) LIKE '%water%' AND (LOWER([Account]) LIKE '%corp%')) AND (FilterName NOT LIKE '%Waters%') THEN 'Waters-Waters Corporate'
			WHEN (LOWER([Decoded Range Brand] ) LIKE '%skin%') AND (LOWER([Decoded Range Brand] ) LIKE '%corp%') OR (LOWER([Account]) LIKE '%skin%' AND (LOWER([Account]) LIKE '%corp%')) AND( FilterName NOT LIKE '%Skin%')  THEN 'Skin Health-Skin Health Corporate'
			WHEN ((LOWER([Decoded Range Brand] ) LIKE '%purina%') AND (LOWER([Decoded Range Brand] ) LIKE '%corp%')) OR (LOWER([Account]) LIKE '%purina%' AND (LOWER([Account]) LIKE '%corp%')) AND (FilterName NOT LIKE '%Purina%') THEN 'Purina-Purina Corporate'
			WHEN ((LOWER([Decoded Range Brand] ) LIKE '%master%' OR LOWER([Account])  LIKE '%purina%') AND (LOWER([Decoded Range Brand] ) LIKE '%master%' OR LOWER([Account])  LIKE '%purina%')) AND (FilterName NOT LIKE '%Purina%' AND FilterName NOT LIKE '%Skin%') THEN 'Purina-Purina Master Brand'
			ELSE FilterName
			END AS FilterNameUpdated
			FROM Facebook_PP_Brand_Table
			),

--Adding Missing Brand names from the default brand list table
FacebookPP_Brand_view 
AS
(
SELECT *
FROM Facebook_PP_Brand_Filter_Table AS a
RIGHT JOIN [dbo].[Nestle_All_Brand_List] AS b ON a.FilterNameUpdated = b.Brand
)


select * from FacebookPP_Brand_view




GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Nestle_FB_Ads_PP (dbo)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 464
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'Nestle_Social_Facebook_PublisherPlatform_NewConv_View';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'Nestle_Social_Facebook_PublisherPlatform_NewConv_View';

