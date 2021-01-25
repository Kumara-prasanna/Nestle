create view [Temp_Nestle_Prog_GCM_Spend_View] as
with dcm as (
	select placement, placement_id, date, campaign,
			sum(impressions) as impressions,
			sum(clicks) as clicks,
			sum(total_conversions) as total_conversions,
			sum(video_first_quartile_completions) as video_first_quartile_completions,
			sum(video_midpoints) as video_midpoints,
			sum(video_third_quartile_completions) as video_third_quartile_completions,
			sum(video_completions) as video_completions,
			sum(total_interactions) as total_interactions,
			sum(video_views) as video_views,
			sum(video_plays) as video_plays,
			sum(total_revenue) as total_revenue
	from Nestle_GCM
	group by placement, placement_id, date, campaign
)

select	d.*, s.Flight_Capped_Spend, s.Flight_Budget
from	Nestle_GCM_Spend s
		inner join dcm d on s.placement = d.placement and s.date = d.date
