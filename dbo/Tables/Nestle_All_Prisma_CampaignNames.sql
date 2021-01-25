CREATE TABLE [dbo].[Nestle_All_Prisma_CampaignNames] (
    [CampaignName]  NVARCHAR (255) NULL,
    [PlacementName] NVARCHAR (255) NULL
);


GO
CREATE NONCLUSTERED INDEX [idx_campaignName_placement]
    ON [dbo].[Nestle_All_Prisma_CampaignNames]([CampaignName] ASC, [PlacementName] ASC);

