# homelab-infra

Infrastructure as Code для домашней лаборатории на базе Proxmox VE. Проект создаёт виртуальные машины и разворачивает на них небольшой кластер K3s с базовой настройкой безопасности.

## Что автоматизировано

- Terraform создаёт ВМ в Proxmox из cloud-init-шаблона.
- Ansible ожидает доступность узлов по SSH, создаёт административного пользователя, настраивает SSH и UFW.
- Ansible разворачивает K3s: один control-plane и три worker-ноды.
- `justfile` объединяет полный сценарий развёртывания в одну команду.

## Топология

| Роль | Имя | IP-адрес | Ресурсы |
| --- | --- | --- | --- |
| K3s control-plane | `k3s-master-1` | `192.168.1.101` | 2 vCPU, 2 GiB RAM |
| K3s worker | `k3s-worker-1` | `192.168.1.102` | 1 vCPU, 3 GiB RAM |
| K3s worker | `k3s-worker-2` | `192.168.1.103` | 1 vCPU, 3 GiB RAM |
| K3s worker | `k3s-worker-3` | `192.168.1.104` | 1 vCPU, 3 GiB RAM |

Все узлы находятся в сети `192.168.1.0/24`; шлюз — `192.168.1.1`. Для создания ВМ используется Proxmox-шаблон с ID `9000`.

## Стек

- Proxmox VE - гипервизор
- Terraform - создание и управление ВМ
- Ansible - конфигурация ОС и K3s
- K3s - облегчённый дистрибьютив Kubernetes
- just - запуск типовых команд

## Структура

```text
├── terraform/          # Proxmox provider, ВМ, переменные и outputs
├── ansible/            # inventory, playbooks, роли base и k3s
├── docs/               # эксплуатационная документация
├── justfile            # команды жизненного цикла инфраструктуры
└── README.md
```

## Предварительные требования

- Доступный Proxmox VE с API и cloud-init-шаблоном `9000`.
- Рабочая станция в той же сети либо с VPN-доступом к Proxmox и ВМ.
- Установленные Terraform, Ansible и just.
- Коллекции Ansible: `ansible.posix` и `community.general`.
- API-токен Proxmox и публичный SSH-ключ администратора.

Создайте `terraform/terraform.tfvars` (он не должен попадать в Git):

```hcl
pm_api_token_id     = "<user@realm!token-name>"
pm_api_token_secret = "<token-secret>"
cluster_ssh_key     = "<public-ssh-key>"
```

Установите коллекции Ansible при первом запуске:

```bash
ansible-galaxy collection install ansible.posix community.general
```

## Запуск

```bash
# Инициализировать Terraform и провайдеры
just init

# Посмотреть план без изменений
just plan

# Создать ВМ и применить Ansible-конфигурацию
just up
```

`just up` создаёт ВМ, ждёт их SSH-доступности и последовательно применяет роли `base` и `k3s`. При первичном запуске Ansible подключается как `root`; роль `base` создаёт пользователя `ubuntu` с правами sudo и отключает вход по паролю и под `root`.

Для запуска отдельного playbook:

```bash
just play site.yml
just play k3s.yml
```

Удаление Terraform-управляемой инфраструктуры:

```bash
just down
```

> **Внимание:** `just down` удаляет все ВМ, созданные Terraform. Данные на них будут потеряны, если не предусмотрены резервные копии.

## Безопасность и доступ

Базовая роль запрещает SSH-вход под `root` и по паролю, создаёт sudo-пользователя и включает UFW с политикой deny по умолчанию. 

Инструкция по организации приватного административного доступа через OpenVPN находится в [docs/02-openvpn-bastion-workflow.md](docs/02-openvpn-bastion-workflow.md). OpenVPN не разворачивается средствами этого репозитория.

## Статус и ограничения

Проект пригоден для воспроизводимого развёртывания одноконтрольного K3s-кластера в подготовленной домашней сети. Он не является production-ready:

- параметры сети, Proxmox-нода и ID шаблона пока зафиксированы в коде;
- один control-plane не обеспечивает высокую доступность;
- K3s устанавливается без закреплённой версии;
- CI, GitOps, мониторинг и резервное копирование ещё не настроены.

Следующие цели: параметризовать окружение и inventory, устранить дублирование конфигурации, GitOps, мониторинг и проверки в CI.
