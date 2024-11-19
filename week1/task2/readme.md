## 准备crossplane环境
1. 安装腾讯云机器
2. 在机器上安装k3s集群
3. 在k3s集群利用helm安装crossplane
``` bash
cd crossplane_prepare/tencent
terraform init
terraform apply -auto-apporve
```
4. 配置crossplane环境,关联腾讯云账号
``` bash
cd crossplane_prepare
kubectl apply -f providerConfig.yaml
kubectl apply -f provider.yaml
kubectl apply -f secret.yaml
```
## 利用crossplane新建CVM、subnet、VPC
``` bash
kubectl apply -f cvm/
```
## 利用crossplane新建redis
该redis实例使用的子网和vpc为cvm所创建
``` bash
kubectl apply -f redis/
```
## 资源销毁
### 销毁利用crossplane创建的cvm和redis
```
kubectl delete -f redis/
kubectl delete -f cvm/
```
### 销毁crossplane环境
``` bash
cd crossplane_prepare/tencent
# 先删除 k3s state 和 argocd state，否则会出错
$ terraform state rm 'helm_release.crossplane'
$ terraform state rm 'module.k3s'

# 再执行删除
$ terraform destroy -auto-approve
```
