**Для RHEL7/CentOS7:**

```bash
sudo yum install git
```

Следуя инструкции https://gist.github.com/paulmaunders/3e2cbe02c07b6393f7ef0781eed9f97b необходимо установить Vagrant и VirtualBox.

**Для Debian/Ubuntu:**

```bash
sudo apt-get -y install git vagrant virtualbox
```
---------------------

Склонировать репозитарий с github командой:

```bash
git clone https://github.com/otherNoscript/kubernetes-cluster.git
```

Настроки виртуального окружения выполнятеся в файле kubernetes-cluster/vagrant/config.rb

```ruby
# Выбор ветки образа CoreOS. Возможные варианты: alpha, beta, stable 
$update_channel="stable"

# Количество контроллеров Kubernetes и объем выделяемой памяти для каждой виртуальной машины
$controller_count=1
$controller_vm_memory=512

# Количество воркеров Kubernetes и объем выделяемой памяти для каждой виртуальной машины
$worker_count=3
$worker_vm_memory=2048

# Количество нод etcd и объем выделяемой памяти для каждой виртуальной машины
$etcd_count=1
$etcd_vm_memory=512
```

Запускаем скрипт авто-деплоя

```bash
./kubernetes-cluster/deploy.sh
```
