CREATE PROCEDURE [DataSync].[CD_Google_AdWords_dss_insert_86428056-fea2-4062-8e10-5f42d853c559]
	@P_1 DateTime,
	@P_2 DateTime,
	@P_3 NVarChar(255),
	@P_4 BigInt,
	@P_5 NVarChar(max),
	@P_6 NVarChar(max),
	@P_7 NVarChar(max),
	@P_8 NVarChar(max),
	@P_9 NVarChar(200),
	@P_10 Decimal(20,4),
	@P_11 Decimal(20,4),
	@P_12 Decimal(20,4),
	@P_13 BigInt,
	@P_14 NVarChar(max),
	@P_15 BigInt,
	@P_16 Float,
	@P_17 Decimal(20,4),
	@P_18 Decimal(20,4),
	@P_19 Decimal(20,4),
	@P_20 NVarChar(max),
	@P_21 NVarChar(max),
	@P_22 Date,
	@P_23 NVarChar(200),
	@P_24 NVarChar(max),
	@P_25 Float,
	@P_26 BigInt,
	@P_27 BigInt,
	@P_28 BigInt,
	@P_29 BigInt,
	@P_30 BigInt,
	@P_31 NVarChar(max),
	@P_32 NVarChar(max),
	@P_33 Date,
	@P_34 Float,
	@P_35 Float,
	@P_36 Float,
	@P_37 Float,
	@P_38 Float,
	@P_39 BigInt,
	@P_40 BigInt,
	@sync_row_count Int OUTPUT
AS
BEGIN
SET @sync_row_count = 0; IF (NOT EXISTS (SELECT * FROM [dbo].[CD_Google_AdWords] WHERE [client_customer_id] = @P_4 AND [network_w_search_partners] = @P_9 AND [campaign_id] = @P_13 AND [day] = @P_22 AND [deviceseg] = @P_23)
 AND NOT EXISTS (SELECT * FROM [DataSync].[CD_Google_AdWords_dss_tracking] WHERE [client_customer_id] = @P_4 AND [network_w_search_partners] = @P_9 AND [campaign_id] = @P_13 AND [day] = @P_22 AND [deviceseg] = @P_23)
)
BEGIN 
INSERT INTO [dbo].[CD_Google_AdWords]([dt_created], [dt_updated], [dt_filename], [client_customer_id], [client_customer_name], [currency], [account], [network], [network_w_search_partners], [all_conv], [all_conv_value], [budget], [campaign_id], [campaign], [clicks], [conv_rate], [conversions], [total_conv_value], [cost], [crossdevice_conv], [client_name], [day], [deviceseg], [end_date], [engagement_rate], [engagements], [customer_id], [impressions], [interactions], [invalid_clicks], [labels], [search_impr_share], [start_date], [video_played_to_100], [video_played_to_25], [video_played_to_50], [video_played_to_75], [view_rate], [views], [viewthrough_conv]) VALUES (@P_1, @P_2, @P_3, @P_4, @P_5, @P_6, @P_7, @P_8, @P_9, @P_10, @P_11, @P_12, @P_13, @P_14, @P_15, @P_16, @P_17, @P_18, @P_19, @P_20, @P_21, @P_22, @P_23, @P_24, @P_25, @P_26, @P_27, @P_28, @P_29, @P_30, @P_31, @P_32, @P_33, @P_34, @P_35, @P_36, @P_37, @P_38, @P_39, @P_40);  SET @sync_row_count = @@rowcount;  END 
END