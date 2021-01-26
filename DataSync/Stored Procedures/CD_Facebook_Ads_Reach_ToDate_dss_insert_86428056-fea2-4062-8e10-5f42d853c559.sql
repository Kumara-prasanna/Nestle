CREATE PROCEDURE [DataSync].[CD_Facebook_Ads_Reach_ToDate_dss_insert_86428056-fea2-4062-8e10-5f42d853c559]
	@P_1 DateTime,
	@P_2 DateTime,
	@P_3 NVarChar(255),
	@P_4 BigInt,
	@P_5 BigInt,
	@P_6 BigInt,
	@P_7 BigInt,
	@P_8 NVarChar(max),
	@P_9 BigInt,
	@P_10 Date,
	@P_11 NVarChar(max),
	@P_12 Decimal(20,4),
	@P_13 Decimal(20,4),
	@P_14 DateTime,
	@P_15 DateTime,
	@sync_row_count Int OUTPUT
AS
BEGIN
SET @sync_row_count = 0; IF (NOT EXISTS (SELECT * FROM [dbo].[CD_Facebook_Ads_Reach_ToDate] WHERE [campaign_id] = @P_5 AND [account_id] = @P_9)
 AND NOT EXISTS (SELECT * FROM [DataSync].[CD_Facebook_Ads_Reach_ToDate_dss_tracking] WHERE [campaign_id] = @P_5 AND [account_id] = @P_9)
)
BEGIN 
INSERT INTO [dbo].[CD_Facebook_Ads_Reach_ToDate]([dt_created], [dt_updated], [dt_filename], [impressions], [campaign_id], [reach], [inline_link_clicks], [campaign_name], [account_id], [date_start], [account_name], [frequency], [spend], [campaign_stop_time], [campaign_start_time]) VALUES (@P_1, @P_2, @P_3, @P_4, @P_5, @P_6, @P_7, @P_8, @P_9, @P_10, @P_11, @P_12, @P_13, @P_14, @P_15);  SET @sync_row_count = @@rowcount;  END 
END