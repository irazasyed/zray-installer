Zend Z-Ray Installer for Laravel Homestead
==========================================
[![Software License](https://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat-square)](LICENSE)


> Zend [Z-Ray][1] Installer for Laravel Homestead.
> Simple shell script that automatically installs the Zend [Z-Ray][1] with no user interaction required on a Laravel Homestead box.

## Pre-Requisites

- [Laravel Homestead][2] configured and running.

## Installation

**1.** SSH into your Laravel Homestead Box (`homestead ssh`)

**2.** Just fire the following command:

```
$ curl -sSL http://lk.gd/zray-install | bash
```

**3.**  Edit Homestead File `homestead edit` and add under `cpus` directive:

```yaml
ports:
    - send: 10081
      to: 10081
```

**4.** Restart and Provision Homestead:

```cli
homestead halt
homestead up --provision
```

That's it, Now open any of your homestead site and you should start seeing the Z-Ray Bar at the bottom of the page. You can access the admin panel for any of your homestead site by visiting the admin port `10081`. Example: `http://example.vm:10081/`

> **NOTE:** If Z-Ray does not load and you are getting a 500 error in your browser console, it may be necessary to re-apply the permissions to the Z-Ray folder:

```
homestead ssh
sudo chown -R vagrant:vagrant /opt/zray
```

## Additional information

Any issues, please [report here](https://github.com/irazasyed/zray-installer/issues)

Inspired to create this script by this [tutorial](https://laravel-news.com/2015/08/installing-zend-z-ray-on-homestead/) by [Mike Bronner](https://laravel-news.com/author/mikebronner/)

## Contributions

Contributions are always welcome, Please create a PR.

## License

[MIT](LICENSE) © [Syed Irfaq R.](http://lk.gd/irazasyed)

[1]: http://www.zend.com/en/products/server/z-ray
[2]: http://laravel.com/docs/homestead
