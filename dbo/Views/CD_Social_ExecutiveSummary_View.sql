
CREATE VIEW [dbo].[CD_Social_ExecutiveSummary_View] 
AS
	(
	SELECT [Date],
		'Facebook/Instagram' AS 'Channel',
		Account,
		--adset_name AS 'Adset Name',
		Campaign,
		Objective,
		Gender,
		Age,
		--ad_creative_thumbnail_url AS 'Creative Thumbnail URL',
		--ad_creative_image_url AS 'Creative Image URL',
		--ad_creative_title AS 'Creative Title',
		--ad_creative_body AS 'Creative Body',
		--Null AS 'Twitter Account',
		--Null AS 'tweet',
		Spend,
		Impressions,
		Clicks,
		[Language], 
		[Brand],
		--actionslink_click AS 'Link Clicks',
		--actionspost_engagement AS 'Post Engagement',
		--NULL AS 'Tweets Engagement',
		--video_play_actionsvideo_view AS 'Video Plays',
		 [Video Views],
		[Video Views - 25%],
		[Video Views - 50%],
		[Video Views - 75%],
		[Video Views - 100%]
		--NULL AS 'FilterName'
	FROM [dbo].[CD_Social_Facebook_View] WHERE [Table] = 'Age and Gender'
	)