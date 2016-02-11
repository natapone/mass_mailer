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
