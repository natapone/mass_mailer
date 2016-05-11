# mass_mailer
Send mass email from Gmail

# Installation
## Start Vagrant
HOST/vagrant$ vagrant up
HOST/vagrant$ vagrant ssh

## Install Perl dependencies
BOX$ cd /home/vagrant/project
BOX$ bash script/installdep.sh


# Test
$ prove -lv t/mails.t


# Send mails
BOX$ cd /home/vagrant/project

Open file bin/mass_mail.pl
Change campaign ID
Change mails list

BOX$ perl bin/mass_mail.pl

# Note
## email tracking
http://dyn.com/blog/tracking-email-opens-via-google-analytics/
https://developers.google.com/analytics/devguides/collection/protocol/v1/email

# Github Repository
https://github.com/natapone/mass_mailer
