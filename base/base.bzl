# defines a function to replicate the container images for different distributions
load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load(":distro.bzl", "DISTRO_PACKAGES", "DISTRO_REPOSITORY")
load("//cacerts:cacerts.bzl", "cacerts")
load("//:checksums.bzl", "ARCHITECTURES")

NONROOT = 65532

# Replicate everything for debian9 and debian10
def distro_components(distro_suffix):
    for arch in ARCHITECTURES:
        cacerts(
            name = "cacerts_" + arch + distro_suffix,
            deb = DISTRO_PACKAGES[arch][distro_suffix]["ca-certificates"],
        )

        for (user, uid, workdir) in [("root", 0, "/"), ("nonroot", NONROOT, "/home/nonroot")]:
            container_image(
                name = "static_" + user + "_" + arch + distro_suffix,
                debs = [
                    DISTRO_PACKAGES[arch][distro_suffix]["base-files"],
                    DISTRO_PACKAGES[arch][distro_suffix]["netbase"],
                    DISTRO_PACKAGES[arch][distro_suffix]["tzdata"],
                ],
                architecture = arch,
                env = {
                    "PATH": "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
                    # allows openssl to find the certificates by default
                    # TODO: We should run update-ca-certifaces, but that requires "openssl rehash"
                    # which would probably need to be run inside the container
                    "SSL_CERT_FILE": "/etc/ssl/certs/ca-certificates.crt",
                },
                tars = [
                    ":passwd",
                    ":group_tar",

                    # Create /tmp, too many things assume it exists.
                    # tmp.tar has a /tmp with the correct permissions 01777
                    # A tar is needed because at the moment there is no way to create a
                    # directory with specific permissions.
                    ":tmp.tar",
                    ":nsswitch.tar",
                    DISTRO_REPOSITORY[arch][distro_suffix] + "//file:os_release.tar",
                    ":cacerts_" + arch + distro_suffix + ".tar",
                ],
                user = "%d" % uid,
                workdir = workdir,
            )

    for (user, uid, workdir) in [("root", 0, "/"), ("nonroot", NONROOT, "/home/nonroot")]:
        native.alias(
            name = "static_" + user + distro_suffix,
            actual = ":static_" + user + "_amd64" + distro_suffix,
        )

    native.alias(
        name = "cacerts" + distro_suffix,
        actual = ":cacerts_amd64" + distro_suffix,
    )

    native.alias(
        name = "static" + distro_suffix,
        actual = ":static_root_amd64" + distro_suffix,
    )

    container_image(
        name = "base" + distro_suffix,
        base = ":static" + distro_suffix,
        debs = [
            DISTRO_PACKAGES["amd64"][distro_suffix]["libc6"],
            DISTRO_PACKAGES["amd64"][distro_suffix]["libssl1.1"],
            DISTRO_PACKAGES["amd64"][distro_suffix]["openssl"],
        ],
    )

    # A debug image with busybox available.
    container_image(
        name = "debug" + distro_suffix,
        base = ":base" + distro_suffix,
        directory = "/",
        entrypoint = ["/busybox/sh"],
        env = {"PATH": "$$PATH:/busybox"},
        tars = ["//experimental/busybox:busybox.tar"],
    )

    container_image(
        name = "base_nonroot" + distro_suffix,
        base = ":base" + distro_suffix,
        user = "%d" % NONROOT,
        workdir = "/home/nonroot",
    )

    container_image(
        name = "debug_nonroot" + distro_suffix,
        base = ":debug" + distro_suffix,
        user = "%d" % NONROOT,
        workdir = "/home/nonroot",
    )

    container_test(
        name = "debug" + distro_suffix + "_test",
        configs = ["testdata/debug.yaml"],
        image = ":debug" + distro_suffix,
    )

    container_test(
        name = "base" + distro_suffix + "_test",
        configs = ["testdata/base.yaml"],
        image = ":base" + distro_suffix,
    )

    container_image(
        name = "check_certs_image" + distro_suffix,
        base = "//base:base" + distro_suffix,
        files = [":check_certs"],
        visibility = ["//visibility:private"],
    )

    container_test(
        name = "certs" + distro_suffix + "_test",
        configs = ["testdata/certs.yaml"],
        image = ":check_certs_image" + distro_suffix,
    )

    container_test(
        name = "base_release" + distro_suffix + "_test",
        configs = ["testdata/" + distro_suffix[1:] + ".yaml"],
        image = ":base" + distro_suffix,
    )

    container_test(
        name = "debug_release" + distro_suffix + "_test",
        configs = ["testdata/" + distro_suffix[1:] + ".yaml"],
        image = ":debug" + distro_suffix,
    )

    container_test(
        name = "static_release" + distro_suffix + "_test",
        configs = ["testdata/" + distro_suffix[1:] + ".yaml"],
        image = ":static" + distro_suffix,
    )
