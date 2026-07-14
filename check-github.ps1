# 检测ssh连接
ssh -T git@github.com
# 检测ssh连接 443端口
ssh -T -p 443 git@github.com
# 检测ssh连接 22端口
ssh -T -p 22 git@github.com
# 检测https连接
nslookup github.com
# 检测https连接 443端口
Test-NetConnection github.com -Port 443
# 检测https连接 22端口
Test-NetConnection github.com -Port 22
