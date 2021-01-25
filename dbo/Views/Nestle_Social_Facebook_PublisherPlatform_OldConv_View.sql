
CREATE VIEW [dbo].[Nestle_Social_Facebook_PublisherPlatform_OldConv_View] 

AS

--Combining required columns from facebook & twitter data table

WITH Facebook_Table
AS (
	(
	SELECT date_start AS 'Date',
		'Facebook/Instagram' AS 'Channel',
		account_name AS 'Account',
		adset_name AS 'Adset Name',
		campaign_name AS 'Campaign',
		objective AS 'Objective',
		publisher_platform AS 'Platform',
        platform_position AS 'Platform Position',
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
		conversions as 'Conversions',
		CASE WHEN campaign_name LIKE '%2020%' THEN '2020'
	 WHEN campaign_name LIKE '2019_%' THEN '2019'
	 WHEN campaign_name LIKE '2018_%' THEN '2018'
	 WHEN campaign_name LIKE '2017_%' THEN '2017'
ELSE 'X-Year'
END AS 'Campaign_Year'
		--NULL AS 'FilterName'
	FROM [dbo].[Nestle_Social_Facebook_Ads_PublisherPlatform]
	WHERE campaign_name LIKE '%2020%'
	and (clicks > 0 or impressions > 0)
	)


--Missing columns in Twitter table - Adset Name, Gender, Age, Creative Thumbnail RL,
-- Creative Image RL, Creative Title, Creative Body,Link Clicks, Post Engagement,
--Video Plays. 
	),
--Mapping brand names from nestle naming conventions master file (Campaign mapping tab) 
-- Add Beverages-Nescafe, Beverages-Starbucks, Beverages-Nescafe Capuccino, Beverages-Nescafe Rich,
-- Add Beverages-Starbucks Kcup, Beverages-Starbucks by Nespresso, Beverages-Nesquik,Beverages-Starbucks-CPG At Home Coffee
-- Add Infant-Nestle Baby, Ice Cream-Drumstick,Purina-Purina Corporate, Purina-DentaLife, 
--Add Health Sciences-Boost Soothe, Health Sciences-Boost Complete+, Health Sciences-Carnation Breakfast Essentials(CBE)

Facebook_Brand_Table
AS (
	SELECT *,
		CASE
		--------------------------------BEVERAGES--------------------------------------------------------------
			WHEN LOWER(Campaign) LIKE '%bliss%' OR LOWER([Account]) LIKE '%bliss%' THEN 'Beverages-Bliss'
			WHEN (LOWER(Campaign) LIKE '%mate%' OR LOWER([Account]) LIKE '%mate%') AND (LOWER(Campaign) LIKE '%coffee%' OR LOWER([Account]) LIKE '%coffee%' ) THEN 'Beverages-Coffee Mate'
			WHEN LOWER(Campaign) LIKE '%dolce%' OR LOWER([Account]) LIKE '%dolce%' THEN 'Beverages-Dolce Gusto'
			WHEN LOWER(Campaign) LIKE '%gold%' OR LOWER([Account]) LIKE '%gold%' THEN 'Beverages-Nescafe Gold'
			WHEN (LOWER(Campaign) LIKE '%time%' OR LOWER([Account]) LIKE '%time%') AND (LOWER(Campaign) LIKE '%good%' OR LOWER([Account]) LIKE '%good%')  THEN 'Beverages-Good Time'
			WHEN (LOWER(Campaign) LIKE '%sweet%' OR LOWER([Account]) LIKE '%sweet%') AND LOWER(Campaign) LIKE '%cream%' OR LOWER([Account]) LIKE '%cream%' THEN 'Beverages-Nescafe Sweet & Creamy'
			WHEN LOWER(Campaign) LIKE '%capuccino%' OR LOWER([Account]) LIKE '%capuccino%' THEN 'Beverages-Nescafe Capuccino'
		    WHEN LOWER(Campaign) LIKE '%rich%' OR LOWER([Account]) LIKE '%rich%' THEN 'Beverages-Nescafe Rich'
			WHEN LOWER(Campaign) LIKE '%kcup%' OR LOWER([Account]) LIKE '%kcup%' THEN 'Beverages-Starbucks Kcup'
		    WHEN LOWER(Campaign) LIKE '%nespresso%' OR LOWER([Account]) LIKE '%nespresso%' THEN 'Beverages-Starbucks by Nespresso'
		    WHEN LOWER(Campaign) LIKE '%nesquik%' OR LOWER([Account]) LIKE '%nesquik%' THEN  'Beverages-Nesquik'
		    WHEN (LOWER(Campaign) LIKE '%cpg%' OR LOWER([Account]) LIKE '%cpg%') AND (LOWER(Campaign) LIKE '%starbucks%' OR LOWER([Account]) LIKE '%starbucks%')  THEN 'Beverages-Starbucks-CPG At Home Coffee'
	
			-----------------------------------CONFECTIONERY------------------------------------------------------------
			WHEN LOWER(Campaign) LIKE '%aero%' OR LOWER([Account]) LIKE  '%aero%' THEN 'Confectionery-Aero'
			WHEN LOWER(Campaign) LIKE '%baci%' OR LOWER([Account]) LIKE '%baci%' THEN 'Confectionery-Baci'
			WHEN (LOWER(Campaign) LIKE '%crisp%' OR LOWER([Account]) LIKE '%crisp%') AND (LOWER(Campaign) LIKE '%coffee%' OR LOWER([Account]) LIKE '%coffee%') THEN 'Confectionery-Coffee Crisp'
			WHEN (LOWER(Campaign) LIKE '%kit%' OR LOWER([Account]) LIKE '%kit%') AND (LOWER(Campaign) LIKE '%kat%' OR LOWER([Account]) LIKE '%kat%')  THEN 'Confectionery-Kit Kat'
			WHEN LOWER(Campaign) LIKE '%telier%' OR LOWER([Account]) LIKE '%telier%' THEN 'Confectionery-L''Atelier'
			WHEN LOWER(Campaign) LIKE '%minis%' OR LOWER([Account]) LIKE '%minis%' THEN 'Confectionery-Minis'
			WHEN LOWER(Campaign) LIKE '%smarties%' OR LOWER([Account]) LIKE '%smarties%'THEN 'Confectionery-Smarties'
			WHEN LOWER(Campaign) LIKE '%turtles%' OR LOWER([Account]) LIKE '%turtles%' THEN 'Confectionery-Turtles'
			-----------------------------------CORPORATE--------------------------------------------------------------------
			--WHEN (LOWER(Campaign) LIKE '%corp%' OR LOWER([Account]) LIKE  '%corp%') AND FilterName is NULL THEN 'Corporate-Corporate'

            -----------------------------------FROZEN-----------------------------------------------------------------------
			WHEN LOWER(Campaign) LIKE '%delissio%'  OR LOWER([Account]) LIKE '%delissio%' THEN 'Frozen-Delissio'
			WHEN (LOWER(Campaign) LIKE '%lean%'  OR LOWER([Account]) LIKE '%lean%') AND (LOWER(Campaign) LIKE '%cuisine%' OR LOWER([Account]) LIKE '%cuisine%') THEN 'Frozen-Lean Cuisine'
			WHEN LOWER(Campaign) LIKE '%market%'  OR LOWER([Account]) LIKE '%market%' AND (LOWER(Campaign) LIKE '%cuisine%' OR LOWER([Account]) LIKE '%cuisine%')  THEN 'Frozen-Marketplace Cuisine'
			WHEN LOWER(Campaign) LIKE '%stouffer%'  OR LOWER([Account]) LIKE '%stouffer%'  THEN 'Frozen-Stouffers'
			

			-----------------------------------HEALTH-SCIENCES-------------------------------------------------------------

			WHEN LOWER(Campaign) LIKE '%boost%' OR LOWER([Account]) LIKE '%boost%'  THEN 'Health Sciences-Boost'
			WHEN ( LOWER(Campaign) LIKE '%break%' OR LOWER([Account]) LIKE '%break%') AND ( LOWER(Campaign) LIKE '%carnation%' OR LOWER([Account]) LIKE '%carnation%') THEN 'Health Sciences-Carnation Breakfast'
			WHEN (LOWER(Campaign) LIKE '%adult%' OR LOWER([Account]) LIKE '%adult%' ) AND (LOWER(Campaign) LIKE '%compleat%' OR LOWER([Account]) LIKE '%compleat%' ) THEN 'Health Sciences-Compleat Adult'
			WHEN LOWER(Campaign) LIKE '%pediatric%' OR LOWER([Account]) LIKE '%pediatric%' THEN 'Health Sciences-Compleat Pediatric'
			WHEN LOWER(Campaign) LIKE '%resource%' OR LOWER([Account]) LIKE '%resource%'  THEN 'Health Sciences-Resources2.0'
			WHEN LOWER(Campaign) LIKE '%thicken%' OR LOWER([Account]) LIKE '%thicken%'  THEN 'Health Sciences-Thicken Up'
			WHEN (LOWER(Campaign) LIKE '%soothe%' OR LOWER([Account]) LIKE '%soothe%') AND (LOWER(Campaign) LIKE '%boost%' OR LOWER([Account]) LIKE '%boost%' )  THEN 'Health Sciences-Boost Soothe'
		    WHEN (LOWER(Campaign) LIKE '%complete%' OR LOWER([Account]) LIKE '%complete%') AND (LOWER(Campaign) LIKE '%boost%' OR LOWER([Account]) LIKE '%boost%' )  THEN 'Health Sciences-Boost Complete+'
			
			---------------------------------------ICE-CREAM-------------------------------------------------------------------

			WHEN (LOWER(Campaign) LIKE '%north%' OR LOWER([Account]) LIKE '%north%') AND (LOWER(Campaign) LIKE '%good%' OR LOWER([Account]) LIKE '%good%' )  THEN 'Ice Cream-Good North'
			WHEN LOWER(Campaign) LIKE '%haagen%' OR LOWER([Account]) LIKE '%haagen%'  THEN 'Ice Cream-Haagen-Dazs'
		    WHEN LOWER(Campaign) LIKE '%drumstick%' OR LOWER([Account]) LIKE '%drumstick%' THEN  'Ice Cream-Drumstick'
			
			-------------------------------------------------INFANT-------------------------------------------------------------------
			
			WHEN LOWER(Campaign) LIKE '%gerber%' OR LOWER([Account]) LIKE '%gerber%' THEN 'Infant Nutrition-Gerber'
			WHEN (LOWER(Campaign) LIKE '%start%' OR LOWER([Account]) LIKE '%start%') AND (LOWER(Campaign) LIKE '%good%' OR LOWER([Account]) LIKE '%good%') THEN 'Infant Nutrition-Good Start'
			WHEN LOWER(Campaign) LIKE '%materna%' OR LOWER([Account]) LIKE '%materna%'  THEN 'Infant Nutrition-Materna'
			WHEN (LOWER(Campaign) LIKE '%baby%' OR LOWER([Account]) LIKE '%baby%' OR LOWER(Campaign) LIKE '%swsw%' OR LOWER([Account]) LIKE '%swsw%') AND (LOWER(Campaign) NOT LIKE '%cetaphil%' OR LOWER([Account]) NOT LIKE '%cetaphil%' ) THEN 'Infant-Nestle Baby'
			
        
		    ----------------------------------------PURINA------------------------------------------------------------------------------

			WHEN LOWER(Campaign) LIKE '%beneful%' OR LOWER([Account]) LIKE '%beneful%'  THEN 'Purina-Beneful'
			WHEN LOWER(Campaign) LIKE '%catchow%' OR LOWER([Account]) LIKE '%catchow%' THEN 'Purina-Cat Chow'
			WHEN LOWER(Campaign) LIKE '%dogchow%' OR LOWER([Account]) LIKE '%dogchow%' THEN 'Purina-Dog Chow'
			WHEN LOWER(Campaign) LIKE '%fancy%' OR LOWER([Account]) LIKE '%fancy%' THEN 'Purina-Fancy Feast'
			WHEN (LOWER(Campaign) LIKE '%one%' OR LOWER([Account]) LIKE '%one%') AND (LOWER(Campaign) LIKE '%purina%' OR LOWER([Account]) LIKE '%purina%' ) THEN 'Purina-ONE'
			WHEN (LOWER(Campaign) LIKE '%pro%' OR LOWER([Account]) LIKE '%pro%') AND (LOWER(Campaign) LIKE '%plan%' OR LOWER([Account]) LIKE '%plan%') THEN 'Purina-Pro Plan'
			WHEN LOWER(Campaign) LIKE '%tidy%' OR LOWER([Account]) LIKE '%tidy%'  THEN 'Purina-Tidy Cats'
			WHEN LOWER(Campaign) LIKE '%beyond%' OR LOWER([Account])  LIKE '%beyond%'  THEN 'Purina -Beyond'
		    WHEN LOWER(Campaign) LIKE '%denta%' OR LOWER([Account]) LIKE '%denta%'  THEN 'Purina-DentaLife'
		
			-------------------------------------------SKIN-HEALTH--------------------------------------------------------------------------
			WHEN  (LOWER(Campaign) LIKE '%baby%') OR (LOWER([Account]) LIKE '%baby%' )AND (LOWER([Account]) LIKE '%cetaphil%') THEN 'Skin Health-Cetaphil Baby'
			WHEN  (LOWER(Campaign) LIKE '%core%') OR (LOWER([Account]) LIKE '%core%')  AND (LOWER([Account]) LIKE '%cetaphil%') THEN 'Skin Health-Cetaphil Core'
			WHEN (LOWER(Campaign) LIKE '%master%') OR (LOWER([Account]) LIKE '%master%' AND (LOWER([Account]) LIKE '%cetaphil%'))  THEN 'Skin Health-Cetaphil Master brand'
			WHEN LOWER(Campaign) LIKE '%dysport%' OR LOWER([Account]) LIKE '%dysport%'  THEN 'Skin Health-Dysport'
			WHEN LOWER(Campaign) LIKE '%excipial%' OR LOWER([Account]) LIKE '%excipial%' THEN 'Skin Health-Excipial'
			WHEN LOWER(Campaign) LIKE '%restylane%' OR LOWER([Account]) LIKE '%restylane%'  THEN 'Skin Health-Restylane'
			WHEN LOWER(Campaign) LIKE '%rosacea%' OR LOWER([Account]) LIKE '%rosacea%' THEN 'Skin Health-Rosacea'
			
			------------------------------------WATERS--------------------------------------------------------------------------------------
	        WHEN LOWER(Campaign) LIKE '%pana%' OR LOWER([Account]) LIKE '%pana%'   THEN 'Waters-Aqua Pana'
			WHEN LOWER(Campaign) LIKE '%perrier%' OR LOWER([Account]) LIKE '%perrier%'  THEN 'Waters-Perrier'
			WHEN (LOWER(Campaign) LIKE '%life%' OR LOWER([Account]) LIKE '%life%' ) 
			     AND ((LOWER(Campaign) NOT LIKE '%fruit%' AND LOWER([Account]) NOT LIKE '%fruit%') ) 
			     AND ((LOWER(Campaign) NOT LIKE '%spark%' AND LOWER([Account]) NOT LIKE '%spark%') ) THEN 'Waters-Pure Life'
			WHEN LOWER(Campaign) LIKE '%spark%' OR LOWER([Account]) LIKE '%spark%'  THEN 'Waters-Pure Life Sparkling'
			WHEN ((LOWER(Campaign) LIKE '%san%' OR LOWER([Account]) LIKE '%san%') OR (LOWER(Campaign)  LIKE '%pellegrino%' OR LOWER([Account])  LIKE '%pellegrino%')) 
			     AND ((LOWER(Campaign) NOT LIKE '%fruit%' AND LOWER([Account]) NOT LIKE '%fruit%') ) 
				 AND ((LOWER(Campaign) NOT LIKE '%spark%' AND LOWER([Account]) NOT LIKE '%spark%') ) THEN 'Waters-San Pellegrino'
			WHEN LOWER(Campaign) LIKE '%fruit%' OR LOWER([Account]) LIKE '%fruit%' THEN 'Waters-San Pellegrino Fruit'
			
			---------------------------------------OTHERS---------------------------------------------------------------------------------
			ELSE 'Other'
			
			END AS FilterName,
--Social - The campaign names mostly has english , french, FR, EN values - 
--setting up column language based on  pattern matching
		CASE
			WHEN LOWER(Campaign) LIKE '%english%' THEN 'English'
			WHEN LOWER(Campaign) LIKE '%french%' THEN 'French'
			WHEN Campaign LIKE '%EN%' THEN 'English'
			WHEN Campaign LIKE '%FR%' THEN 'French'
			ELSE 'Unknown'
			END AS [Language]
	FROM Facebook_Table
	)

,

	---- Corp Check loop 2 

Facebook_Brand_Filter_Table 
AS
(

SELECT *, 
	       CASE
            WHEN (LOWER(Campaign) LIKE '%starbucks%' OR LOWER([Account]) LIKE '%starbucks%')AND (FilterName NOT LIKE '%Beverages%') THEN 'Beverages-Starbucks'
			WHEN (((LOWER(Campaign) LIKE '%bev%') AND (LOWER(Campaign) LIKE '%corp%')) OR (LOWER([Account]) LIKE '%bev%' AND LOWER([Account]) LIKE '%corp%')) AND (FilterName NOT LIKE '%Beverages%') THEN 'Beverages-Beverages Corporate'
			WHEN ((LOWER(Campaign) LIKE '%nescafe%' OR LOWER([Account]) LIKE '%nescafe%') AND (FilterName NOT LIKE '%Nescafe%'))THEN 'Beverages-Nescafe'
			WHEN ((LOWER(Campaign) LIKE '%confect%') AND (LOWER(Campaign) LIKE '%corp%')) OR (LOWER([Account]) LIKE '%confect%' AND (LOWER([Account]) LIKE '%corp%')) AND ( FilterName NOT LIKE '%Confect%')THEN 'Confectionery-Confectionery Corporate'
			WHEN (LOWER(Campaign) LIKE '%corp%' OR LOWER([Account]) LIKE  '%corp%') AND FilterName = 'other' THEN 'Corporate-Corporate'
			WHEN ((LOWER(Campaign) LIKE '%frozen%') AND (LOWER(Campaign) LIKE '%corp%')) OR (LOWER([Account]) LIKE '%frozen%' AND (LOWER([Account]) LIKE '%corp%')) AND (FilterName NOT LIKE '%Frozen%') THEN 'Frozen-Frozen Corporate'
			WHEN ((LOWER(Campaign) LIKE '%frozen%') AND (LOWER(Campaign) LIKE '%corp%')) OR (LOWER([Account]) LIKE '%frozen%' AND (LOWER([Account]) LIKE '%corp%')) AND (FilterName NOT LIKE '%Frozen%') THEN 'Frozen-Frozen Corporate'
			WHEN ((LOWER(Campaign) LIKE '%health%') AND (LOWER(Campaign) LIKE '%corp%')) OR (LOWER([Account]) LIKE '%health%' AND (LOWER([Account]) LIKE '%corp%')) AND (FilterName NOT LIKE '%Health%') THEN 'Health Sciences-Health Sciences Corporate'
			WHEN ((LOWER(Campaign) LIKE '%ice%') AND (LOWER(Campaign) LIKE '%corp%')) OR (LOWER([Account]) LIKE '%ice%' AND (LOWER([Account]) LIKE '%corp%')) AND (FilterName NOT LIKE '%Ice%') THEN 'Ice Cream-Ice Cream Corporate'
			WHEN ((LOWER(Campaign) LIKE '%infant%') AND (LOWER(Campaign) LIKE '%corp%')) OR (LOWER([Account]) LIKE '%infant%' AND (LOWER([Account]) LIKE '%corp%')) AND( FilterName NOT LIKE '%Infant%') THEN 'Infant Nutrition-Infant Nutrition Corporate'
			WHEN(LOWER(Campaign) LIKE '%water%') AND (LOWER(Campaign) LIKE '%corp%') OR (LOWER([Account]) LIKE '%water%' AND (LOWER([Account]) LIKE '%corp%')) AND (FilterName NOT LIKE '%Waters%') THEN 'Waters-Waters Corporate'
			WHEN (LOWER(Campaign) LIKE '%skin%') AND (LOWER(Campaign) LIKE '%corp%') OR (LOWER([Account]) LIKE '%skin%' AND (LOWER([Account]) LIKE '%corp%')) AND( FilterName NOT LIKE '%Skin%')  THEN 'Skin Health-Skin Health Corporate'
			WHEN ((LOWER(Campaign) LIKE '%purina%') AND (LOWER(Campaign) LIKE '%corp%')) OR (LOWER([Account]) LIKE '%purina%' AND (LOWER([Account]) LIKE '%corp%')) AND (FilterName NOT LIKE '%Purina%') THEN 'Purina-Purina Corporate'
			WHEN ((LOWER(Campaign) LIKE '%master%' OR LOWER([Account])  LIKE '%purina%') AND (LOWER(Campaign) LIKE '%master%' OR LOWER([Account])  LIKE '%purina%')) AND (FilterName NOT LIKE '%Purina%' AND FilterName NOT LIKE '%Skin%') THEN 'Purina-Purina Master Brand'
			ELSE FilterName
			END AS FilterNameUpdated
			FROM Facebook_Brand_Table
			),

--Adding Missing Brand names from the default brand list table
Facebook_view 
AS
(
SELECT *
FROM Facebook_Brand_Filter_Table AS a
RIGHT JOIN [dbo].[Nestle_All_Brand_List] AS b ON a.FilterNameUpdated = b.Brand
)

SELECT  a.*, b.CPM
FROM  Facebook_view  AS a JOIN [dbo].[Nestle_Social_Facebook_KPI] as b ON a.Brand = b.Brand

--- Purina ONE - not going to do a  ONE cat/One Dog campaign name is generic. Is it Pro plan or Pro plan vet diets, Does CBE a category under health sciences.
