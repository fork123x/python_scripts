#/bin/bash
#
#Usage: dump data from db
#Author: xululu
#

USERNAME="anti_qa"
PASSWORD="anti_qa"
PORT=3306
HOST="cq01-anti-db000.cq01"
DB="qa_report"

tag=$1

if [[ $1 == click*  ]]; then
    sql_click_cmatch="select start_time, start_time_format_, product_id, cmatch, original_click, original_charge, normal_click, normal_charge from db_c_cmatch_stat_szwg order by start_time_format_, product_id, cmatch"
    mysql -u$USERNAME -p$PASSWORD -h$HOST -P$PORT -D$DB -N -e "$sql_click_cmatch" > click_cmatch.dat

    sql_click_flowtag="select start_time, start_time_format_, product_id, flowtag, original_click, original_charge, normal_click, normal_charge from db_c_flowtag_stat_szwg order by start_time_format_, product_id, flowtag"
    mysql -u$USERNAME -p$PASSWORD -h$HOST -P$PORT -D$DB -N -e "$sql_click_flowtag" > click_flowtag.dat

    sql_click_cmatch_policy="select start_time, start_time_format_, product_id, cmatch, policy, hit_click, hit_charge, hit_ind_click, hit_ind_charge, hit_prio_click, hit_prio_charge from db_c_cmatch_policy_stat_szwg order by start_time_format_, product_id, cmatch, policy"
    mysql -u$USERNAME -p$PASSWORD -h$HOST -P$PORT -D$DB -N -e "$sql_click_cmatch_policy" > click_cmatch_policy.dat

    sql_click_flowtag_policy="select start_time, start_time_format_, product_id, flowtag, policy, hit_click, hit_charge, hit_ind_click, hit_ind_charge, hit_prio_click, hit_prio_charge from db_c_flowtag_policy_stat_szwg order by start_time_format_, product_id, flowtag, policy"
    mysql -u$USERNAME -p$PASSWORD -h$HOST -P$PORT -D$DB -N -e "$sql_click_flowtag_policy" > click_flowtag_policy.dat

    sql_click_cmatch_browser="select start_time, start_time_format_, cmatch, browser, original_click, original_charge, normal_click, normal_charge from db_c_cmatch_stat_szwg order by start_time_format_, cmatch, browser"
    mysql -u$USERNAME -p$PASSWORD -h$HOST -P$PORT -D$DB -N -e "$sql_click_cmatch_browser" > click_cmatch_browser.dat
    
    mv click_cmatch.dat click_cmatch.dat.${tag}
    mv click_flowtag.dat click_flowtag.dat.${tag}
    mv click_cmatch_policy.dat click_cmatch_policy.dat.${tag}
    mv click_flowtag_policy.dat click_flowtag_policy.dat.${tag}
    mv click_cmatch_browser.dat click_cmatch_browser.dat.${tag}
elif [[ $1 == asp*  ]]; then
    sql_asp_cmatch="select start_time, start_time_format_, product_id, cmatch, original_pv, original_epv, original_show, normal_pv, normal_epv, normal_show from db_sc_cmatch_stat_szwg order by start_time_format_, product_id, cmatch"
    mysql -u$USERNAME -p$PASSWORD -h$HOST -P$PORT -D$DB -N -e "$sql_asp_cmatch" > asp_cmatch.dat

    sql_asp_cmatch_policy="select start_time, start_time_format_, cmatch, policy, hit_pv, hit_epv, hit_show, hit_ind_pv, hit_ind_epv, hit_ind_show, hit_prio_pv, hit_prio_epv, hit_prio_show from db_s_cmatch_policy_stat_szwg order by start_time_format_, cmatch, policy"
    mysql -u$USERNAME -p$PASSWORD -h$HOST -P$PORT -D$DB -N -e "$sql_asp_cmatch_policy" > asp_cmatch_policy.dat

    sql_asp_flowtag="select start_time, start_time_format_, product_id, flowtag, original_pv, original_epv, original_show, normal_pv, normal_epv, normal_show from db_sc_flowtag_stat_szwg order by start_time_format_, product_id, flowtag"
    mysql -u$USERNAME -p$PASSWORD -h$HOST -P$PORT -D$DB -N -e "$sql_asp_flowtag" > asp_flowtag.dat

    sql_asp_flowtag_policy="select start_time, start_time_format_, flowtag, policy, hit_pv, hit_epv, hit_show, hit_ind_pv, hit_ind_epv, hit_ind_show, hit_prio_pv, hit_prio_epv, hit_prio_show from db_s_flowtag_policy_stat_szwg order by start_time_format_, flowtag, policy"
    mysql -u$USERNAME -p$PASSWORD -h$HOST -P$PORT -D$DB -N -e "$sql_asp_flowtag_policy" > asp_flowtag_policy.dat

    sql_asp_cntname_hijack="select start_time, start_time_format_, original_cntname, fix_cntname, count from db_s_cntname_hijack_stat_szwg order by start_time_format_, original_cntname, fix_cntname"
    mysql -u$USERNAME -p$PASSWORD -h$HOST -P$PORT -D$DB -N -e "$sql_asp_cntname_hijack" > asp_cntname_hijack.dat

    sql_asp_cmatch_browser="select start_time, start_time_format_, cmatch, browser, original_pv, original_epv, original_show, normal_pv, normal_epv, normal_show from db_sc_cmatch_browser_stat_szwg order by start_time_format_, cmatch, browser"
    mysql -u$USERNAME -p$PASSWORD -h$HOST -P$PORT -D$DB -N -e "$sql_asp_cmatch_browser" > asp_cmatch_browser.dat

    mv asp_cmatch.dat asp_cmatch.dat.${tag}
    mv asp_cmatch_policy.dat asp_cmatch_policy.dat.${tag}
    mv asp_flowtag.dat asp_flowtag.dat.${tag}
    mv asp_flowtag_policy.dat asp_flowtag_policy.dat.${tag}
    mv asp_cntname_hijack.dat asp_cntname_hijack.dat.${tag}
    mv asp_cmatch_browser.dat asp_cmatch_browser.dat.${tag}
fi
