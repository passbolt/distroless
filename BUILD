package(default_visibility = ["//visibility:public"])

load("@io_bazel_rules_docker//container:container.bzl", "container_bundle")

container_bundle(
    name = "all",
    images = {
        "gcr.io/{PROJECT_ID}/base:latest": "//base:base_debian9",
        "gcr.io/{PROJECT_ID}/base:nonroot": "//base:base_nonroot_debian9",
        "gcr.io/{PROJECT_ID}/base:debug": "//base:debug_debian9",
        "gcr.io/{PROJECT_ID}/base:debug-nonroot": "//base:debug_nonroot_debian9",
        "gcr.io/{PROJECT_ID}/base-debian9:latest": "//base:base_debian9",
        "gcr.io/{PROJECT_ID}/base-debian9:nonroot": "//base:base_nonroot_debian9",
        "gcr.io/{PROJECT_ID}/base-debian9:debug": "//base:debug_debian9",
        "gcr.io/{PROJECT_ID}/base-debian9:debug-nonroot": "//base:debug_nonroot_debian9",
        "gcr.io/{PROJECT_ID}/base-debian10:latest": "//base:base_debian10",
        "gcr.io/{PROJECT_ID}/base-debian10:nonroot": "//base:base_nonroot_debian10",
        "gcr.io/{PROJECT_ID}/base-debian10:debug": "//base:debug_debian10",
        "gcr.io/{PROJECT_ID}/base-debian10:debug-nonroot": "//base:debug_nonroot_debian10",
        "gcr.io/{PROJECT_ID}/static:latest": "//base:static_debian9",
        "gcr.io/{PROJECT_ID}/static:nonroot": "//base:static_nonroot_debian9",
        "gcr.io/{PROJECT_ID}/static-debian9:latest": "//base:static_debian9",
        "gcr.io/{PROJECT_ID}/static-debian9:nonroot": "//base:static_nonroot_debian9",
        "gcr.io/{PROJECT_ID}/static-debian10:latest": "//base:static_debian10",
        "gcr.io/{PROJECT_ID}/static-debian10:nonroot": "//base:static_nonroot_debian10",
        "gcr.io/{PROJECT_ID}/cc:latest": "//cc:cc_debian9",
        "gcr.io/{PROJECT_ID}/cc:debug": "//cc:debug_debian9",
        "gcr.io/{PROJECT_ID}/cc-debian9:latest": "//cc:cc_debian9",
        "gcr.io/{PROJECT_ID}/cc-debian9:debug": "//cc:debug_debian9",
        "gcr.io/{PROJECT_ID}/cc-debian10:latest": "//cc:cc_debian10",
        "gcr.io/{PROJECT_ID}/cc-debian10:debug": "//cc:debug_debian10",
        "gcr.io/{PROJECT_ID}/java:latest": "//java:java8_debian9",
        "gcr.io/{PROJECT_ID}/java:8": "//java:java8_debian9",
        "gcr.io/{PROJECT_ID}/java:debug": "//java:java8_debug_debian9",
        "gcr.io/{PROJECT_ID}/java:8-debug": "//java:java8_debug_debian9",
        "gcr.io/{PROJECT_ID}/java:11": "//java:java11_debian9",
        "gcr.io/{PROJECT_ID}/java:11-debug": "//java:java11_debug_debian9",
        "gcr.io/{PROJECT_ID}/java-debian9:latest": "//java:java8_debian9",
        "gcr.io/{PROJECT_ID}/java-debian9:8": "//java:java8_debian9",
        "gcr.io/{PROJECT_ID}/java-debian9:debug": "//java:java8_debug_debian9",
        "gcr.io/{PROJECT_ID}/java-debian9:8-debug": "//java:java8_debug_debian9",
        "gcr.io/{PROJECT_ID}/java-debian9:11": "//java:java11_debian9",
        "gcr.io/{PROJECT_ID}/java-debian9:11-debug": "//java:java11_debug_debian9",
        "gcr.io/{PROJECT_ID}/java-debian10:latest": "//java:java11_debian10",
        "gcr.io/{PROJECT_ID}/java-debian10:11": "//java:java11_debian10",
        "gcr.io/{PROJECT_ID}/java-debian10:debug": "//java:java11_debug_debian10",
        "gcr.io/{PROJECT_ID}/java-debian10:11-debug": "//java:java11_debug_debian10",
        "gcr.io/{PROJECT_ID}/java/jetty:latest": "//java/jetty:jetty_java8_debian9",
        "gcr.io/{PROJECT_ID}/java/jetty:java8": "//java/jetty:jetty_java8_debian9",
        "gcr.io/{PROJECT_ID}/java/jetty:debug": "//java/jetty:jetty_java8_debug_debian9",
        "gcr.io/{PROJECT_ID}/java/jetty:java8-debug": "//java/jetty:jetty_java8_debug_debian9",
        "gcr.io/{PROJECT_ID}/java/jetty:java11": "//java/jetty:jetty_java11_debian9",
        "gcr.io/{PROJECT_ID}/java/jetty:java11-debug": "//java/jetty:jetty_java11_debug_debian9",
        "gcr.io/{PROJECT_ID}/java-debian9/jetty:latest": "//java/jetty:jetty_java8_debian9",
        "gcr.io/{PROJECT_ID}/java-debian9/jetty:java8": "//java/jetty:jetty_java8_debian9",
        "gcr.io/{PROJECT_ID}/java-debian9/jetty:debug": "//java/jetty:jetty_java8_debug_debian9",
        "gcr.io/{PROJECT_ID}/java-debian9/jetty:java8-debug": "//java/jetty:jetty_java8_debug_debian9",
        "gcr.io/{PROJECT_ID}/java-debian9/jetty:java11": "//java/jetty:jetty_java11_debian9",
        "gcr.io/{PROJECT_ID}/java-debian9/jetty:java11-debug": "//java/jetty:jetty_java11_debug_debian9",
        "gcr.io/{PROJECT_ID}/java-debian10/jetty:latest": "//java/jetty:jetty_java11_debian10",
        "gcr.io/{PROJECT_ID}/java-debian10/jetty:java11": "//java/jetty:jetty_java11_debian10",
        "gcr.io/{PROJECT_ID}/java-debian10/jetty:debug": "//java/jetty:jetty_java11_debug_debian10",
        "gcr.io/{PROJECT_ID}/java-debian10/jetty:java11-debug": "//java/jetty:jetty_java11_debug_debian10",
        "gcr.io/{PROJECT_ID}/php-fpm-debian10:7.3": "//experimental/php-fpm:php-fpm7.3",
        "gcr.io/{PROJECT_ID}/php-fpm-debian10:7.3-debug": "//experimental/php-fpm:debug7.3",
        "gcr.io/{PROJECT_ID}/php-fpm-debian10:latest": "//experimental/php-fpm:php-fpm7.3",
        "gcr.io/{PROJECT_ID}/python3:latest": "//experimental/python3:python3",
        "gcr.io/{PROJECT_ID}/python3:nonroot": "//experimental/python3:python3_nonroot",
        "gcr.io/{PROJECT_ID}/python3:debug": "//experimental/python3:debug",
        "gcr.io/{PROJECT_ID}/python3:debug-nonroot": "//experimental/python3:debug_nonroot",
        "gcr.io/{PROJECT_ID}/python2.7:latest": "//experimental/python2.7:python27",
        "gcr.io/{PROJECT_ID}/python2.7:debug": "//experimental/python2.7:debug",
        "gcr.io/{PROJECT_ID}/nodejs:latest": "//nodejs:nodejs14_debian9",
        "gcr.io/{PROJECT_ID}/nodejs:10": "//nodejs:nodejs10_debian9",
        "gcr.io/{PROJECT_ID}/nodejs:12": "//nodejs:nodejs12_debian9",
        "gcr.io/{PROJECT_ID}/nodejs:14": "//nodejs:nodejs14_debian9",
        "gcr.io/{PROJECT_ID}/nodejs:debug": "//nodejs:nodejs14_debug_debian9",
        "gcr.io/{PROJECT_ID}/nodejs:10-debug": "//nodejs:nodejs10_debug_debian9",
        "gcr.io/{PROJECT_ID}/nodejs:12-debug": "//nodejs:nodejs12_debug_debian9",
        "gcr.io/{PROJECT_ID}/nodejs:14-debug": "//nodejs:nodejs14_debug_debian9",
        "gcr.io/{PROJECT_ID}/nodejs-debian9:10": "//nodejs:nodejs10_debian9",
        "gcr.io/{PROJECT_ID}/nodejs-debian9:12": "//nodejs:nodejs12_debian9",
        "gcr.io/{PROJECT_ID}/nodejs-debian9:14": "//nodejs:nodejs14_debian9",
        "gcr.io/{PROJECT_ID}/nodejs-debian9:latest": "//nodejs:nodejs14_debian9",
        "gcr.io/{PROJECT_ID}/nodejs-debian9:debug": "//nodejs:nodejs14_debug_debian9",
        "gcr.io/{PROJECT_ID}/nodejs-debian9:10-debug": "//nodejs:nodejs10_debug_debian9",
        "gcr.io/{PROJECT_ID}/nodejs-debian9:12-debug": "//nodejs:nodejs12_debug_debian9",
        "gcr.io/{PROJECT_ID}/nodejs-debian9:14-debug": "//nodejs:nodejs14_debug_debian9",
        "gcr.io/{PROJECT_ID}/nodejs-debian10:10": "//nodejs:nodejs10_debian10",
        "gcr.io/{PROJECT_ID}/nodejs-debian10:12": "//nodejs:nodejs12_debian10",
        "gcr.io/{PROJECT_ID}/nodejs-debian10:14": "//nodejs:nodejs14_debian10",
        "gcr.io/{PROJECT_ID}/nodejs-debian10:latest": "//nodejs:nodejs14_debian10",
        "gcr.io/{PROJECT_ID}/nodejs-debian10:debug": "//nodejs:nodejs14_debug_debian10",
        "gcr.io/{PROJECT_ID}/nodejs-debian10:10-debug": "//nodejs:nodejs10_debug_debian10",
        "gcr.io/{PROJECT_ID}/nodejs-debian10:12-debug": "//nodejs:nodejs12_debug_debian10",
        "gcr.io/{PROJECT_ID}/nodejs-debian10:14-debug": "//nodejs:nodejs14_debug_debian10",
        "gcr.io/{PROJECT_ID}/dotnet:latest": "//experimental/dotnet:dotnet_debian9",
        "gcr.io/{PROJECT_ID}/dotnet:debug": "//experimental/dotnet:dotnet_debug_debian9",
        "gcr.io/{PROJECT_ID}/dotnet-debian9:latest": "//experimental/dotnet:dotnet_debian9",
        "gcr.io/{PROJECT_ID}/dotnet-debian9:debug": "//experimental/dotnet:dotnet_debug_debian9",
        "gcr.io/{PROJECT_ID}/dotnet-debian10:latest": "//experimental/dotnet:dotnet_debian10",
        "gcr.io/{PROJECT_ID}/dotnet-debian10:debug": "//experimental/dotnet:dotnet_debug_debian10",
        "gcr.io/{PROJECT_ID}/dotnet/core/aspnet:latest": "//experimental/dotnet:dotnet_core_aspnet_debian9",
        "gcr.io/{PROJECT_ID}/dotnet/core/aspnet:3.1": "//experimental/dotnet:dotnet_core_aspnet_debian9",
        "gcr.io/{PROJECT_ID}/dotnet/core/aspnet:debug": "//experimental/dotnet:dotnet_core_aspnet_debug_debian9",
        "gcr.io/{PROJECT_ID}/dotnet/core/runtime:latest": "//experimental/dotnet:dotnet_core_runtime_debian9",
        "gcr.io/{PROJECT_ID}/dotnet/core/runtime:3.1": "//experimental/dotnet:dotnet_core_runtime_debian9",
        "gcr.io/{PROJECT_ID}/dotnet/core/runtime:debug": "//experimental/dotnet:dotnet_core_runtime_debug_debian9",
        "gcr.io/{PROJECT_ID}/dotnet/core/sdk:latest": "//experimental/dotnet:dotnet_core_sdk_debian9",
        "gcr.io/{PROJECT_ID}/dotnet/core/sdk:3.1": "//experimental/dotnet:dotnet_core_sdk_debian9",
        "gcr.io/{PROJECT_ID}/dotnet/core/sdk:debug": "//experimental/dotnet:dotnet_core_sdk_debug_debian9",
    },
)

load("@io_bazel_rules_docker//contrib:push-all.bzl", "container_push")

container_push(
    name = "publish",
    bundle = ":all",
    format = "Docker",
)
