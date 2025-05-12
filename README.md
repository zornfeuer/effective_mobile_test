# Решение тестового задания Effective Mobile

## Задание:

Написать скрипт на bash для мониторинга процесса test в среде linux.
Скрипт должен отвечать следующим требованиям:
1. Запускаться при запуске системы (предпочтительно написать юнит
systemd в дополнение к скрипту)
2. Отрабатывать каждую минуту
3. Если процесс запущен, то стучаться(по https) на
https://test.com/monitoring/test/api
4. Если процесс был перезапущен, писать в лог /var/log/monitoring.log
(если процесс не запущен, то ничего не делать)
5. Если сервер мониторинга не доступен, так же писать в лог.

## Запуск сервиса

Размещаем скрипт по нужному пути и делаем исполняемым командой:    

```
sudo chmod +x /usr/local/bin/monitoring_test.sh
```

Далее создаем лог-файл и назначаем права:

```
sudo touch /var/log/monitoring.log
sudo chmod 644 /var/log/monitoring.log
```

После этого активируем таймер:

```
sudo systemctl enable monitoring-test.timer
sudo systemctl start monitoring-test.timer
```
