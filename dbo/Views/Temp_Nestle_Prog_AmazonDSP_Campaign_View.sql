create view [Temp_Nestle_Prog_AmazonDSP_Campaign_View] as
select	a.*, p.campaignname
from	[dbo].[Nestle_Ams_DSP] a
		left join[dbo].[Nestle_Prisma_CampaignNames] p on a.creative = p.placementname