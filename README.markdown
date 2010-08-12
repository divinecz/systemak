Systémák
========

Nástroj pro monitorování a vyčítání logů ze zařízení.

Daemon
------

Spuštění daemonu se provede příkazem ve tvaru:

	RAILS_ENV=production ./bin/scheduler_daemon.rb <start|stop|restart|run>

Obdobě se používají i ostatní příkazy daemonu.
Příkazem `run` zůstane běžet daemon na popředí a loguje přímo do terminálu.

Tasky daemonu jsou uloženy v adresáři `lib/scheduled_tasks` a momentálně obsahují pouze `device_refresh_task`,
který dotazuje zařízení každých 15s.

Stavy zařízení
--------------

Zařízení nabývají těchto stavů:

* Offline (do tohoto stavu lze uvést pouze ručně)
* Zařízení je nedostupné (nereaguje a neodpovídá na ping)
* Zařízení neodpovídá (nereaguje, ale odpovídá na ping)
* Online

Při každé změně libovolného zařízení je odeslán email na adresu uvedenou v `app/mailers/mailer.rb`.