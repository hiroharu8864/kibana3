kibana3 Cookbook
================
Recipe for install kibana3 to CentOS
After installing access below URL pages.
http://your url address/kibana-latest/

Usage
-----
#### kibana3::default
TODO: Write usage instructions for each cookbook.

```vm.box
   cfg.vm.box = "base64"
```

```json


e.g.
Just include `kibana3` in your node's `run_list`:

```json
{
  "run_list":[
    "recipe[kibana3::default]",
    "recipe[kibana3::kibana]"
  ]
}
```
License and Authors
-------------------
Authors: Hiroharu Tanaka
