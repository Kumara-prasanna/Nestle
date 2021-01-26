



CREATE view [dbo].[CD_AMN_Display_View] as
select	m.*, s.[Spend]
from [dbo].[CD_AMN_Display_All_Metrics] m
		inner join [dbo].[CD_AMN_Display_All_Spend] s on m.creative_id = s.creative_id and m.[Line_item_ID] = s.[Line_item_ID] and m.[Date] = s.[Date]