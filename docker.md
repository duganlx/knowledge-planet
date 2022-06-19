


## mysql 5.7 环境搭建 
```bash
docker run -p 3306:3306 \
--name mysql_5.7 \
-v /home/ddu/Data/mysql_57/log:/var/log/mysql \
-v /home/ddu/Data/mysql_57/data:/var/lib/mysql \
-v /home/ddu/Data/mysql_57/conf:/etc/mysql/mysql.conf.d \
-e MYSQL_ROOT_PASSWORD=pwd \
-d 2a0961b7de03
```

问题1: 数据格式
解决思路: 编写配置文件,修改为utf8编码(tips: Linux下的配置文件为.cnf,Windows下的配置文件为.ini)
```bash
docker run -p 3306:3306 --name mytest -e MYSQL_ROOT_PASSWORD=pwd -d 2a0961b7de03
docker cp mytest:/etc/mysql/mysql.conf.d/mysqld.cnf .

vim mysqld.cnf
#add the following at the end
#character_set_server=utf8
#[client]
#default-character-set=utf8
docker restart mysql_5.7

#enter mysql to check config
SHOW VARIABLES LIKE '%char%'
```

