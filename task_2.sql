with filled_tab as (select dt
                            , user_id
                            , event_type
                            , case when event_props is null then 0 else event_props end as event_props
                    from usr_wrk.sdd_test_sessions)
, lead_tab as (select dt
                        , case when lead(dt) over(partition by user_id order by dt) is not null then lead(dt) over(partition by user_id order by dt) else NOW() end as lead_dt
                        , event_type
                        , lead(event_type) over(partition by user_id order by dt) lead_event_type
                        , event_props
                        , user_id
                from filled_tab)
, flags_tab as (select dt
                        , lead_dt
                        , event_type
                        , lead_event_type
                        , event_props
                        , user_id
                        , extract(epoch from (lead_dt - dt))
                        , case
                                when extract(epoch from (lead_dt - dt)) > 15*60 + event_props then 1
                                when event_type = 'offline' then 1
                                else 0 end as flag
                from lead_tab)
, result as (select *
                    , sum(flag) over(partition by user_id order by dt desc) as group_number
            from flags_tab)
select user_id
        , min(dt) as start_dt
        , case when avg(group_number) = 0 and extract(epoch from (NOW() - max(dt))) < 15*60 then NULL else max(dt) end as end_dt
from result
group by group_number, user_id
