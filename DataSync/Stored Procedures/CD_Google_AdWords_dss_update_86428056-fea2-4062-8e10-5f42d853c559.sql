CREATE PROCEDURE [DataSync].[CD_Google_AdWords_dss_update_86428056-fea2-4062-8e10-5f42d853c559]
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
	@sync_force_write Int,
	@sync_min_timestamp BigInt,
	@sync_row_count Int OUTPUT
AS
BEGIN
DECLARE @marker_create_scope_local_id INT
DECLARE @marker_scope_create_peer_timestamp BIGINT
DECLARE @marker_scope_create_peer_key INT
DECLARE @marker_local_create_peer_timestamp BIGINT
DECLARE @marker_local_create_peer_key INT
DECLARE @marker_state INT
SELECT TOP 1 @marker_create_scope_local_id = [provision_scope_local_id], @marker_local_create_peer_timestamp = [provision_timestamp], @marker_local_create_peer_key = [provision_local_peer_key], @marker_scope_create_peer_timestamp = [provision_scope_peer_timestamp], @marker_scope_create_peer_key = [provision_scope_peer_key], @marker_state = [state]
FROM [DataSync].[provision_marker_dss]
WHERE [object_id] = 14479676 
 AND [owner_scope_local_id] = 0

DECLARE @marker_update_scope_local_id INT
DECLARE @marker_scope_update_peer_timestamp BIGINT
DECLARE @marker_scope_update_peer_key INT
DECLARE @marker_local_update_peer_timestamp BIGINT
DECLARE @marker_local_update_peer_key INT
SELECT TOP 1 @marker_update_scope_local_id = [provision_scope_local_id], @marker_local_update_peer_timestamp = [provision_timestamp], @marker_local_update_peer_key = [provision_local_peer_key], @marker_scope_update_peer_timestamp = [provision_scope_peer_timestamp], @marker_scope_update_peer_key = [provision_scope_peer_key]
FROM [DataSync].[provision_marker_dss]
WHERE [object_id] = 14479676 
 AND [owner_scope_local_id] = 1
SET @sync_row_count = 0; UPDATE [dbo].[CD_Google_AdWords] SET [dt_created] = @P_1, [dt_updated] = @P_2, [dt_filename] = @P_3, [client_customer_name] = @P_5, [currency] = @P_6, [account] = @P_7, [network] = @P_8, [all_conv] = @P_10, [all_conv_value] = @P_11, [budget] = @P_12, [campaign] = @P_14, [clicks] = @P_15, [conv_rate] = @P_16, [conversions] = @P_17, [total_conv_value] = @P_18, [cost] = @P_19, [crossdevice_conv] = @P_20, [client_name] = @P_21, [end_date] = @P_24, [engagement_rate] = @P_25, [engagements] = @P_26, [customer_id] = @P_27, [impressions] = @P_28, [interactions] = @P_29, [invalid_clicks] = @P_30, [labels] = @P_31, [search_impr_share] = @P_32, [start_date] = @P_33, [video_played_to_100] = @P_34, [video_played_to_25] = @P_35, [video_played_to_50] = @P_36, [video_played_to_75] = @P_37, [view_rate] = @P_38, [views] = @P_39, [viewthrough_conv] = @P_40 FROM [dbo].[CD_Google_AdWords] [base] LEFT JOIN [DataSync].[CD_Google_AdWords_dss_tracking] [side] ON [base].[client_customer_id] = [side].[client_customer_id] AND [base].[network_w_search_partners] = [side].[network_w_search_partners] AND [base].[campaign_id] = [side].[campaign_id] AND [base].[day] = [side].[day] AND [base].[deviceseg] = [side].[deviceseg] WHERE ((CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL AND [side].[local_update_peer_timestamp] > @marker_local_update_peer_timestamp 
THEN [side].[local_update_peer_timestamp]
ELSE @marker_local_update_peer_timestamp
 END)  <= @sync_min_timestamp OR @sync_force_write = 1) AND ([base].[client_customer_id] = @P_4 AND [base].[network_w_search_partners] = @P_9 AND [base].[campaign_id] = @P_13 AND [base].[day] = @P_22 AND [base].[deviceseg] = @P_23); SET @sync_row_count = @@ROWCOUNT;
END