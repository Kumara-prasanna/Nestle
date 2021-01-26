
CREATE VIEW [dbo].[CD_Facebook_Ads_Age_Gender_View] 

AS
WITH Facebook_Table
AS (
	(
	SELECT 
	    date_start AS 'Date',
	    'Facebook/Instagram' AS 'Platform',
		account_name AS 'Account',
		adset_name AS 'Adset Name',
		campaign_name AS 'Campaign',
		objective AS 'Objective',
		gender_ag AS 'Gender',
		age_ag AS 'Age',    --FY20_Trojan_Q2_CW9_TRO_004_EN_R/F_FB-IG_Sext_Us_Reach_May 22 - May 31 -- FY20_Anusol_Q4_CW9_ANU_001_FR_Auction_FB-IG_Thanksgiving_Brand Awareness_Oct1-Nov4
		dbo.SplitStringDelimiter(campaign_name, 1, '_') as 'Fiscal',
        dbo.SplitStringDelimiter(campaign_name, 2, '_') as 'Campaign Name Brand',
        dbo.SplitStringDelimiter(campaign_name, 3, '_') as 'Timing',
        dbo.SplitStringDelimiter(campaign_name, 4, '_') as 'C',
        dbo.SplitStringDelimiter(campaign_name, 5, '_') as 'P',
        dbo.SplitStringDelimiter(campaign_name, 6, '_') as 'E',
        dbo.SplitStringDelimiter(campaign_name, 7, '_') as 'Campaign Name Language',
        dbo.SplitStringDelimiter(campaign_name, 8, '_') as 'Buy Type',
        dbo.SplitStringDelimiter(campaign_name, 9, '_') as 'Campaign Name Platform',
		dbo.SplitStringDelimiter(campaign_name, 10, '_') as 'Segment',
        dbo.SplitStringDelimiter(campaign_name, 11, '_') as 'Campaign Name Objective',
		dbo.SplitStringDelimiter(campaign_name, 12, '_') as 'Campaign Time range',
       ad_creative_thumbnail_url AS 'Creative Thumbnail URL',
		ad_creative_image_url AS 'Creative Image URL',
		ad_creative_title AS 'Creative Title',
		ad_creative_body AS 'Creative Body',
		spend AS 'Spend',
		impressions AS 'Impressions',
		clicks AS 'Clicks',
		actionslink_click AS 'Link Clicks',
		actionspost_engagement AS 'Post Engagement',
		video_play_actionsvideo_view AS 'Video Plays',
		actionsvideo_view AS 'Video Views',
		video_p25_watched_actionsvideo_view AS 'Video Views - 25%',
		video_p50_watched_actionsvideo_view AS 'Video Views - 50%',
		video_p75_watched_actionsvideo_view AS 'Video Views - 75%',
		video_p100_watched_actionsvideo_view AS 'Video Views - 100%',
		NULL AS 'Revenue',
		NULL AS 'Offsite Conversion Custom 1',
		NULL AS 'Offsite Conversion Custom 2',
		NULL AS 'Purchase',
		actionspage_engagement AS 'Page Engagement',
		ad_name AS 'Ad Name',
		date_stop AS 'Date Stop'

		--NULL AS 'FilterName'
	FROM [dbo].[CD_Facebook_Ads_Age_Gender]
	)
	)
,

Facebook_Brand_Table
AS (
	SELECT *,CASE
		
			WHEN LOWER(Campaign) LIKE '%anusol%' OR LOWER(Account) LIKE '%anusol%' THEN 'Anusol'	
            WHEN LOWER(Campaign) LIKE '%baking%' OR LOWER(Account) LIKE '%baking%' THEN 'Arm & Hammer Baking Soda'
            WHEN LOWER(Campaign) LIKE '%litter%' OR LOWER(Account) LIKE '%litter%' THEN  'Arm & Hammer Cat Litter'
            WHEN LOWER(Campaign) LIKE '%laundry%' OR LOWER(Account) LIKE '%laundry%' THEN 'Arm & Hammer Laundry'
            WHEN LOWER(Campaign) LIKE '%master%' OR LOWER(Account) LIKE '%master%' THEN 'Arm & Hammer Masterbrand'
            WHEN LOWER(Campaign) LIKE '%spinbrush%' OR LOWER(Account) LIKE '%spinbrush%' THEN 'Arm & Hammer Spinbrush'
            WHEN LOWER(Campaign) LIKE '%tooth%' OR LOWER(Account) LIKE '%tooth%' THEN 'Arm & Hammer Toothpaste'
            WHEN LOWER(Campaign) LIKE '%batiste%' OR LOWER(Account) LIKE '%batiste%' THEN 'Batiste'
			WHEN (LOWER(Campaign) LIKE '%prenatal%' OR LOWER(Account) LIKE '%prenatal%' ) THEN 'PreNatal'
            WHEN (LOWER(Campaign) LIKE '%response%' OR LOWER(Account) LIKE '%response%') AND ((LOWER(Campaign) NOT LIKE '%prenatal%' OR LOWER(Account) NOT LIKE '%prenatal%' ))THEN 'First Response'
            WHEN LOWER(Campaign) LIKE '%gravol%' OR LOWER(Account) LIKE '%gravol%' THEN 'Gravol'
            WHEN LOWER(Campaign) LIKE '%nair%' OR LOWER(Account) LIKE '%nair%' THEN 'Nair'
            WHEN LOWER(Campaign) LIKE '%orajel%' OR LOWER(Account) LIKE '%orajel%' THEN 'Orajel'
            WHEN LOWER(Campaign) LIKE '%oxi%' OR LOWER(Account) LIKE '%oxi%' THEN 'OxiClean'
            WHEN LOWER(Campaign) LIKE '%rephresh%' OR LOWER(Account) LIKE '%rephresh%' THEN 'RepHresh'
            WHEN LOWER(Campaign) LIKE '%replens%' OR LOWER(Account) LIKE '%replens%' THEN 'Replens'
            WHEN LOWER(Campaign) LIKE '%rub%' OR LOWER(Account) LIKE '%rub%' THEN 'Rub A535'
            WHEN LOWER(Campaign) LIKE '%toppik%' OR LOWER(Account) LIKE '%toppik%' THEN 'Toppik'
            WHEN LOWER(Campaign) LIKE '%trojan%' OR LOWER(Account) LIKE '%trojan%' THEN 'Trojan'
			WHEN LOWER(Campaign) LIKE '%flawless%' OR LOWER(Account) LIKE '%flawless%' THEN 'Flawless'
            WHEN ( LOWER(Campaign) LIKE '%vitafusion%' OR LOWER(Account) LIKE '%vitafusion%' ) AND (LOWER(Campaign) NOT LIKE '%critters%' AND LOWER(Account) NOT LIKE '%critters%') THEN 'Vitafusion'
            WHEN (LOWER(Campaign) LIKE '%critters%' OR LOWER(Account) LIKE '%critters%') THEN 'Vitafusion L''il Critters'
            WHEN LOWER(Campaign) LIKE '%viviscal%' OR LOWER(Account) LIKE '%viviscal%' THEN 'Viviscal'
            WHEN (LOWER(Campaign) LIKE '%waterpik%' OR LOWER(Account) LIKE '%waterpik%') AND (LOWER(Campaign) NOT LIKE '%shower%' AND LOWER(Account) NOT LIKE '%shower%') THEN 'Waterpik Flossers'
            WHEN (LOWER(Campaign) LIKE '%shower%' OR LOWER(Account) LIKE '%shower%') AND (LOWER(Campaign) LIKE '%waterpik%' OR LOWER(Account) LIKE '%waterpik%')THEN 'Waterpik Shower Heads'
			ELSE 'No Association'
			END
			AS FilterName,

--Social - The campaign names mostly has english , french, FR, EN values - 
--setting up column language based on  pattern matching
		CASE
			WHEN LOWER(Campaign) LIKE '%english%' OR (Campaign LIKE '%/_EN%' Escape '/') THEN 'English'
			WHEN LOWER(Campaign) LIKE '%french%' OR  (Campaign LIKE '%/_FR%'  Escape '/' ) THEN 'French'
			ELSE 'Unknown'
			END AS [Language]
      
	FROM Facebook_Table
	)




SELECT *
FROM 
Facebook_Brand_Table  AS a
RIGHT JOIN [dbo].[Brands] AS b ON a.FilterName = b.Brand