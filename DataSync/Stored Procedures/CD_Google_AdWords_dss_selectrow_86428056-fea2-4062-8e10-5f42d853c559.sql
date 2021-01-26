﻿CREATE PROCEDURE [DataSync].[CD_Google_AdWords_dss_selectrow_86428056-fea2-4062-8e10-5f42d853c559]
	@P_4 BigInt,
	@P_9 NVarChar(200),
	@P_13 BigInt,
	@P_22 Date,
	@P_23 NVarChar(200),
	@sync_scope_local_id Int,
	@sync_scope_restore_count Int
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
SELECT (CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL 
THEN [side].[client_customer_id]
ELSE [base].[client_customer_id] END) 
as [client_customer_id], 
(CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL 
THEN [side].[network_w_search_partners]
ELSE [base].[network_w_search_partners] END) 
as [network_w_search_partners], 
(CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL 
THEN [side].[campaign_id]
ELSE [base].[campaign_id] END) 
as [campaign_id], 
(CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL 
THEN [side].[day]
ELSE [base].[day] END) 
as [day], 
(CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL 
THEN [side].[deviceseg]
ELSE [base].[deviceseg] END) 
as [deviceseg], 
[base].[dt_created], [base].[dt_updated], [base].[dt_filename], [base].[client_customer_name], [base].[currency], [base].[account], [base].[network], [base].[all_conv], [base].[all_conv_value], [base].[budget], [base].[campaign], [base].[clicks], [base].[conv_rate], [base].[conversions], [base].[total_conv_value], [base].[cost], [base].[crossdevice_conv], [base].[client_name], [base].[end_date], [base].[engagement_rate], [base].[engagements], [base].[customer_id], [base].[impressions], [base].[interactions], [base].[invalid_clicks], [base].[labels], [base].[search_impr_share], [base].[start_date], [base].[video_played_to_100], [base].[video_played_to_25], [base].[video_played_to_50], [base].[video_played_to_75], [base].[view_rate], [base].[views], [base].[viewthrough_conv], (CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL 
THEN [side].[sync_row_is_tombstone]
ELSE 0
 END) 
 as sync_row_is_tombstone, (CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL AND [side].[local_update_peer_timestamp] > @marker_local_update_peer_timestamp 
THEN [side].[local_update_peer_timestamp]
ELSE @marker_local_update_peer_timestamp
 END)  as sync_row_timestamp, case when ((CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL AND [side].[local_update_peer_timestamp] > @marker_local_update_peer_timestamp 
THEN [side].[update_scope_local_id]
ELSE @marker_update_scope_local_id
 END)  is null or (CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL AND [side].[local_update_peer_timestamp] > @marker_local_update_peer_timestamp 
THEN [side].[update_scope_local_id]
ELSE @marker_update_scope_local_id
 END)  <> @sync_scope_local_id) then (CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL AND [side].[local_update_peer_timestamp] > @marker_local_update_peer_timestamp 
THEN [side].[local_update_peer_timestamp]
ELSE @marker_local_update_peer_timestamp
 END)  else (CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL AND [side].[local_update_peer_timestamp] > @marker_local_update_peer_timestamp 
THEN [side].[scope_update_peer_timestamp]
ELSE @marker_scope_update_peer_timestamp
 END)  end as sync_update_peer_timestamp, case when ((CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL AND [side].[local_update_peer_timestamp] > @marker_local_update_peer_timestamp 
THEN [side].[update_scope_local_id]
ELSE @marker_update_scope_local_id
 END)  is null or (CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL AND [side].[local_update_peer_timestamp] > @marker_local_update_peer_timestamp 
THEN [side].[update_scope_local_id]
ELSE @marker_update_scope_local_id
 END)  <> @sync_scope_local_id) then case when ((CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL AND [side].[local_update_peer_timestamp] > @marker_local_update_peer_timestamp 
THEN [side].[local_update_peer_key]
ELSE @marker_local_update_peer_key
 END)  > @sync_scope_restore_count) then @sync_scope_restore_count else (CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL AND [side].[local_update_peer_timestamp] > @marker_local_update_peer_timestamp 
THEN [side].[local_update_peer_key]
ELSE @marker_local_update_peer_key
 END)  end else (CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL AND [side].[local_update_peer_timestamp] > @marker_local_update_peer_timestamp 
THEN [side].[scope_update_peer_key]
ELSE @marker_scope_update_peer_key
 END)  end as sync_update_peer_key, case when ((CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL 
THEN [side].[create_scope_local_id]
ELSE @marker_create_scope_local_id
 END) 
 is null or (CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL 
THEN [side].[create_scope_local_id]
ELSE @marker_create_scope_local_id
 END) 
 <> @sync_scope_local_id) then (CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL 
THEN [side].[local_create_peer_timestamp]
ELSE @marker_local_create_peer_timestamp
 END) 
 else (CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL 
THEN [side].[scope_create_peer_timestamp]
ELSE @marker_scope_create_peer_timestamp
 END) 
 end as sync_create_peer_timestamp, case when ((CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL 
THEN [side].[create_scope_local_id]
ELSE @marker_create_scope_local_id
 END) 
 is null or (CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL 
THEN [side].[create_scope_local_id]
ELSE @marker_create_scope_local_id
 END) 
 <> @sync_scope_local_id) then case when ((CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL 
THEN [side].[local_create_peer_key]
ELSE @marker_local_create_peer_key
 END) 
 > @sync_scope_restore_count) then @sync_scope_restore_count else (CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL 
THEN [side].[local_create_peer_key]
ELSE @marker_local_create_peer_key
 END) 
 end else (CASE WHEN [side].[local_create_peer_timestamp] IS NOT NULL 
THEN [side].[scope_create_peer_key]
ELSE @marker_scope_create_peer_key
 END) 
 end as sync_create_peer_key FROM (SELECT * FROM [dbo].[CD_Google_AdWords] WHERE [client_customer_id] = @P_4 AND [network_w_search_partners] = @P_9 AND [campaign_id] = @P_13 AND [day] = @P_22 AND [deviceseg] = @P_23) [base] FULL OUTER JOIN (SELECT * FROM [DataSync].[CD_Google_AdWords_dss_tracking] WHERE [client_customer_id] = @P_4 AND [network_w_search_partners] = @P_9 AND [campaign_id] = @P_13 AND [day] = @P_22 AND [deviceseg] = @P_23) [side] ON [base].[client_customer_id] = [side].[client_customer_id] AND [base].[network_w_search_partners] = [side].[network_w_search_partners] AND [base].[campaign_id] = [side].[campaign_id] AND [base].[day] = [side].[day] AND [base].[deviceseg] = [side].[deviceseg]
END