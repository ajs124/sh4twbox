# vim:et sw=2 ts=2 ai:
# ref: https://wiki.archlinux.org/index.php/Pacman_Tips

CA key problem
==============
#https://wiki.archlinux.org/index.php/Pacman-key
sudo pacman-key --init
sudo pacman-key --populate archlinux
sudo pacman-key --refresh-keys
#https://wiki.archlinux.org/index.php/Makepkg
gpg --list-keys
echo 'keyring /etc/pacman.d/gnupg/pubring.gpg' >> ~/.gnupg/gpg.conf
#https://wiki.archlinux.org/index.php/GnuPG
gpg --gen-key

Append Line
===========
sed '1 a\
> mpfr' -i ~/libmpc

problems
========
  Q: df can not work
  A: cat /proc/mounts | grep -v rootfs > /etc/mtab

  Q: telnet failed
  A: should use xinetd
    k can not login by telnet: telnetd is disabled by inetutils
    ln -sf ../bin/busybox /sbin/telnetd

methods:
  pacman -Slq -g base -g base-devel |sort -u # list all required packages
  pactree <pkgname> -- list which package required to install
  pactree -r <pkgname> -- show which packages should rebuild after pkgname

tmp:
  w3m: w3m
  #pkg-config: pkgconfig
  libsasl:  cyrus-sasl cyrus-sasl-devel
  bluez: stlinux23-sh4-bluez stlinux23-sh4-bluez-dev
  docbook2x: docbook2x
  opensp: opensp opensp-devel
  ghostscript: ghostscript ghostscript-devel

pacman: 
fail: kernel systemd libudev device-mapper(lvm2) cryptsetup
ignore: jfsutils xfsprogs reiserfsprogs pciutils pcmciautils systemd-sysvcompat
dummy:
  busybox: vi cron sed which dhcpcd
  gc(fail): gc gc-devel 7.0-7.fc9.sh4
    cp /usr/bin/libtool .
    libtool: compile:  gcc -DHAVE_CONFIG_H -I./include -I./include -I./libatomic_ops/src -I./libatomic_ops/src -fexceptions -O2 -pipe -fno-strict-aliasing -MT alloc.lo -MD -MP -MF .deps/alloc.Tpo -c alloc.c  -fPIC -DPIC -o .libs/alloc.o
    {standard input}: Assembler messages:
    {standard input}:2203: Error: tas.b use
    {standard input}:2302: Error: tas.b use
    {standard input}:2411: Error: tas.b use
    {standard input}:2514: Error: tas.b use
    {standard input}:2612: Error: tas.b use
    {standard input}:3403: Error: tas.b use
    {standard input}:4359: Error: tas.b use
    make[1]: *** [alloc.lo] Error 1

  gcc: stlinux23-sh4-gcc stlinux23-sh4-cpp stlinux23-sh4-libgcc stlinux23-sh4-libstdc++ stlinux23-sh4-libstdc++-dev 4.2.4-76.sh4
  gdb: stlinux23-sh4-gdb 7.1.50.20100224-25.sh4
  glibc: stlinux23-sh4-glibc stlinux23-sh4-glibc-dev 2.6.1-74.sh4
  iptables: stlinux23-sh4-iptables stlinux23-sh4-iptables-dev 1.4.2-10.sh4
    In file included from libxt_connbytes.c:4:
    ../include/linux/netfilter/xt_connbytes.h:20: error: expected specifier-qualifier-list before '__aligned_u64'
    libxt_connbytes.c: In function 'connbytes_parse':
    libxt_connbytes.c:39: error: 'struct <anonymous>' has no member named 'from'
    require newer linux kernel headers

  linux-api-headers(linux): stlinux23-sh4-linux-kernel-headers 2.6.23.17
  binutils: stlinux23-sh4-binutils 2.18.50.0.8-43.sh4
  openssl: stlinux23-sh4-openssl stlinux23-sh4-openssl-dev 1.0.0j-20.sh4
  tk tcl: stlinux23-sh4-tcl 8.5.8-3 stlinux23-sh4-tcl-dev # build failed
    /home/dlin/abs/local/tcl/src/tcl8.6.0/generic/tclStrToD.c: In function 'TclParseNumber':
    /home/dlin/abs/local/tcl/src/tcl8.6.0/generic/tclStrToD.c:1403: internal compiler error: Segmentation fault
    Please submit a full bug report,
    with preprocessed source if appropriate.
    See <URL:https://bugzilla.stlinux.com> for instructions.
    make: *** [tclStrToD.o] Error 1

  pam: pam pam-devel 1.0.1-4.fc9.sh4
    In file included from pam_namespace.c:37:
    pam_namespace.h:68:29: error: selinux/selinux.h: No such file or directory
    pam_namespace.h:69:38: error: selinux/get_context_list.h: No such file or directory

  keyutils: stlinux23-sh4-keyutils 1.2-3.fc9.sh4
    key.dns_resolver.o: In function `main':
    key.dns_resolver.c:(.text+0xfc0): undefined reference to `__ns_initparse'
    key.dns_resolver.c:(.text+0xfd0): undefined reference to `__ns_parserr'
    key.dns_resolver.c:(.text+0x1158): undefined reference to `__ns_name_uncompress'

TODO:
  repack: filesystem & dummy packages & shpkg packages
  vim
  libmpc
  kmod
  heirloom-mailx
  dbus
  cloog
  systemd

# cronie dhcpcd
1@t libmpc vim
2@h subversion
3@hsu [qt2] libx11 libqt
4@k libsm
5@c pacman subversion
6@tsu nfs-utils

dubs
----

configure: error: Explicitly requested systemd support, but systemd not found
==> ERROR: A failure occurred in build().


mpfr
----

mv -f .deps/const_euler.Tpo .deps/const_euler.Plo
/bin/sh ../libtool --tag=CC   --mode=compile gcc -DTIME_WITH_SYS_TIME=1 -DHAVE_I
NTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_LOCALE_H=1 -DHAVE_WCHAR_H=1 -DHAVE_STDARG=1
 -DHAVE_SYS_TIME_H=1 -DHAVE_ALLOCA_H=1 -DHAVE_STDINT_H=1 -DHAVE_VA_COPY=1 -DHAVE
 _SETLOCALE=1 -DHAVE_GETTIMEOFDAY=1 -DHAVE_LONG_LONG=1 -DHAVE_INTMAX_T=1 -DMPFR_H
 AVE_INTMAX_MAX=1 -DMPFR_HAVE_FESETROUND=1 -DHAVE_DENORMS=1 -DMPFR_NANISNAN=1 -DH
 AVE_FLOOR=1 -DHAVE_CEIL=1 -DMPFR_USE_THREAD_SAFE=1 -DLT_OBJDIR=\".libs/\" -DHAVE
 _ATTRIBUTE_MODE=1 -DHAVE___GMPN_ROOTREM=1 -DHAVE___GMPN_SBPI1_DIVAPPR_Q=1 -I.
   -O2 -pipe -MT cos.lo -MD -MP -MF .deps/cos.Tpo -c -o cos.lo cos.c
   libtool: compile:  gcc -DTIME_WITH_SYS_TIME=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_
   H=1 -DHAVE_LOCALE_H=1 -DHAVE_WCHAR_H=1 -DHAVE_STDARG=1 -DHAVE_SYS_TIME_H=1 -DHAV
   E_ALLOCA_H=1 -DHAVE_STDINT_H=1 -DHAVE_VA_COPY=1 -DHAVE_SETLOCALE=1 -DHAVE_GETTIM
   EOFDAY=1 -DHAVE_LONG_LONG=1 -DHAVE_INTMAX_T=1 -DMPFR_HAVE_INTMAX_MAX=1 -DMPFR_HA
   VE_FESETROUND=1 -DHAVE_DENORMS=1 -DMPFR_NANISNAN=1 -DHAVE_FLOOR=1 -DHAVE_CEIL=1
   -DMPFR_USE_THREAD_SAFE=1 -DLT_OBJDIR=\".libs/\" -DHAVE_ATTRIBUTE_MODE=1 -DHAVE__
   _GMPN_ROOTREM=1 -DHAVE___GMPN_SBPI1_DIVAPPR_Q=1 -I. -O2 -pipe -MT cos.lo -MD -MP
    -MF .deps/cos.Tpo -c cos.c  -fPIC -DPIC -o .libs/cos.o
    libtool: compile:  gcc -DTIME_WITH_SYS_TIME=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_
    H=1 -DHAVE_LOCALE_H=1 -DHAVE_WCHAR_H=1 -DHAVE_STDARG=1 -DHAVE_SYS_TIME_H=1 -DHAV
    E_ALLOCA_H=1 -DHAVE_STDINT_H=1 -DHAVE_VA_COPY=1 -DHAVE_SETLOCALE=1 -DHAVE_GETTIM
    EOFDAY=1 -DHAVE_LONG_LONG=1 -DHAVE_INTMAX_T=1 -DMPFR_HAVE_INTMAX_MAX=1 -DMPFR_HA
    VE_FESETROUND=1 -DHAVE_DENORMS=1 -DMPFR_NANISNAN=1 -DHAVE_FLOOR=1 -DHAVE_CEIL=1
    -DMPFR_USE_THREAD_SAFE=1 -DLT_OBJDIR=\".libs/\" -DHAVE_ATTRIBUTE_MODE=1 -DHAVE__
    _GMPN_ROOTREM=1 -DHAVE___GMPN_SBPI1_DIVAPPR_Q=1 -I. -O2 -pipe -MT cos.lo -MD -MP
     -MF .deps/cos.Tpo -c cos.c -o cos.o >/dev/null 2>&1
     make[2]: *** [cos.lo] Error 1
     make[2]: Leaving directory `/home/dlin/abs/local/mpfr/src/mpfr-3.1.1/src'
     make[1]: *** [all] Error 2
     make[1]: Leaving directory `/home/dlin/abs/local/mpfr/src/mpfr-3.1.1/src'


kmod
----

checking pkg-config is at least version 0.9.0... /usr/bin/pkg-config: error whil
e loading shared libraries: libpcre.so.1: cannot open shared object file: No suc
h file or directory
no
checking for __xstat... yes
checking for struct stat.st_mtim... yes
configure: Xz support not requested
checking for zlib... no
configure: error: in `/home/dlin/abs/local/kmod/src/kmod-12':
configure: error: The pkg-config script could not be found or is too old.  Make
sure it
is in your PATH or set the PKG_CONFIG environment variable to the full
path to pkg-config.

Alternatively, you may set the environment variables zlib_CFLAGS
and zlib_LIBS to avoid the need to call pkg-config.
See the pkg-config man page for more details.

To get pkg-config, see <http://pkg-config.freedesktop.org/>.
See `config.log' for more details
==> ERROR: A failure occurred in build().
    Aborting...

lvm2
----
  -> Extracting LVM2.2.02.98.tgz with bsdtar
  ==> Removing existing pkg/ directory...
  ==> Starting build()...
  checking build system type... sh4-unknown-linux-gnu
  checking host system type... sh4-unknown-linux-gnu
  checking target system type... sh4-unknown-linux-gnu
  checking for a sed that does not truncate output... /usr/bin/sed
  checking for gawk... gawk
  checking for gcc... gcc
  checking whether the C compiler works... yes
  checking for C compiler default output file name... a.out
  checking for suffix of executables... 
  checking whether we are cross compiling... no
  checking for suffix of object files... configure: error: in `/home/dlin/abs/local/lvm2/src/LVM2.2.02.98':
  configure: error: cannot compute suffix of object files: cannot compile
  See `config.log' for more details
  ==> ERROR: A failure occurred in build().
      Aborting...

rarian
------
Making all in util
make[2]: Entering directory `/home/dlin/abs/local/rarian/src/rarian-0.8.1/util'
gcc -DHAVE_CONFIG_H -I. -I.. -I./../librarian    -O2 -pipe -MT rarian-example.o -MD -MP -MF .deps/rarian-example.Tpo -c -o rarian-example.o rarian-example.c
mv -f .deps/rarian-example.Tpo .deps/rarian-example.Po
/bin/sh ../libtool --tag=CC   --mode=link gcc  -O2 -pipe   -o rarian-example rarian-example.o ../librarian/librarian.la 
mkdir .libs
gcc -O2 -pipe -o .libs/rarian-example rarian-example.o  ../librarian/.libs/librarian.so 
/usr/bin/ld: .libs/rarian-example: hidden symbol `__sdivsi3_i4i' in /usr/lib/gcc/sh4-linux/4.2.4/libgcc.a(_div_table.o) is referenced by DSO
/usr/bin/ld: final link failed: Nonrepresentable section on output
collect2: ld returned 1 exit status
make[2]: *** [rarian-example] Error 1
make[2]: Leaving directory `/home/dlin/abs/local/rarian/src/rarian-0.8.1/util'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/dlin/abs/local/rarian/src/rarian-0.8.1'
make: *** [all] Error 2
==> ERROR: A failure occurred in build().
    Aborting...

