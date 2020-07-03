package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//container:container.bzl", "container_layer")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load("@package_bundle_debian10//file:packages.bzl", "packages")

PHP_VERSION = "7.3"

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

# Builds php-cli image with base extensions: common + json + opcache + readline

[container_image(
    name = ("php" if (not mode) else mode[1:]) + PHP_VERSION,
    base = "//cc" + (mode if mode else ":cc") + distro_suffix,
    layers = ["php_dirs", "php_sessions"],
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
        packages["php7.3-cli"],
        packages["php7.3-common"],
        packages["php7.3-json"],
        packages["php7.3-opcache"],
        packages["php7.3-readline"],
        packages["zlib1g"],
    ],
    entrypoint = [
        "/usr/bin/php" + PHP_VERSION,
    ],
    env = {"LANG": "C.UTF-8"},
    symlinks = {
        "/etc/php/7.3/cli/conf.d/10-opcache.ini": "/usr/share/php7.3-opcache/opcache/opcache.ini",
        "/etc/php/7.3/cli/conf.d/10-pdo.ini": "/usr/share/php7.3-common/common/pdo.ini",
        "/etc/php/7.3/cli/conf.d/20-calendar.ini": "/usr/share/php7.3-common/common/calendar.ini",
        "/etc/php/7.3/cli/conf.d/20-ctype.ini": "/usr/share/php7.3-common/common/ctype.ini",
        "/etc/php/7.3/cli/conf.d/20-exif.ini": "/usr/share/php7.3-common/common/exif.ini",
        "/etc/php/7.3/cli/conf.d/20-fileinfo.ini": "/usr/share/php7.3-common/common/fileinfo.ini",
        "/etc/php/7.3/cli/conf.d/20-ftp.ini": "/usr/share/php7.3-common/common/ftp.ini",
        "/etc/php/7.3/cli/conf.d/20-gettext.ini": "/usr/share/php7.3-common/common/gettext.ini",
        "/etc/php/7.3/cli/conf.d/20-iconv.ini": "/usr/share/php7.3-common/common/iconv.ini",
        "/etc/php/7.3/cli/conf.d/20-json.ini": "/usr/share/php7.3-json/json/json.ini",
        "/etc/php/7.3/cli/conf.d/20-phar.ini": "/usr/share/php7.3-common/common/phar.ini",
        "/etc/php/7.3/cli/conf.d/20-posix.ini": "/usr/share/php7.3-common/common/posix.ini",
        "/etc/php/7.3/cli/conf.d/20-readline.ini": "/usr/share/php7.3-readline/readline/readline.ini",
        "/etc/php/7.3/cli/conf.d/20-shmop.ini": "/usr/share/php7.3-common/common/shmop.ini",
        "/etc/php/7.3/cli/conf.d/20-sockets.ini": "/usr/share/php7.3-common/common/sockets.ini",
        "/etc/php/7.3/cli/conf.d/20-sysvmsg.ini": "/usr/share/php7.3-common/common/sysvmsg.ini",
        "/etc/php/7.3/cli/conf.d/20-sysvsem.ini": "/usr/share/php7.3-common/common/sysvsem.ini",
        "/etc/php/7.3/cli/conf.d/20-sysvshm.ini": "/usr/share/php7.3-common/common/sysvshm.ini",
        "/etc/php/7.3/cli/conf.d/20-tokenizer.ini": "/usr/share/php7.3-common/common/tokenizer.ini",
        "/usr/bin/php": "/usr/bin/php" + PHP_VERSION,
    },
) for mode in [
    "",
    ":debug",
]]
