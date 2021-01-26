





CREATE VIEW [dbo].[CD_AMN_SEM_View] AS


WITH AMS as (

(select	[adgroupid],
		NULL AS [adgroupname],
		[attributedconversions14d],
		[attributedconversions14dsamesku],
		[attributedsales14d],
		[attributedsales14dsamesku],
		NULL AS [campaignbudget],
		NULL AS [campaignbudgettype],
		[campaignid],
		[campaignname],
		[campaignstatus],
		[campaigntype],
		[clicks],
		[cost],
		[currency],
		[date],
		[dt_created],
		[dt_filename],
		[dt_updated],
		[impressions],
		[keywordid],
		[keywordtext],
		[matchtype],
		NULL AS [profilecountrycode],
		[profileid],
		[targetingtype],
		NULL as asin,
		NULL as attributedunitsordered14d,
		NULL as attributedsales14dothersku,
		NULL as attributedunitsordered14dothersku,
		NULL as otherasin,
		NULL as profilebrandname,
		NULL as sku,
		'CD_Ams_S_Brands' as [table]
from [dbo].[CD_AMN_S_Brands_Ads] Where lower(campaignname) not like '%viviscal%'
)
union all
(
select	[adgroupid],
		[adgroupname],
		NULL as attributedconversions14d,
		NULL as attributedconversions14dsamesku,
		NULL as attributedsales14d,
		NULL as attributedsales14dsamesku,
		NULL as campaignbudget,
		NULL as campaignbudgettype,
		[campaignid],
		[campaignname],
		NULL as campaignstatus,
		NULL as campaigntype,
		NULL as clicks,
		NULL as cost,
		NULL as currency,
		[date],
		[dt_created],
		[dt_filename],
		[dt_updated],
		NULL as impressions,
		[keywordid],
		[keywordtext],
		[matchtype],
		NULL as profilecountrycode,
		NULL AS [profileid],
		[targetingtype],
		[asin],
		NULL as attributedunitsordered14d,
		[attributedsales14dothersku],
		[attributedunitsordered14dothersku],
		[otherasin],
		[profilebrandname],
		[sku],
		'CD_Ams_S_Products_ASINS' as [table]
from [dbo].[CD_AMN_S_Pro_ASIN] Where lower(campaignname) not like '%viviscal%'
)

union all
(
select	[adgroupid],
		NULL AS [adgroupname],
		[attributedconversions14d],
		[attributedconversions14dsamesku],
		[attributedsales14d],
		[attributedsales14dsamesku],
		NULL as campaignbudget,
		NULL as campaignbudgettype,
		[campaignid],
		[campaignname],
		[campaignstatus],
		[campaigntype],
		[clicks],
		[cost],
		[currency],
		[date],
		[dt_created],
		[dt_filename],
		[dt_updated],
		[impressions],
		[keywordid],
		[keywordtext],
		[matchtype],
		NULL as profilecountrycode,
		NULL AS [profileid],
		[targetingtype],
		NULL as asin,
		[attributedunitsordered14d],
		NULL as attributedsales14dothersku,
		NULL as attributedunitsordered14dothersku,
		NULL as otherasin,
		NULL as profilebrandname,
		NULL as sku,
		'CD_Ams_S_Products_KW' as [table]
from [dbo].[CD_AMN_S_Pro_KW] Where lower(campaignname) not like '%viviscal%'
)
union all
(
select	[adgroupid],
		NULL AS [adgroupname],
		[attributedconversions14d],
		[attributedconversions14dsamesku],
		[attributedsales14d],
		[attributedsales14dsamesku],
		NULL AS [campaignbudget],
		[campaignbudgettype],
		[campaignid],
		[campaignname],
		[campaignstatus],
		[campaigntype],
		[clicks],
		[cost],
		[currency],
		[date],
		[dt_created],
		[dt_filename],
		[dt_updated],
		[impressions],
		NULL as keywordid,
		NULL as keywordtext,
		NULL as matchtype,
		NULL as profilecountrycode,
		[profileid],
		[targetingtype],
		[asin],
		[attributedunitsordered14d],
		NULL as attributedsales14dothersku,
		NULL as attributedunitsordered14dothersku,
		NULL as otherasin,
		[profilebrandname],
		[sku],
		'CD_Ams_S_Products_Prod_Ads' as [table]
from [dbo].[CD_AMN_S_Pro_ProAds] Where lower(campaignname) not like '%viviscal%'
)

)
SELECT  d.*, 
        e.Campaign_Name1 AS 'Campaign Name' ,
		e.Brand,
		e.Ad_Type AS 'AD Type',
		e.[Language],
		e.Targeting,

		CASE
		
			WHEN LOWER(campaignname) LIKE '%anusol%' OR LOWER(Campaign_Name) LIKE '%anusol%' THEN 'Anusol'	
            WHEN LOWER(campaignname) LIKE '%baking%' OR LOWER(Campaign_Name) LIKE '%baking%' THEN 'Arm & Hammer Baking Soda'
            WHEN LOWER(campaignname) LIKE '%litter%' OR LOWER(Campaign_Name) LIKE '%litter%' THEN  'Arm & Hammer Cat Litter'
            WHEN LOWER(campaignname) LIKE '%laundry%' OR LOWER(Campaign_Name) LIKE '%laundry%' THEN 'Arm & Hammer Laundry'
            WHEN LOWER(campaignname) LIKE '%master%' OR LOWER(Campaign_Name) LIKE '%master%' THEN 'Arm & Hammer Masterbrand'
            WHEN LOWER(campaignname) LIKE '%spinbrush%' OR LOWER(Campaign_Name) LIKE '%spinbrush%' THEN 'Arm & Hammer Spinbrush'
            WHEN LOWER(campaignname) LIKE '%tooth%' OR LOWER(Campaign_Name) LIKE '%tooth%' THEN 'Arm & Hammer Toothpaste'
            WHEN LOWER(campaignname) LIKE '%batiste%' OR LOWER(Campaign_Name) LIKE '%batiste%' THEN 'Batiste'
            WHEN LOWER(campaignname) LIKE '%response%' OR LOWER(Campaign_Name) LIKE '%response%' THEN 'First Response'
            WHEN LOWER(campaignname) LIKE '%gravol%' OR LOWER(Campaign_Name) LIKE '%gravol%' THEN 'Gravol'
            WHEN LOWER(campaignname) LIKE '%nair%' OR LOWER(Campaign_Name) LIKE '%nair%' THEN 'Nair'
            WHEN LOWER(campaignname) LIKE '%orajel%' OR LOWER(Campaign_Name) LIKE '%orajel%' THEN 'Orajel'
            WHEN LOWER(campaignname) LIKE '%oxi%' OR LOWER(Campaign_Name) LIKE '%oxi%' THEN 'OxiClean'
            WHEN LOWER(campaignname) LIKE '%rephresh%' OR LOWER(Campaign_Name) LIKE '%rephresh%' THEN 'RepHresh'
            WHEN LOWER(campaignname) LIKE '%replens%' OR LOWER(Campaign_Name) LIKE '%replens%' THEN 'Replens'
            WHEN LOWER(campaignname) LIKE '%rub%' OR LOWER(Campaign_Name) LIKE '%rub%' THEN 'Rub A535'
            WHEN LOWER(campaignname) LIKE '%toppik%' OR LOWER(Campaign_Name) LIKE '%toppik%' THEN 'Toppik'
            WHEN LOWER(campaignname) LIKE '%trojan%' OR LOWER(Campaign_Name) LIKE '%trojan%' THEN 'Trojan'
            WHEN ( LOWER(campaignname) LIKE '%vitafusion%' OR LOWER(Campaign_Name) LIKE '%vitafusion%' ) AND (LOWER(campaignname) NOT LIKE '%critters%' AND LOWER(Campaign_Name) NOT LIKE '%critters%') THEN 'Vitafusion'
            WHEN (LOWER(campaignname) LIKE '%critters%' OR LOWER(Campaign_Name) LIKE '%critters%') THEN 'Vitafusion L''il Critters'
            WHEN LOWER(campaignname) LIKE '%viviscal%' OR LOWER(Campaign_Name) LIKE '%viviscal%' THEN 'Viviscal'
            WHEN (LOWER(campaignname) LIKE '%waterpik%' OR LOWER(Campaign_Name) LIKE '%waterpik%') AND (LOWER(campaignname) NOT LIKE '%shower%' AND LOWER(Campaign_Name) NOT LIKE '%shower%') THEN 'Waterpik Flossers'
            WHEN (LOWER(campaignname) LIKE '%shower%' OR LOWER(Campaign_Name) LIKE '%shower%') AND (LOWER(campaignname) LIKE '%waterpik%' OR LOWER(Campaign_Name) LIKE '%waterpik%')THEN 'Waterpik Shower Heads'
			ELSE 'No Association'
			END
			AS FilterName, 
			    CASE
      WHEN LOWER(campaignname) LIKE '%auto%' OR Lower(Campaign_Name) LIKE '%auto%' THEN 'Automatic'
		 WHEN  Lower(campaignname) LIKE '%generic%' THEN 'Generic'
		 WHEN LOWER(campaignname) LIKE '%competitive%' OR Lower(Campaign_Name) LIKE '%competitive%' THEN 'Competitive'
		 WHEN LOWER(campaignname) LIKE '%category%' OR Lower(Campaign_Name) LIKE '%category%' THEN 'Category'
		 WHEN Lower(campaignname) LIKE '%brand%' THEN 'Brand'
		 WHEN (LOWER(campaignname) LIKE '%product%' OR Lower(Campaign_Name) LIKE '%product%')  THEN 'Product'
		 WHEN LOWER(campaignname) LIKE '%shopping%' OR Lower(Campaign_Name) LIKE '%shopping%' THEN 'Shopping'
		 WHEN LOWER(campaignname) LIKE '%affinity%' OR Lower(Campaign_Name) LIKE '%affinity%' THEN 'Affinity'
		 WHEN LOWER(campaignname) LIKE '%rlsa%' OR Lower(Campaign_Name) LIKE '%rlsa%' THEN 'RLSA'
		 WHEN LOWER(campaignname) LIKE '%retargeting%' OR Lower(Campaign_Name) LIKE '%retargeting%' THEN 'Retargeting'
		 WHEN LOWER(campaignname) LIKE '%articles%' OR Lower(Campaign_Name) LIKE '%articles%' THEN 'Articles'
		 ELSE 'Other'
		 END AS [Targeting_Updated], 

		 CASE
      WHEN (campaignname) LIKE '%SP%' OR (Campaign_Name) LIKE '%SP%' THEN 'Sponsored Products'
		 WHEN  (campaignname) LIKE '%SB%' OR (Campaign_Name) LIKE '%SB%' THEN 'Sponsored Brands'
		 ELSE 'Other'
		 END AS [AdTypeUpdated]



FROM    AMS AS d
LEFT JOIN   [dbo].[CD_Mapping]AS e 
ON     d.[campaignname] = e.Campaign_Name