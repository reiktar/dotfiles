
echo -n "Lastpass user: "
read LPUSER
echo -n "Lastpass Password: "
read -s LPPASS ; echo 
echo -n "Keybase User: "
read KBUSER

export CODE_DIR=~/code/ ; mkdir -p $CODE_DIR/

APTG='sudo apt-get install -y'

### Start install
sudo apt-get update
$APTG terminator tmux
$APTG build-essential checkinstall
$APTG libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev libxml2-dev
$APTG cmake
$APTG curl 


### Keybase
(
cd /tmp
curl -O https://prerelease.keybase.io/keybase_amd64.deb
sudo dpkg -i  keybase_amd64.deb
sudo apt-get install -y -f
)

( ### LASTPASS
sudo apt-get install -y libxml2-dev
sudo apt-get install -y libcurl4-openssl-dev
cd $CODE_DIR/

if [ ! -d "$CODE_DIR/lastpass-cli" ]; then
    git clone https://github.com/lastpass/lastpass-cli.git
fi
cd lastpass-cli
make
sudo make install
)

(
#LPASS SIGNIN
export LPASS_DISABLE_PINENTRY=1
echo $LPPASS | lpass login $LPUSER
)
unset LPPASS
unset LPUSER


### Personalization 
lpass show --note ssh-markus-old |ssh-add -
cd $CODE_DIR
ssh-keyscan -H github.com >> ~/.ssh/known_hosts
git clone git@github.com:xmlabs-io/dotfiles.git

cd $CODE_DIR/dotfiles/ 
git checkout begin_anew
./bootstrap.sh


##### DEV SETUP 

#( ### UNCERTAIN, requires license
#sudo apt-get install gconf2 gconf-service gconf-service-backend gconf2-common libgconf-2-4 -y
#cd /tmp/
#wget https://release.gitkraken.com/linux/gitkraken-amd64.deb
#sudo dpkg -i gitkraken-amd64.deb
#)



$APTG vim
$APTG vagrant
$APTG docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ${USER}
$APTG docker-compose

$APTG python-pip
## install dropbox
$APTG virtualenv
$APTG mysql-client


sudo sh -c '
cd /usr/src
pyver=3.5.7
if [ ! -f "Python-$pyver.tgz" ]; then
    wget https://www.python.org/ftp/python/$pyver/Python-$pyver.tgz
fi 
if [ ! -d "Python-$pyver.tgz" ]; then
    tar xzf Python-$pyver.tgz
fi
cd Python-$pyver
sudo ./configure --enable-optimizations
sudo make altinstall'


sudo sh -c '
cd /usr/src
pyver=3.6.8
if [ ! -f "Python-$pyver.tgz" ]; then
    wget https://www.python.org/ftp/python/$pyver/Python-$pyver.tgz
fi 
if [ ! -d "Python-$pyver.tgz" ]; then
    tar xzf Python-$pyver.tgz
fi
cd Python-$pyver
sudo ./configure --enable-optimizations
sudo make altinstall'


sudo sh -c '
cd /usr/src
pyver=3.7.3
if [ ! -f "Python-$pyver.tgz" ]; then
    wget https://www.python.org/ftp/python/$pyver/Python-$pyver.tgz
fi 
if [ ! -d "Python-$pyver.tgz" ]; then
    tar xzf Python-$pyver.tgz
fi
cd Python-$pyver
sudo ./configure --enable-optimizations
sudo make altinstall'



