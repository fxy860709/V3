#!/usr/bin/env bash


grep_key_log_and_time_analyse(){
   echo "======== Analyse Time Consuming in Block $HEIGHT ========"
   # 关键日志
   enter_new_height="attempt enter new height to ($HEIGHT)"
   # 主节点
   is_proposer="($HEIGHT/0/PROPOSE) sendProposeState isProposer: true"
   gen_block="proposer success \[$HEIGHT]"
   fetch_txs="FetchTxs, height:$HEIGHT"
   gen_proposal="($HEIGHT/0/PROPOSE) generated proposal"
   # 从节点
   get_txs="GetAllTxsByBatchIds, height:$HEIGHT"
   pro_proposal="($HEIGHT/0/PROPOSE) processed proposal"
   pro_verify_res="processed verify result ($HEIGHT/"
   verify_block="verify success \[$HEIGHT,"
   # 主从节点
   add_vote_proposal="($HEIGHT/0/PROPOSE) add vote"
   add_vote_prevote="($HEIGHT/0/PREVOTE) add vote"
   add_vote_precommit="($HEIGHT/0/PRECOMMIT) add vote"
   enter_prevote="($HEIGHT/0/PROPOSE) enter prevote"
   enter_precommit="($HEIGHT/0/PREVOTE) enter precommit"
   consensus_save_wal="($HEIGHT/0/PRECOMMIT) consensus save wal"
   enter_commit="($HEIGHT/0/PRECOMMIT) enter commit"
   consensus_cost="consensus cost: {\"Height\":$HEIGHT,"
   put_block="put block\[$HEIGHT] quick"
   commit_block="commit block \[$HEIGHT]"

   key_logs=(
   "$enter_new_height"
   "$is_proposer"
   "$fetch_txs"
   "$gen_block"
   "$gen_proposal"
   "$get_txs"
   "$pro_proposal"
   "$verify_block"
   "$pro_verify_res"
   "$add_vote_proposal"
   "$add_vote_prevote"
   "$add_vote_precommit"
   "$enter_prevote"
   "$enter_precommit"
   "$consensus_save_wal"
   "$enter_commit"
   "$consensus_cost"
   "$put_block"
   "$commit_block"
   )

   # 删除临时日志
   rm -rf time_consuming_$HEIGHT.log

   # grep 关键日志到临时文件
   for keylog in "${key_logs[@]}";do
     grep "$keylog" $LOG_PATH >> time_consuming_$HEIGHT.log
   done

   # 主节点日志分析
   if [ `grep -c "$is_proposer" time_consuming_$HEIGHT.log` -ne '0' ];then
     echo "主节点耗时分析:"
     gen_block_flag="proposer success"
     fetch_txs_flag="FetchTxs,"
     gen_proposal_flag="generated proposal"
     consensus_save_wal_flag="consensus save wal,"
     consensus_cost_flag="consensus cost:"
     put_block_flag="put block"
     commit_block_flag="commit block"
     while read line
     do
       if [[ $line =~ $fetch_txs_flag ]]; then
         echo $"Txpool获取交易":${line#*$fetch_txs_flag}
       elif [[ $line =~ $gen_block_flag ]]; then
         echo $"Core构造区块":${line#*$gen_block_flag}
       elif [[ $line =~ $gen_proposal_flag ]]; then
         echo $"Consensus构造提案":${line#*$gen_proposal_flag}
       elif [[ $line =~ $consensus_save_wal_flag ]]; then
         echo $"Consensus写Wal":${line#*$consensus_save_wal_flag}
       elif [[ $line =~ $consensus_cost_flag ]]; then
         echo $"Consensus各阶段耗时":${line#*$consensus_cost_flag}
       elif [[ $line =~ $put_block_flag ]]; then
         echo $"Store异步落库":${line#*$put_block_flag}
       elif [[ $line =~ $commit_block_flag ]]; then
         echo $"Core提交区块":${line#*$commit_block_flag}
       fi
     done < time_consuming_$HEIGHT.log
   # 从节点日志分析
   else
   echo "从节点耗时分析:"
     get_txs_flag="GetAllTxsByBatchIds, "
     pro_proposal_flag="processed proposal"
     pro_verify_res_flag="processed verify result"
     verify_block_flag="verify success"
     consensus_save_wal_flag="consensus save wal,"
     consensus_cost_flag="consensus cost:"
     put_block_flag="put block"
     commit_block_flag="commit block"
     while read line
     do
       if [[ $line =~ $pro_proposal_flag ]]; then
         echo $"Consensus处理提案":${line#*$pro_proposal_flag}
       elif [[ $line =~ $get_txs_flag ]]; then
         echo $"Txpool检索交易":${line#*$get_txs_flag}
       elif [[ $line =~ $verify_block_flag ]]; then
         echo $"Core验证区块":${line#*$verify_block_flag}
       elif [[ $line =~ $pro_verify_res_flag ]]; then
         echo $"Consensus处理验证结果":${line#*$pro_verify_res_flag}
       elif [[ $line =~ $consensus_save_wal_flag ]]; then
         echo $"Consensus写Wal":${line#*$consensus_save_wal_flag}
       elif [[ $line =~ $consensus_cost_flag ]]; then
         echo $"Consensus各阶段耗时":${line#*$consensus_cost_flag}
       elif [[ $line =~ $put_block_flag ]]; then
         echo $"Store异步落库":${line#*$put_block_flag}
       elif [[ $line =~ $commit_block_flag ]]; then
         echo $"Core提交区块":${line#*$commit_block_flag}
       fi
     done < time_consuming_$HEIGHT.log
   fi
   echo "===================================================="
}

LOG_PATH=$1
HEIGHT=$2
grep_key_log_and_time_analyse



