package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load("@package_bundle//file:packages.bzl", "packages")
load("@bazel_tools//tools/build_defs/pkg:pkg.bzl", "pkg_tar")
load("@package_bundle_debian10//file:packages.bzl", packages_debian10 = "packages")
load("//experimental/php-fpm:php-extensions.bzl", "PHP_VERSION", "php_extensions")

PHP_EXT = {
    'apcu': { 'prio': '20', 'path': '/etc/php/7.3/mods-available/apcu.ini'},
    'gnupg': { 'prio': '20', 'path': '/etc/php/7.3/mods-available/gnupg.ini'},
    'intl': { 'prio': '20', 'path': '/usr/share/php7.3-intl/intl/intl.ini'},
    'redis': { 'prio': '20', 'path': '/etc/php/7.3/mods-available/redis.ini' },
}

[container_image(
    name = ("passbolt-fpm" if (not mode) else mode[1:]) + PHP_VERSION,
    base = "//experimental/php-fpm" + (mode if  mode else ":php-fpm") + PHP_VERSION,
    symlinks = php_extensions(PHP_EXT),
    debs = [
        packages_debian10["gnupg-l10n"],
        packages_debian10["gpg"],
        packages_debian10["gpg-agent"],
        packages_debian10["libassuan0"],
        packages_debian10["libbz2-1.0"],
        packages_debian10["libgpgme11"],
        packages_debian10["libnpth0"],
        packages_debian10["libreadline7"],
        packages_debian10["libsqlite3-0"],
        packages_debian10["passbolt-ce-server"],
        packages_debian10["php-gnupg"],
        packages_debian10["php" + PHP_VERSION + "-intl"],
        packages_debian10["php-apcu"]
    ],
) for mode in [
    "",
    ":debug",
]]
