# Setting up a 64-bit ubuntu vm

### VM creation and OS install
1. Create a virtualbox 64bit ubuntu VM.. whatever you need (1024MB RAM and 1 proc work fine for me)
2. Install Ubuntu Natty 11.04 Desktop amd64

### Setup environment
1. `sudo apt-get update && sudo sudo apt-get upgrade` .. make sure all
   updates are installed.
2. `sudo apt-get install git-core git-gui gitk curl build-essential autoconf automake bison screen openssl libreadline6 libreadline6-dev zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev uuid-dev vim-gnome vim-nox exuberant-ctags libnspr4-dev mercurial libasound2-dev libcurl4-openssl-dev libnotify-dev libxt-dev libiw-dev mesa-common-dev autoconf2.13 yasm libmozjs-dev cmake-gui codeblocks-dbg codeblocks-contrib codeblocks doxygen build-essential libgmp3-dev libmpfr-dev flex ruby rubygems libsqlite3-ruby`
3. `sudo apt-get build-dep libsfml`
4. `mkdir ~/src ~/bin ~/lib ~/include ~/libexec ~/doc ~/share`
5. add `PATH=$PATH:/home/YOURUSERNAME/bin` to the end of your `~/.bashrc`
4. Install node, npm and coffee
  2. `cd src && git clone git://github.com/joyent/node.git`
  3. `cd node` .. do a `git checkout` on the latest stable tag
  4. `./configure --prefix=/home/YOURUSERNAME && make && make install`
  5. `curl http://npmjs.org/install.sh | sh`
  6. `npm install --global coffee-script`
2. install rvm and use ree
  1. `bash < <(curl -s https://rvm.beginrescueend.com/install/rvm)`
  2. `echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && .
     "$HOME/.rvm/scripts/rvm"  # Load RVM into a shell session *as a
function*' >> ~/.bashrc && source ~/.bashrc` 
  3. run `rvm notes` and follow the instructions to install needed
     packages for MRI on ubuntu (should all be included in Base System
Setup step 1 above, but you never know).
  4. `rvm install ree && rvm use --default ree`
  5. Do `ruby -v` to ensure the right version is in use. Should be used
     globally for sessions by this user from now on. 
  6. Install needed gems: `gem install sqlite3`
3. `git config --global core.autocrlf false && git config --global
   user.name "Your Name" && git config --global user.email
your@name.com`
4. `curl https://raw.github.com/carlhuda/janus/master/bootstrap.sh -o - | sh`
5. Install [gccsense](http://cx4a.org/software/gccsense/manual.html#gccrec)

You should now have:

- node.js, npm & coffeescript
- rvm-based ruby (ree 1.8.7 prolly + gems)
- vim, janus and gccsense

### .screenrc
Here's one to get you started

    hardstatus alwayslastline
    hardstatus string '%{= kG}[ %{G}%H %{g}][%= %{=kw}%?%-Lw%?%{r}(%{W}%n*%f%t%?(%u)%?%{r})%{w}%?%+Lw%?%?%= %{g}][%{B}%Y-%m-%d %{W}%c %{g}]'
    
    # Default screens
    screen -t top top
    screen -t src
    screen -t src2
    screen -t repl bash --rcfile ~/.customrc

### Add host shared folder
3. In VM window, in Devices menu, select "Install Guest Additions"
   (Host+D)
4. `sudo mkdir /mnt/cdrom && sudo mount /dev/cdrom /mnt/cdrom && sudo
   /mnt/cdrom/VBoxLinuxAdditions.run`
5. Add shared folder to wherever on your host and name it 'hostdir'
  1. `cd ~ && mkdir host`
  2. `sudo vim /etc/fstab` and add:
  `hostdir /home/jeff/host vboxsf defaults,rw,uid=1000,gid=100,dmode=1755
0 0` to the end of the file. Save and quit.
6. reboot the vm, ensure there's no error messages (esp. concerning
   mounting the share folder)

### Set up window environment
First, create an ~/.xsession file and fill it with:

    gnome-settings-daemon &
    nm-applet &
    gnome-power-manager &
    gnome-volume-manager &
    synapse -s &
    exec awesome

1. `chmod +x ~/.xsession`
2  `ln -sf /home/YOURUSERNAME/.xsession ~/.xinitrc`
1. `sudo apt-get install awesome`
2. Install synapse via `sudo add-apt-repository ppa:synapse-core/ppa && sudo apt-get update && sudo apt-get install synapse`
4. Log out and select 'user defined session' and log in
