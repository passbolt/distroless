package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//container:container.bzl", "container_layer")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load("@package_bundle//file:packages.bzl", "packages")
load("@io_bazel_rules_docker//contrib:passwd.bzl", "passwd_entry", "passwd_file")
load("@io_bazel_rules_docker//contrib:group.bzl", "group_entry", "group_file")
load("@bazel_tools//tools/build_defs/pkg:pkg.bzl", "pkg_tar")
load("@package_bundle_debian10//file:packages.bzl", packages_debian10 = "packages")

WWW_DATA = 33

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
    package_dir = "etc/php/7.3/fpm/pool.d/"
)

container_layer(
    name = "php_run_dir",
    empty_dirs = ["/run/php"],
    mode = "755",
)

DISTRO_PACKAGES = {
    "_debian9": packages,
    "_debian10": packages_debian10,
}

# distribution-specific deb dependencies
DISTRO_DEBS = {
    "_debian9": [
        "libicu57",
        "php7.0-common",
        "php7.0-cli",
        "php7.0-json",
        "php7.0-opcache",
        "php7.0-readline",
        "libpcre3"
    ],
    "_debian10": [
        "php7.3-fpm",
        "libapparmor1",
        "mime-support",
    ],
}

DISTRO_VERSION = {
    "_debian9": "7.0",
    "_debian10": "7.3",
}

[[container_image(
    name = ("php-fpm" if (not mode) else mode[1:]) + distro_suffix,
    base = "//experimental/php" + (mode if mode else ":php") + distro_suffix,
    tars = [":passwd_tar", ":group_tar", ":php_fpm_www_pool"],
    layers = ["php_run_dir"],
    debs = [
        DISTRO_PACKAGES[distro_suffix]["libgpg-error0"],
        DISTRO_PACKAGES[distro_suffix]["libgcrypt20"],
        DISTRO_PACKAGES[distro_suffix]["liblz4-1"],
        DISTRO_PACKAGES[distro_suffix]["libsystemd0"],
        DISTRO_PACKAGES[distro_suffix]["libssl1.1"],
        DISTRO_PACKAGES[distro_suffix]["libbsd0"],
        DISTRO_PACKAGES[distro_suffix]["libmagic-mgc"],
        DISTRO_PACKAGES[distro_suffix]["libmagic1"],
        DISTRO_PACKAGES[distro_suffix]["libxml2"],
        DISTRO_PACKAGES[distro_suffix]["liblzma5"],
        DISTRO_PACKAGES[distro_suffix]["zlib1g"],
    ] + [DISTRO_PACKAGES[distro_suffix][deb] for deb in DISTRO_DEBS[distro_suffix]],
    entrypoint = [
        "/usr/sbin/php-fpm" + DISTRO_VERSION[distro_suffix],
        "-F"
    ],
    env = {"LANG": "C.UTF-8"},
    symlinks = {
        "/usr/sbin/php-fpm": "/usr/sbin/php-fpm" + DISTRO_VERSION[distro_suffix],
    },
) for mode in [
    "",
    ":debug",
]] for distro_suffix in ("_debian9", "_debian10")]

alias(
    name = "php-fpm",
    actual = ":php-fpm_debian9",
)

alias(
    name = "debug",
    actual = ":debug_debian9",
)
