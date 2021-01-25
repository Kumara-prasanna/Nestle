﻿







CREATE VIEW [dbo].[Nestle_Social_Facebook_PublisherPlatform_OldNewConv_View]

AS
SELECT
[Date],
[Channel],
[Account],
[Adset Name],
[Campaign],
[Objective],
[Platform],
[Platform Position],
[Creative Thumbnail URL],
[Creative Title],
[Creative Name],
[Creative Body],
[Spend],
[Website Purchase],
[Impressions],
[Clicks],
[Link Clicks],
[Post Engagement],
[Video Plays],
[3 Sec Video Plays],
[Video Views - 25%],
[Video Views - 50%],
[Video Views - 75%],
[Video Views - 100%],
[Conversions],
NULL AS CPA,
'N/A' as CPE,
[Language],
Campaign_Year,
'N/A' as [Period],
'N/A' AS [Buy Type],
'N/A' AS [Agency Holding Group],
'N/A' AS [Decoded Master Brand],
'N/A' AS [Decoded Range Brand],
'N/A' AS [Decoded Segment],
'N/A' AS [Market],
'N/A' AS [Decoded Campaign Type],
'N/A' AS [Decoded Campaign Objective],
FilterName,
FilterNameUpdated,
Brand,
'Old' AS Convention
FROM [dbo].[Nestle_Social_Facebook_PublisherPlatform_OldConv_View]
where Campaign is not null

UNION ALL

SELECT
[Date],
'Facebook/Instagram' AS [Channel],
[Account],
[Adset Name],
[Campaign],
[Objective],
[Platform],
[Platform Position],
[Creative Thumbnail URL],
[Creative Title],
[Creative Name],
[Creative Body],
[Spend],
[Website Purchase],
[Impressions],
[Clicks],
[Link Clicks],
[Post Engagement],
[Video Plays],
[3 Sec Video Plays],
[Video Views - 25%],
[Video Views - 50%],
[Video Views - 75%],
[Video Views - 100%],
[Conversions],
CPA,
  CPE,
[Language],
 Campaign_Year,
 [Period],
 [Buy Type],
[Agency Holding Group],
 [Decoded Master Brand],
 [Decoded Range Brand],
 [Decoded Segment],
[Market],
 [Decoded Campaign Type],
 [Decoded Campaign Objective],
[FilterName],
FilterNameUpdated,
Brand,
'New' AS Convention
FROM [dbo].[Nestle_Social_Facebook_PublisherPlatform_NewConv_View]
where Campaign is not null

