Vagrantfile for development environments
================================

Vagrant file for development environment running on Centos7. 

- - - -
 
### Prerequisites  
You will need the following things installed and configured in your environment:

* [Git](http://git-scm.com/)
* [Vagrant](https://www.vagrantup.com/)

### Setup
1. Clone this repository
    * `git clone [url of this repo]`
2. Create environment variable called `VAGRANT_HOST_SYNC_FOLDER` and set it to desired folder on host machine that will be synced on the guest machine. Recommended is to set it to the parent folder of where you store all of your projects.
3. Optionally, create environment variable called `VAGRANT_GUEST_IP_ADDRESS` and set it to a desired ip for the guest vm.
4. Start up the vm via vagrant
    * `cd [this repository]`
    * `vagrant up`
5. Once complete, you can ssh into the guest vm on 127.0.0.1:2222 with vagrant/vagrant as the user/password.
6. Configure the vm environment according to your needs, but only modify this repository if it can be a application-agnostic configuration

- - - -

Following is a list of environment variables that will affect the vagrant setup:

* VAGRANT_HOST_SYNC_FOLDER : determines the folder on host machine that is synced to guest machine
* VAGRANT_GUEST_IP_ADDRESS : determines the ip address to use for the guest vm. this is optional and not setting this will make vagrant use DHCP to determine guest ip.

- - - -

## TODO

* potentially upgrade to using Chef/Ansible for provisioning

- - - -

## Resources:
* [Vagrant Docs](https://www.vagrantup.com/docs/)
