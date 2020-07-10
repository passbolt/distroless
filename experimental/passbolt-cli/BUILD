package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load("@bazel_tools//tools/build_defs/pkg:pkg.bzl", "pkg_tar")
load("@package_bundle_debian10//file:packages.bzl", "packages")
load("//experimental/php-fpm:php-extensions.bzl", "PHP_VERSION", "php_extensions")

[container_image(
    name = ("passbolt-cli" if (not mode) else mode[1:]) + PHP_VERSION,
    base = "//experimental/passbolt-fpm" + (mode if  mode else ":passbolt-fpm") + PHP_VERSION,
    debs = [
        packages["bash"],
        packages["coreutils"],
        packages["libselinux1"],
        packages["grep"],
        packages["dash"],
        packages["libpcre3"],
    ],
    entrypoint = [ "/bin/bash" ],
) for mode in [
    "",
    ":debug",
]]
