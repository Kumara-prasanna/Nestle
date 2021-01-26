




CREATE VIEW [dbo].[CD_Exec_Summary] AS
(
SELECT  [dbo].[CD_FB_Ads].[date_stop] AS 'Date',
        [dbo].[CD_FB_Ads].[campaign_name] AS 'Campaign Name',
		[dbo].[CD_FB_Ads].[impressions] AS 'Impressions',
		[dbo].[CD_FB_Ads].[clicks] AS 'Clicks',
		[dbo].[CD_FB_Ads].[video_p25_watched_actionsvideo_view] AS 'Video View - 25%',
		[dbo].[CD_FB_Ads].[video_p50_watched_actionsvideo_view] AS 'Video View - 50%',
		[dbo].[CD_FB_Ads].[video_p75_watched_actionsvideo_view] AS 'Video View - 75%',
		[dbo].[CD_FB_Ads].[video_p100_watched_actionsvideo_view] AS 'Video View - 100%',
		[dbo].[CD_FB_Ads].[actionsvideo_view] AS 'Video Views',
		[dbo].[CD_FB_Ads].[spend] AS 'Spend',
		NULL AS 'Sales',
		'Social' AS 'Channel'
FROM  [dbo].[CD_FB_Ads])

UNION ALL
(
SELECT  [dbo].[CD_GCM_Spend_View].[date] AS 'Date',
        [dbo].[CD_GCM_Spend_View].[campaign] AS 'Campaign Name',
		[dbo].[CD_GCM_Spend_View].[impressions] AS 'Impressions',
		[dbo].[CD_GCM_Spend_View].[clicks] AS 'Clicks',
		[dbo].[CD_GCM_Spend_View].[video_first_quartile_completions] AS 'Video View - 25%',
		[dbo].[CD_GCM_Spend_View].[video_midpoints] AS 'Video View - 50%',
		[dbo].[CD_GCM_Spend_View].[video_third_quartile_completions] AS 'Video View - 75%',
		[dbo].[CD_GCM_Spend_View].[video_completions] AS 'Video View - 100%',
		[dbo].[CD_GCM_Spend_View].[video_plays] AS 'Video Views',
		[dbo].[CD_GCM_Spend_View].[Flight Capped Spend] AS 'Spend',
		NULL AS 'Sales',
		'Digital' AS 'Channel'
FROM  [dbo].[CD_GCM_Spend_View]
)

UNION ALL
(
SELECT  [dbo].[CD_AMN_Ads_View].[Date] AS 'Date',
        [dbo].[CD_AMN_Ads_View].[Campaign Name] AS 'Campaign Name',
		[dbo].[CD_AMN_Ads_View].[Impressions] AS 'Impressions',
		[dbo].[CD_AMN_Ads_View].[Clicks] AS 'Clicks',
		NULL AS 'Video View - 25%',
		NULL AS 'Video View - 50%',
		NULL AS 'Video View - 75%',
		NULL AS 'Video View - 100%',
		NULL AS 'Video Views',
		[dbo].[CD_AMN_Ads_View].[Cost] AS 'Spend',
		[dbo].[CD_AMN_Ads_View].[Sales] AS 'Sales',
		'E-Com Search' AS 'Channel'
FROM  [dbo].[CD_AMN_Ads_View]
)

UNION ALL
(

SELECT  [dbo].[CD_AMN_Display_View].[date] AS 'Date',
        [dbo].[CD_AMN_Display_View].[creative] AS 'Campaign Name',
		[dbo].[CD_AMN_Display_View].[impressions] AS 'Impressions',
		[dbo].[CD_AMN_Display_View].[clickthroughs] AS 'Clicks',
		NULL AS 'Video View - 25%',
		NULL AS 'Video View - 50%',
		NULL AS 'Video View - 75%',
		NULL AS 'Video View - 100%',
		NULL AS 'Video Views',
		[dbo].[CD_AMN_Display_View].[Spend] AS 'Spend',
		[dbo].[CD_AMN_Display_View].[sales_cad] AS 'Sales',
	   'E-Com Display' AS 'Channel'

FROM  [dbo].[CD_AMN_Display_View]
)                
     
	 
	 UNION ALL
(

SELECT  [dbo].[CD_Google_Ads_New].[day] AS 'Date',
        [dbo].[CD_Google_Ads_New].[campaign] AS 'Campaign Name',
		[dbo].[CD_Google_Ads_New].[impressions] AS 'Impressions',
		[dbo].[CD_Google_Ads_New].[clicks] AS 'Clicks',
		[dbo].[CD_Google_Ads_New].[video_played_to_25] AS 'Video View - 25%',
		[dbo].[CD_Google_Ads_New].[video_played_to_50] AS 'Video View - 50%',
		[dbo].[CD_Google_Ads_New].[video_played_to_50] AS 'Video View - 75%',
		[dbo].[CD_Google_Ads_New].[video_played_to_100] AS 'Video View - 100%',
		[dbo].[CD_Google_Ads_New].[views] AS 'Video Views',
		[dbo].[CD_Google_Ads_New].[cost] AS 'Spend',
		NULL  AS 'Sales',
	   'Search' AS 'Channel'

FROM [dbo].[CD_Google_Ads_New]
)