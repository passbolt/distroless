package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//container:container.bzl", "container_layer")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load("@package_bundle_debian10//file:packages.bzl", "packages")
load("@io_bazel_rules_docker//contrib:passwd.bzl", "passwd_entry", "passwd_file")
load("@io_bazel_rules_docker//contrib:group.bzl", "group_entry", "group_file")
load("@bazel_tools//tools/build_defs/pkg:pkg.bzl", "pkg_tar")

PHP_VERSION = "7.3"
WWW_DATA = 33

distro_suffix = "_debian10"

container_layer(
    name = "php_dirs",
    empty_dirs = ["/run/php", "/var/lib/php/modules/" + PHP_VERSION + "/registry"],
    mode = "755",
)

container_layer(
    name = "php_sessions",
    empty_dirs = ["/var/lib/php/sessions"],
    # We set sticky bit so others can write and execute on the dir
    # but not reading or deleting others files
    mode = "1733",
)

# Create a passwd file with a nonroot user and uid.
passwd_entry(
    name = "www-data_user",
    info = "ww-data",
    uid = WWW_DATA,
    gid = WWW_DATA,
    home = "/var/www",
    username = "www-data",
)

passwd_file(
    name = "passwd",
    entries = [
        ":www-data_user",
    ],
)

group_entry(
    name = "www-data_group",
    groupname = "www-data",
    gid = WWW_DATA,
    users = [ "www-data" ],
)

group_file(
    name = "group",
    entries = [
        ":www-data_group",
    ],
)

pkg_tar(
    name = "passwd_tar",
    srcs = [":passwd"],
    mode = "0644",
    package_dir = "etc",
)

pkg_tar(
    name = "group_tar",
    srcs = [":group"],
    mode = "0644",
    package_dir = "etc",
)

pkg_tar(
    name = "php_fpm_www_pool",
    srcs = ["conf/www.conf"],
    mode = "0644",
    package_dir = "etc/php/" + PHP_VERSION + "/fpm/pool.d/"
)

PHP_EXT = {
    'calendar': { 'prio': '20', 'path': '/usr/share/php7.3-common/common/calendar.ini'},
    'ctype': { 'prio': '20', 'package': '/usr/share/php7.3-common/common/calendar.ini'},
    'exif': { 'prio': '20', 'package': '/usr/share/php7.3-common/common/calendar.ini'},
    'fileinfo': { 'prio': '20', 'package': '/usr/share/php7.3-common/common/calendar.ini'},
    'ftp': { 'prio': '20', 'package': '/usr/share/php7.3-common/common/calendar.ini'},
    'gettext': { 'prio': '20', 'package': '/usr/share/php7.3-common/common/calendar.ini'},
    'iconv': { 'prio': '20', 'package': '/usr/share/php7.3-common/common/calendar.ini'},
    'json': { 'prio': '20', 'package': '/usr/share/php7.3-common/common/calendar.ini'},
    'opcache': { 'prio': '10', 'package': '/usr/share/php7.3-opcache/opcache.ini'},
    'pdo': { 'prio': '10', 'package': '/usr/share/php7.3-common/common/calendar.ini'},
    'phar': { 'prio': '20', 'package': '/usr/share/php7.3-common/common/calendar.ini'},
    'posix': { 'prio': '20', 'package': '/usr/share/php7.3-common/common/calendar.ini'},
    'readline': { 'prio': '20', 'package': '/usr/share/php7.3-readline/readline.ini'},
    'shmop': { 'prio': '20', 'package': '/usr/share/php7.3-common/common/calendar.ini'},
    'sockets': { 'prio': '20', 'package': '/usr/share/php7.3-common/common/calendar.ini'},
    'sysvmsg': { 'prio': '20', 'package': '/usr/share/php7.3-common/common/calendar.ini'},
    'sysvsem': { 'prio': '20', 'package': '/usr/share/php7.3-common/common/calendar.ini'},
    'sysvshm': { 'prio': '20', 'package': '/usr/share/php7.3-common/common/calendar.ini'},
    'tokenizer': { 'prio': '20', 'package': '/usr/share/php7.3-common/common/calendar.ini'},
    }

# Builds php-cli image with base extensions: common + json + opcache + readline

[container_image(
    name = ("php-fpm" if (not mode) else mode[1:]) + PHP_VERSION,
    base = "//cc" + (mode if mode else ":cc") + distro_suffix,
    layers = ["php_dirs", "php_sessions"],
    tars = [":passwd_tar", ":group_tar", ":php_fpm_www_pool"],
    debs = [
        packages["libargon2-1"],
        packages["libbsd0"],
        packages["libedit2"],
        packages["libicu63"],
        packages["liblzma5"],
        packages["libmagic1"],
        packages["libmagic-mgc"],
        packages["libncurses6"],
        packages["libpcre2-8-0"],
        packages["libsodium23"],
        packages["libssl1.1"],
        packages["libtinfo6"],
        packages["libxml2"],
        packages["php" + PHP_VERSION + "-cli"],
        packages["php" + PHP_VERSION + "-common"],
        packages["php" + PHP_VERSION + "-json"],
        packages["php" + PHP_VERSION + "-opcache"],
        packages["php" + PHP_VERSION + "-readline"],
        packages["zlib1g"],
        packages["libapparmor1"],
        packages["libgcrypt20"],
        packages["libgpg-error0"],
        packages["liblz4-1"],
        packages["libsystemd0"],
        packages["mime-support"],
        packages["php" + PHP_VERSION + "-fpm"],
    ],
    entrypoint = [
        "/usr/sbin/php-fpm" + PHP_VERSION,
        "-F",
        "-O"
    ],
    env = {"LANG": "C.UTF-8"},
    symlinks = {
        "/etc/php/" + PHP_VERSION + "/cli/conf.d/10-opcache.ini": "/usr/share/php" + PHP_VERSION + "-opcache/opcache/opcache.ini",
        "/etc/php/" + PHP_VERSION + "/cli/conf.d/20-calendar.ini": "/usr/share/php" + PHP_VERSION + "-common/common/calendar.ini",
        "/etc/php/" + PHP_VERSION + "/cli/conf.d/20-ctype.ini": "/usr/share/php" + PHP_VERSION + "-common/common/ctype.ini",
        "/etc/php/" + PHP_VERSION + "/cli/conf.d/20-exif.ini": "/usr/share/php" + PHP_VERSION + "-common/common/exif.ini",
        "/etc/php/" + PHP_VERSION + "/cli/conf.d/20-fileinfo.ini": "/usr/share/php" + PHP_VERSION + "-common/common/fileinfo.ini",
        "/etc/php/" + PHP_VERSION + "/cli/conf.d/20-ftp.ini": "/usr/share/php" + PHP_VERSION + "-common/common/ftp.ini",
        "/etc/php/" + PHP_VERSION + "/cli/conf.d/20-gettext.ini": "/usr/share/php" + PHP_VERSION + "-common/common/gettext.ini",
        "/etc/php/" + PHP_VERSION + "/cli/conf.d/20-iconv.ini": "/usr/share/php" + PHP_VERSION + "-common/common/iconv.ini",
        "/etc/php/" + PHP_VERSION + "/cli/conf.d/20-json.ini": "/usr/share/php" + PHP_VERSION + "-json/json/json.ini",
        "/etc/php/" + PHP_VERSION + "/cli/conf.d/20-pdo.ini": "/usr/share/php" + PHP_VERSION + "-common/common/pdo.ini",
        "/etc/php/" + PHP_VERSION + "/cli/conf.d/20-phar.ini": "/usr/share/php" + PHP_VERSION + "-common/common/phar.ini",
        "/etc/php/" + PHP_VERSION + "/cli/conf.d/20-posix.ini": "/usr/share/php" + PHP_VERSION + "-common/common/posix.ini",
        "/etc/php/" + PHP_VERSION + "/cli/conf.d/20-readline.ini": "/usr/share/php" + PHP_VERSION + "-readline/readline/readline.ini",
        "/etc/php/" + PHP_VERSION + "/cli/conf.d/20-shmop.ini": "/usr/share/php" + PHP_VERSION + "-common/common/shmop.ini",
        "/etc/php/" + PHP_VERSION + "/cli/conf.d/20-sockets.ini": "/usr/share/php" + PHP_VERSION + "-common/common/sockets.ini",
        "/etc/php/" + PHP_VERSION + "/cli/conf.d/20-sysvmsg.ini": "/usr/share/php" + PHP_VERSION + "-common/common/sysvmsg.ini",
        "/etc/php/" + PHP_VERSION + "/cli/conf.d/20-sysvsem.ini": "/usr/share/php" + PHP_VERSION + "-common/common/sysvsem.ini",
        "/etc/php/" + PHP_VERSION + "/cli/conf.d/20-sysvshm.ini": "/usr/share/php" + PHP_VERSION + "-common/common/sysvshm.ini",
        "/etc/php/" + PHP_VERSION + "/cli/conf.d/20-tokenizer.ini": "/usr/share/php" + PHP_VERSION + "-common/common/tokenizer.ini",
        "/etc/php/" + PHP_VERSION + "/fpm/conf.d/10-opcache.ini": "/usr/share/php" + PHP_VERSION + "-opcache/opcache/opcache.ini",
        "/etc/php/" + PHP_VERSION + "/fpm/conf.d/20-calendar.ini": "/usr/share/php" + PHP_VERSION + "-common/common/calendar.ini",
        "/etc/php/" + PHP_VERSION + "/fpm/conf.d/20-ctype.ini": "/usr/share/php" + PHP_VERSION + "-common/common/ctype.ini",
        "/etc/php/" + PHP_VERSION + "/fpm/conf.d/20-exif.ini": "/usr/share/php" + PHP_VERSION + "-common/common/exif.ini",
        "/etc/php/" + PHP_VERSION + "/fpm/conf.d/20-fileinfo.ini": "/usr/share/php" + PHP_VERSION + "-common/common/fileinfo.ini",
        "/etc/php/" + PHP_VERSION + "/fpm/conf.d/20-ftp.ini": "/usr/share/php" + PHP_VERSION + "-common/common/ftp.ini",
        "/etc/php/" + PHP_VERSION + "/fpm/conf.d/20-gettext.ini": "/usr/share/php" + PHP_VERSION + "-common/common/gettext.ini",
        "/etc/php/" + PHP_VERSION + "/fpm/conf.d/20-iconv.ini": "/usr/share/php" + PHP_VERSION + "-common/common/iconv.ini",
        "/etc/php/" + PHP_VERSION + "/fpm/conf.d/20-json.ini": "/usr/share/php" + PHP_VERSION + "-json/json/json.ini",
        "/etc/php/" + PHP_VERSION + "/fpm/conf.d/20-pdo.ini": "/usr/share/php" + PHP_VERSION + "-common/common/pdo.ini",
        "/etc/php/" + PHP_VERSION + "/fpm/conf.d/20-phar.ini": "/usr/share/php" + PHP_VERSION + "-common/common/phar.ini",
        "/etc/php/" + PHP_VERSION + "/fpm/conf.d/20-posix.ini": "/usr/share/php" + PHP_VERSION + "-common/common/posix.ini",
        "/etc/php/" + PHP_VERSION + "/fpm/conf.d/20-readline.ini": "/usr/share/php" + PHP_VERSION + "-readline/readline/readline.ini",
        "/etc/php/" + PHP_VERSION + "/fpm/conf.d/20-shmop.ini": "/usr/share/php" + PHP_VERSION + "-common/common/shmop.ini",
        "/etc/php/" + PHP_VERSION + "/fpm/conf.d/20-sockets.ini": "/usr/share/php" + PHP_VERSION + "-common/common/sockets.ini",
        "/etc/php/" + PHP_VERSION + "/fpm/conf.d/20-sysvmsg.ini": "/usr/share/php" + PHP_VERSION + "-common/common/sysvmsg.ini",
        "/etc/php/" + PHP_VERSION + "/fpm/conf.d/20-sysvsem.ini": "/usr/share/php" + PHP_VERSION + "-common/common/sysvsem.ini",
        "/etc/php/" + PHP_VERSION + "/fpm/conf.d/20-sysvshm.ini": "/usr/share/php" + PHP_VERSION + "-common/common/sysvshm.ini",
        "/etc/php/" + PHP_VERSION + "/fpm/conf.d/20-tokenizer.ini": "/usr/share/php" + PHP_VERSION + "-common/common/tokenizer.ini",
        "/usr/bin/php": "/usr/bin/php" + PHP_VERSION,
        "/usr/sbin/php-fpm": "/usr/sbin/php-fpm" + PHP_VERSION
    },
) for mode in [
    "",
    ":debug",
]]
