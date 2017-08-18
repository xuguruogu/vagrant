#!/bin/sh
rm --interactive=never /etc/yum.repos.d/fedora*
curl -o /etc/yum.repos.d/fedora.repo http://mirrors.aliyun.com/repo/fedora.repo
curl -o /etc/yum.repos.d/fedora-updates.repo http://mirrors.aliyun.com/repo/fedora-updates.repo
dnf makecache
dnf install -y libaio-devel hwloc-devel numactl-devel libpciaccess-devel cryptopp-devel libxml2-devel xfsprogs-devel gnutls-devel lksctp-tools-devel lz4-devel gcc make protobuf-devel protobuf-compiler libunwind-devel systemtap-sdt-devel libtool cmake
dnf install -y gcc-c++ ninja-build ragel boost-devel libubsan xen-devel scons glibc-static libstdc++-static
dnf install -y subversion git corkscrew redis gdb-gdbserver ruby
dnf update -y vim-minimal
dnf install -y vim lsof tcpdump dnf-plugins-core gdb jemalloc-devel gperftools-libs wget telnet tcl java

mkdir /home/coredump
chmod 777 /home/coredump
# sysctl -w kernel.core_pattern=/home/coredump/coredump-%e-%p-%t
cat > /etc/sysctl.d/coredump.conf <<EOF
kernel.core_pattern=/home/coredump/coredump-%e-%p-%t
EOF
cat > /etc/security/limits.d/coredump.conf << EOF
* soft core unlimited
EOF
cat > /home/vagrant/.bash_profile << EOF
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

export HADOOP_HOME=/usr/local/hadoop
export PATH=\$PATH:\$HOME/.local/bin:\$HOME/bin:\$HADOOP_HOME/bin
export PS1="\[\e[37;40m\][\[\e[32;40m\]\u\[\e[37;40m\]@\h \[\e[36;40m\]\w\[\e[0m\]]\\$ "
export ETCDCTL_API=3

export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")
EOF

ln -s /usr/lib64 /usr/seastar_lib64