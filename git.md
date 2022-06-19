# 基本命令
git status 查看仓库当前的状态, 显示有变更的文件
git branch 查看本地分支情况
git log 查看日志 (--oneline 简洁显示, --graph 图表显示)

# 分支管理
git branch (branchname) 创建分支
git checkout (branchname) 切换分支 (-b 可创建&切换)
git branch -d (branchname) 删除分支
git merge (branchname) 将branchname分支合并到当前分支中
  (如果有冲突，则需要手动处理完后 git add&commit)

# 回退
git restore (filename) 丢弃工作区中filename的改动
git restore --staged (filename) 丢弃暂存区中filename的改动
git reset --hard [node] 丢弃所有暂存区中的修改
  (node为可选，若添加则可以回退版本库中指定的版本)
git reset --soft (node) 回到node版本，但是所作的修改都会在暂存区

