# !/bin/sh
cat > /etc/apt/sources.list <<END
deb http://mirrors.aliyun.com/ubuntu/ xenial main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ xenial-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ xenial main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ xenial-proposed main restricted universe multiverse
END

apt-get update
apt-get install -y libaio-dev ninja-build ragel libhwloc-dev libnuma-dev libpciaccess-dev libcrypto++-dev libboost-all-dev libxml2-dev xfslibs-dev libgnutls28-dev liblz4-dev libsctp-dev gcc make libprotobuf-dev protobuf-compiler python3 libunwind8-dev systemtap-sdt-dev libtool cmake
apt-get install -y libxen-dev libssl-dev liblzma-dev
apt-get install -y redis-server golang subversion corkscrew build-essential scons

mkdir /home/coredump
chmod 777 /home/coredump
# sysctl -w kernel.core_pattern=/home/coredump/coredump-%e-%p-%t
cat > /etc/sysctl.d/coredump.conf <<EOF
kernel.core_pattern=/home/coredump/coredump-%e-%p-%t
EOF
cat > /etc/security/limits.d/coredump.conf << EOF
* soft core unlimited
EOF
cat > /home/ubuntu/.bash_profile << EOF
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

export PATH=\$PATH:\$HOME/.local/bin:\$HOME/bin
export GOROOT=/usr/bin/go
export GOPATH=/data/go
export PS1='\${debian_chroot:+(\$debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\\$ '
export ETCDCTL_API=3
EOF
ln -s /usr/lib64 /usr/seastar_lib64