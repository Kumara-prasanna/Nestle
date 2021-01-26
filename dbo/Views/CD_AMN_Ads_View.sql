


CREATE VIEW [dbo].[CD_AMN_Ads_View] AS

--- Join both the Sponsored Brands(Headline Search) and Sponsored Products 
--- onto a single table 
WITH AMS as (

(
SELECT  a.campaigntype AS 'Campaign Type' ,
        a.attributedsales14d AS 'Sales',
		a.cost AS 'Cost',
		a.[date] AS 'Date',
		a.campaignstatus AS 'Campaign Status',
        a.attributedconversions14d AS 'Conversions',
		a.campaignname AS 'Campaign Name Old',
		a.impressions AS 'Impressions',
		a.clicks AS 'Clicks',
		NULL AS 'Units Ordered'
	 --   ,a.keywordtext AS 'Keywords',
		--a.matchtype AS 'Match Type'
FROM    [dbo].[CD_AMN_S_Brands_Ads] AS a 
)
Union All
(
SELECT  b.campaigntype AS 'Campaign Type' ,
        b.attributedsales14d AS 'Sales',
		b.cost AS 'Cost',
		b.[date] AS 'Date',
		b.campaignstatus AS 'Campaign Status',
        b.attributedconversions14d AS 'Conversions',
		b.campaignname AS 'Campaign Name Old',
		b.impressions AS 'Impressions',
		b.clicks AS 'Clicks',
		b.attributedunitsordered14d AS 'Units Ordered' 
	 --   ,c.keywordtext AS 'Keywords',
		--c.matchtype AS 'Match Type'
FROM    [dbo].[CD_AMN_S_Pro_ProAds] AS b 
--INNER JOIN    [dbo].[CD_AMN_S_Pro_KW] AS c 
--ON      b.campaignid = c.campaignid  
)
---- Using the new mapping file to update the campaign name 
) 
SELECT  d.*, 
        e.Campaign_Name1 AS 'Campaign Name' ,
		e.Brand,
		e.Ad_Type AS 'AD Type',
		e.[Language],
		e.Targeting
FROM    AMS AS d
INNER JOIN   [dbo].[CD_Mapping]AS e 
ON     d.[Campaign Name Old] = e.Campaign_Name