#!/bin/bash

echo "gacrp_indexを削除"
curl -XDELETE 'localhost:9200/gacrp_index'

echo "gacrp_indexを再作成"
curl -XPUT -H 'Content-type:application/json' 'localhost:9200/gacrp_index' -d @mapping_gacrp.json

# 
echo "bulk insertファイル作成"
split --lines 20000 ../train_blk.json train_blk_split_
sp="train_blk_split_aa"

echo "bulk insertを開始"
for spfile in `ls -1 train_blk_split_*` ;do
	curl -XPOST -H "Content-type:application/json" 'localhost:9200/_bulk?pretty' --data-binary "@${spfile}" > blk.log
done

rm train_blk_split_*
