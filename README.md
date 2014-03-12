kibana3 Cookbook
================
Recipe for install kibana3 to CentOS.

After installing, access below URL pages.

http://YourURLAddress/kibana-latest/

PreRequirement
-----
```$ vagrant box add base64 CentOS-6.3-x86_64-v20130101.box 
```


Usage
-----
#### kibana3::default
TODO: Write usage instructions for each cookbook.

```vm.box
   cfg.vm.box = "base64"
```

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
