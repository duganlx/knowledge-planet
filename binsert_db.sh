#! /bin/bash

url='http://127.0.0.1:8000/v1/customer'

name=张三_
email=zhangsan_@qq.com
wechatId=zhangsan_
wechatNickname=张三_
sex=(WOMAN MAN UNKNOWN)
region=(广州 上海 武汉 长沙 北京 深圳 四川 东莞 西安 云南 桂林)
post=(COO 前端工程师 CEO 后端开发工程师 UI工程师 运维工程师 HR 实习生)
tag=(A B C D)

# return a random value in target array
function rand_value_in_array(){ 
  array=($1)
  
  len=${#array[@]}
  rand_index=$((RANDOM%len))
  rand_value=${array[rand_index]}
  
  echo $rand_value
  return $?
}


i=1
while [ $i -le 100 ]
do
  name_tmp=${name/_/$i}
  email_tmp=${email/_/$i}
  wechatId_tmp=${wechatId/_/$i}
  wechatNickname_tmp=${wechatNickname/_/$i}
  sex_tmp=$(rand_value_in_array "${sex[*]}")
  region_tmp=$(rand_value_in_array "${region[*]}")
  post_tmp=$(rand_value_in_array "${post[*]}")
  tag_tmp=$(rand_value_in_array "${tag[*]}")

  # produce mobile
  mobile_tmp=13$((RANDOM%4+6))
  for ((j=0; j<8; j++))
  do
    mobile_tmp=$mobile_tmp$((RANDOM%10))
  done

  echo $name_tmp, $email_tmp, $wechatId_tmp, $wechatNickname_tmp, $sex_tmp, $region_tmp, $mobile_tmp, $post_tmp, $tag_tmp

  curl -X 'POST' \
       $url \
       -H 'accept: application/json' \
       -H 'Content-Type: application/json' \
       -d '{
	 "Name": "'$name_tmp'",
	 "Email": "'$email_tmp'",
	 "WechatId": "'$wechatId_tmp'",
	 "WechatNickname": "'$wechatNickname_tmp'",
	 "Sex": "'$sex_tmp'",
	 "Region": "'$region_tmp'",
	 "Mobile": "'$mobile_tmp'",
	 "Posts": "'$post_tmp'",
	 "Tag": "'$tag_tmp'",
	 "Remark": ""
        }'

  let i++
done

