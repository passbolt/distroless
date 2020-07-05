PHP_VERSION = "7.3"
PHP_EXT_VARIANTS = ["cli", "fpm"]

def php_extensions(extensions):
    """
    Creates a dict containing php extensions links for CLI and FPM variants and their targets

    :extensions: dict containing extension name, priority and source path
    :returns: dict with links and targets

    Example result:

    {'/etc/php/7.3/conf.d/10-opcache.ini' : '/usr/share/php7.3-opcache/opcache/opcache.ini'}
    """

    dest_path = "/etc/php/{version}/{php_variant}/conf.d/{prio}-{name}.ini"
    ext = {}
    for (k,v) in extensions.items():
        for variant in PHP_EXT_VARIANTS:
           ext[dest_path.format(version=PHP_VERSION, php_variant=variant, prio=v['prio'], name=k)] = v['path']
    return ext

