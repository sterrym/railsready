#Rails Ready
###Thanks to Josh Frye for this script.  I have made modifications to suit my needs but it all started with Josh's script.
###Ruby and Rails setup script for Linux and OSX
###Distros supported:
 * Ubuntu
 * CentOS 5 (utilizes the Fedora EPEL repo)
 * OSX (requires XCode/GCC to be installed. Install command line tools via XCode->preferences to install GCC)

#
###To run:
####Linux
  * `wget --no-check-certificate https://raw.github.com/sterrym/railsready/master/railsready.sh && bash railsready.sh`

####OSX
  * `curl -O https://raw.github.com/joshfng/railsready/master/railsready.sh && bash railsready.sh`

The script will ask if you want to build Ruby from source or install RVM

###What this gives you:
  * Homebrew (OSX only)
  * Ruby 2.0.0 latest patch level (installed to /usr/local/bin/ruby) or RVM running 2.0.0 latest patch level
  * libs needed to run Rails (sqlite, mysql, etc)
  * Rails server choice of Unicorn, Thin or Passenger
  * Nginx server
  * Bundler
  * Git

Please note: If you are running on a super slow connection your sudo session may timeout and you'll have to enter your password again. If you're running this on an EC2 or RS instance it shouldn't be problem.

#
####Rails Ready now supports a "plugin" type system. The distro is detected and a corresponding "recipe" file is pulled down to run the distro specific setup steps. Check the recipes dir to see if your distro is supported. If you would like to add support for a system fork the repo, write a recipe, and submit a pull request. Take a look at recipes/ubuntu.sh for an idea of what to model your recipe after.

If you use this or have any suggestions let me know joshfng@gmail.com or @joshfng on Twitter

###Databases

####Postgres

If you installed Postgres, you need to create a superuser for it (replace "logname" with what you want)
* `sudo -u postgres createuser --superuser `logname``

####MySQL

If you installed MySQL, you should probably secure it. I'll leave that up to you

###Rails Server choice

####Passenger

Just run `passenger-install-nginx-module` from bash prompt, upload your app, point your vhost config to your apps public dir and go!

For Passenger documentation, see https://www.phusionpassenger.com/

####Unicorn

For Unicorn docs, see http://unicorn.bogomips.org. For a basic nginx install, see http://unicorn.bogomips.org/examples/nginx.conf. For other examples see http://unicorn.bogomips.org/examples

###Now what?

Below are some other optional things you can do to configure your server

#### Create a user for deployment

`sudo adduser deploy`

If you create a deployment user, make sure you do the following as that user.

#### Generate SSH keys

`ssh-keygen -t rsa -C "your_email@youremail.com"`

####Add public key to github then test it out with this

`ssh -T git@github.com`

####Set global git identity

`git config --global user.name "John Doe"`
`git config --global user.email your_email@youremail.com`

####Set default text editor for git

`git config --global core.editor nano`

####Set git status colors

`git config --global color.diff auto`
`git config --global color.status auto`
`git config --global color.branch auto`
`git config --global color.status.changed yellow`
`git config --global color.status.added green`
`git config --global color.status.untracked red`
