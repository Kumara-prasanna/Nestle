







CREATE VIEW [dbo].[Nestle_Prog_GCM_Spend_OldNewConv_View]

AS
SELECT 
[Ad_Type_Category],
NULL as 'Agency Holding Group',
[Brand],
NULL as 'Buy Type',
[Budget],
[Campaign],
[Clicks],
[Conversions],
NULL as 'CPE',
[creative],
[creative_pixel_size],
[creative_type],
[Date],
NULL as 'Decoded Campaign Objective',
NULL as 'Decoded Campaign Type',
NULL as 'Decoded Master Brand',
NULL as 'Decoded Range Brand',
NULL as 'Decoded Segment',
[FilterName],
[FilterNameUpdated],
[Impressions],
[Interactions],
[Language],
NULL as 'Market',
NULL as 'Period',
[Placement ID],
[Placement],
[Revenue],
[Search Partner],
[Spend],
[Video Plays],
[Video Views - 100%],
[Video Views - 25%],
[Video Views - 50%],
[Video Views - 75%],
[Video Views],
Campaign_Year,
'Old' AS Convention
from [dbo].[Nestle_Prog_GCM_Spend_OldConv_View]
UNION ALL

SELECT 
[Ad_Type_Category],
[Agency Holding Group],
[Brand],
[Buy Type],
NULL as 'Budget',
[Campaign],
[Clicks],
[Conversions],
[CPE],
[creative],
[creative_pixel_size],
[creative_type],
[Date],
[Decoded Campaign Objective],
[Decoded Campaign Type],
[Decoded Master Brand],
[Decoded Range Brand],
[Decoded Segment],
[FilterName],
[FilterNameUpdated],
[Impressions],
[Interactions],
[Language],
[Market],
[Period],
[Placement ID],
[Placement],
[Revenue],
[Search Partner],
NULL as 'Spend',
[Video Plays],
[Video Views - 100%],
[Video Views - 25%],
[Video Views - 50%],
[Video Views - 75%],
[Video Views],
Campaign_Year,
'New' AS Convention
FROM [dbo].[Nestle_Prog_GCM_Spend_NewConv_View]



