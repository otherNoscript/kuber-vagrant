**Для RHEL7/CentOS7:**

```bash
sudo yum install git
```

Следуя инструкции https://gist.github.com/paulmaunders/3e2cbe02c07b6393f7ef0781eed9f97b необходимо установить Vagrant и VirtualBox.

**Для Debian/Ubuntu:**

```bash
sudo apt-get -y install git vagrant virtualbox
```

Склонировав репозитарий с github командой:

```bash
git clone https://github.com/otherNoscript/kubernetes-cluster.git
```

Запускаем скрипт авто-деплоя

```bash
./kubernetes-cluster/deploy.sh
```
