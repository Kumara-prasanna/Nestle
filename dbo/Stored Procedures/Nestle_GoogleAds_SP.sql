

CREATE PROCEDURE [dbo].[Nestle_GoogleAds_SP]
AS
BEGIN

	WITH GOOGLE_SEARCH_VIEW AS
	(

	SELECT 
	Account,
	[Ad Group],
	[All Conversions],
	[All Conversions Value],
	[Brand],
	Branded_CPC,
	Branded_Impr_Share,
	Campaign,
	Clicks,
	[Client Customer Name],
	Competitive_CPC,
	Competitive_Impr_Share,
	Conversions,
	Cost,
	[Date],
	Device,
	FilterName,
	FilterNameUpdated,
	Impressions,
	Keyword,
	[Keyword State],
	Labels,
	[Language],
	[Match Type],
	Network,
	[Network With Search Partners],
	Non_Branded_CPC,
	Non_Branded_Impr_Share,
	[Search Impression Share],
	[table],
	Targeting,
	NULL as 'Audience Detail',
	NULL as 'Campaign Free Field',
	NULL as 'Campaign ID',
	NULL as 'Campaign Match Type',
	NULL as 'Campaign Objective',
	NULL as 'Country',
	NULL as 'Decoded Audience Detail',
	NULL as 'Decoded Campaign Match Type',
	NULL as 'Decoded Campaign Objective',
	NULL as 'Decoded Master Brand',
	NULL as 'Decoded Range Brand',
	NULL as 'Decoded Sub-Segment/Category',
	NULL as 'Local Segment',
	NULL as 'Master Brand',
	NULL as 'Range Brand',
	NULL as 'Search Engine',
	NULL as 'Sub-Segment',
	NULL as 'Targeting Type',
	Campaign_Year,
	CASE
		WHEN Campaign like '2020\_%' escape '\'  THEN Campaign
		WHEN Campaign like 'CA%' THEN Campaign
		ELSE CONCAT('X - ',Campaign)
		END AS 'Campaign2',
	'Old' AS Convention
	FROM [dbo].[Nestle_Search_Google_OldConv_View_KB]


	UNION ALL

	SELECT 
	[Account],
	[Ad Group],
	[All Conversions],
	[All Conversions Value],
	Brand,
	NULL as 'Branded_CPC',
	NULL as 'Branded_Impr_Share',
	[Campaign],
	Clicks,
	[Client Customer Name],
	NULL as 'Competitive_CPC',
	NULL as 'Competitive_Impr_Share',
	Conversions,
	Cost,
	[Date],
	Device,
	[FilterName],
	FilterNameUpdated,
	Impressions,
	Keyword,
	[Keyword State],
	Labels,
	[Language],
	[Match Type],
	Network,
	[Network With Search Partners],
	NULL as 'Non_Branded_CPC',
	NULL as 'Non_Branded_Impr_Share',
	[Search Impression Share],
	[table],
	Targeting,
	[Audience Detail],
	[Campaign Free Field],
	[Campaign ID],
	[Campaign Match Type],
	[Campaign Objective],
	Country,
	[Decoded Audience Detail],
	[Decoded Campaign Match Type],
	[Decoded Campaign Objective],
	[Decoded Master Brand],
	[Decoded Range Brand],
	[Decoded Sub-Segment/Category],
	[Local Segment],
	[Master Brand],
	[Range Brand],
	[Search Engine],
	[Sub-Segment],
	[Targeting Type],
	Campaign_Year,
	CASE
		WHEN Campaign like '2020\_%' escape '\'  THEN Campaign
		WHEN Campaign like 'CA%' THEN Campaign
		ELSE CONCAT('X - ',Campaign)
		END AS 'Campaign2',
	'New' AS Convention
	FROM [dbo].[Nestle_Search_Google_NewConv_View]



	)

select a.*, b.Branded_CPC as Branded_CPC_KPI, b.Non_Branded_CPC as Non_Branded_CPC_KPI, b.Non_Branded_Impr_Share as Non_Branded_Impr_Share_KPI, 
b.Branded_Impr_Share as Branded_Impr_Share_KPI, b.Competitive_CPC as Competitive_CPC_KPI, b.Competitive_Impr_Share as Competitive_Impr_Share_KPI
from GOOGLE_SEARCH_VIEW a 
JOIN [dbo].[Nestle_Search_GoogleAds_KPI] b on a.Brand = b.Brand


END
