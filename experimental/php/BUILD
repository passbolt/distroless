package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//container:container.bzl", "container_layer")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load("@package_bundle_debian10//file:packages.bzl", "packages")
load("@io_bazel_rules_docker//contrib:passwd.bzl", "passwd_entry", "passwd_file")
load("@io_bazel_rules_docker//contrib:group.bzl", "group_entry", "group_file")
load("@bazel_tools//tools/build_defs/pkg:pkg.bzl", "pkg_tar")

PHP_VERSION = 7.3
WWW_DATA = 33

php_etcmod_prefix = "/etc/php/" + PHP_VERSION
php_mod_prefix = "/usr/share/php" + PHP_VERSION

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
        php_etcmod_prefix + variant + "/conf.d/10-opcache.ini": php_mod_prefix + "-opcache/opcache/opcache.ini",
        php_etcmod_prefix + variant + "/conf.d/10-pdo.ini": php_mod_prefix + "-common/common/pdo.ini",
        php_etcmod_prefix + variant + "/conf.d/20-calendar.ini": php_mod_prefix + "-common/common/calendar.ini",
        php_etcmod_prefix + variant + "/conf.d/20-ctype.ini": php_mod_prefix + "-common/common/ctype.ini",
        php_etcmod_prefix + variant + "/conf.d/20-exif.ini": php_mod_prefix + "-common/common/exif.ini",
        php_etcmod_prefix + variant + "/conf.d/20-fileinfo.ini": php_mod_prefix + "-common/common/fileinfo.ini",
        php_etcmod_prefix + variant + "/conf.d/20-ftp.ini": php_mod_prefix + "-common/common/ftp.ini",
        php_etcmod_prefix + variant + "/conf.d/20-gettext.ini": php_mod_prefix + "-common/common/gettext.ini",
        php_etcmod_prefix + variant + "/conf.d/20-iconv.ini": php_mod_prefix + "-common/common/iconv.ini",
        php_etcmod_prefix + variant + "/conf.d/20-json.ini": php_mod_prefix + "-json/json/json.ini",
        php_etcmod_prefix + variant + "/conf.d/20-phar.ini": php_mod_prefix + "-common/common/phar.ini",
        php_etcmod_prefix + variant + "/conf.d/20-posix.ini": php_mod_prefix + "-common/common/posix.ini",
        php_etcmod_prefix + variant + "/conf.d/20-readline.ini": php_mod_prefix + "-readline/readline/readline.ini",
        php_etcmod_prefix + variant + "/conf.d/20-shmop.ini": php_mod_prefix + "-common/common/shmop.ini",
        php_etcmod_prefix + variant + "/conf.d/20-sockets.ini": php_mod_prefix + "-common/common/sockets.ini",
        php_etcmod_prefix + variant + "/conf.d/20-sysvmsg.ini": php_mod_prefix + "-common/common/sysvmsg.ini",
        php_etcmod_prefix + variant + "/conf.d/20-sysvsem.ini": php_mod_prefix + "-common/common/sysvsem.ini",
        php_etcmod_prefix + variant + "/conf.d/20-sysvshm.ini": php_mod_prefix + "-common/common/sysvshm.ini",
        php_etcmod_prefix + variant + "/conf.d/20-tokenizer.ini": php_mod_prefix + "-common/common/tokenizer.ini",
    } for variant in ["cli", "fpm"] + {
        "/usr/bin/php": "/usr/bin/php" + PHP_VERSION,
        "/usr/sbin/php-fpm": "/usr/sbin/php-fpm" + PHP_VERSION
    },
) for mode in [
    "",
    ":debug",
]]
