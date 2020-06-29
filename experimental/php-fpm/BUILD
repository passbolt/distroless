package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load("@package_bundle//file:packages.bzl", "packages")
load("@package_bundle_debian10//file:packages.bzl", packages_debian10 = "packages")

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
        #bzip2 file libapparmor1 libargon2-1 libbsd0 libedit2 libgpm2 libicu63 libmagic-mgc libmagic1 libncurses6 libpcre2-8-0 libsodium23 libssl1.1 libxml2 mime-support php-common php7.3-cli php7.3-common php7.3-json php7.3-opcache
  #php7.3-readline psmisc sensible-utils ucf xz-utils
    ],
}

DISTRO_VERSION = {
    "_debian9": "7.0",
    "_debian10": "7.3",
}

[[container_image(
    name = ("php-fpm" if (not mode) else mode[1:]) + distro_suffix,
    base = "//experimental/php" + (mode if mode else ":php") + distro_suffix,
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
