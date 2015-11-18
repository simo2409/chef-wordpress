wordpress Cookbook
==================
This cookbook installs a fresh wordpress installation.

Requirements
------------
None.

Attributes
----------
#### wordpress::default
```json
"wordpress": {
  "destination_path": "..",
  "ownership": {
    "user": "..",
    "group": ".."
  },
  "database": {
    "db_name": "..",
    "db_user": "..",
    "db_password": "..",
    "db_host": "..",
    "db_charset": "utf8",
    "db_collate": "",
    "table_prefix": "wp_"
  },
  "wp_debug": false
}
```
attributes names are the same you can find in wp-config.php

Usage
-----
#### wordpress::default
Just include `wordpress` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[wordpress]"
  ],
  "wordpress": {
    "destination_path": "..",
    "ownership": {
      "user": "..",
      "group": ".."
    },
    "database": {
      "db_name": "..",
      "db_user": "..",
      "db_password": "..",
      "db_host": "..",
      "db_charset": "utf8",
      "db_collate": "",
      "table_prefix": "wp_"
    },
    "wp_debug": false
  }
}
```
and fill attributes as needed.

Contributing
------------
Need help for testing following best practises, if you can help you are welcome!

License and Authors
-------------------
License: MIT

Authors:

Simone Dall'Angelo
