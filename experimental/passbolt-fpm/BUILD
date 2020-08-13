package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load("@bazel_tools//tools/build_defs/pkg:pkg.bzl", "pkg_tar")
load("@package_bundle_debian10//file:packages.bzl", "packages")
load("//experimental/php-fpm:php-extensions.bzl", "php_extensions")

PHP_VERSION = "7.3"

PHP_EXT = {
    'gnupg': { 'prio': '20', 'path': '/etc/php/7.3/mods-available/gnupg.ini'},
    'intl': { 'prio': '20', 'path': '/usr/share/php7.3-intl/intl/intl.ini'},
    'redis': { 'prio': '20', 'path': '/etc/php/7.3/mods-available/redis.ini' },
}

[container_image(
    name = ("passbolt-fpm" if (not mode) else mode[1:]) + PHP_VERSION,
    base = "//experimental/php-fpm" + (mode if  mode else ":php-fpm") + PHP_VERSION,
    symlinks = dict(php_extensions(PHP_EXT, PHP_VERSION).items() + {"/var/log/passbolt/error.log" : "/dev/stderr"}.items()),
    debs = [
        packages["gnupg-l10n"],
        packages["gpg"],
        packages["gpg-agent"],
        packages["libassuan0"],
        packages["libbz2-1.0"],
        packages["libgpgme11"],
        packages["libnpth0"],
        packages["libreadline7"],
        packages["libsqlite3-0"],
        packages["passbolt-ce-server"],
        packages["php-gnupg"],
        packages["php" + PHP_VERSION + "-intl"],
    ],
) for mode in [
    "",
    ":debug",
]]
