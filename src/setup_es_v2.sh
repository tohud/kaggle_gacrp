#!/bin/bash

# 実行前にjupyterのcsv2jsonでesに投げるjsonを作っておく

echo "gacrp_v2_indexを削除"
curl -XDELETE 'localhost:9200/gacrp_v2_index'

echo "gacrp_v2_indexを再作成"
curl -XPUT -H 'Content-type:application/json' 'localhost:9200/gacrp_v2_index' -d @mapping_gacrp_v2.json

# ESのbulk insertは20MBぐらいのファイル推奨のため、ファイルを分割してから投げる
rm train_v2_blk_split_*
echo "bulk insertファイル作成"
split --lines 20000 ${GACRP_HOME}/dat/train_v2_blk.json train_v2_blk_split_
sp="train_v2_blk_split_aa"

echo "bulk insertを開始"
for spfile in `ls -1 train_v2_blk_split_*` ;do
	curl -XPOST -H "Content-type:application/json" 'localhost:9200/_bulk?pretty' --data-binary "@${spfile}" > ${GACRP_HOME}/log/blk.log
done

rm train_v2_blk_split_*


rm test_v2_blk_split_*
echo "bulk insertファイル作成"
split --lines 20000 ${GACRP_HOME}/dat/test_v2_blk.json test_v2_blk_split_
sp="test_v2_blk_split_aa"

echo "bulk insertを開始"
for spfile in `ls -1 test_v2_blk_split_*` ;do
	curl -XPOST -H "Content-type:application/json" 'localhost:9200/_bulk?pretty' --data-binary "@${spfile}" >> ${GACRP_HOME}/log/blk.log
done

rm test_v2_blk_split_*
