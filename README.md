# __DCS Dynamic Campaign Engine Project : Aurora__

## __When After Coding for DCS Section (./dcs/**)__
Run ```dispatch_dcs_related_files.bat``` at project root before start DCS application if you have modify any source code on file where exists in ```./dcs/**``` directories. this action will copy every dcs related source files to each directory.

## __How to Work?__
### __1. Communication Between Flutter and DCS__
This app using UDP(User Diagram Protocol) for data communication. application is server and dcs will make socket connection as client when start simulation event occur at mission load.

### __2. Communication Between DCS GameGUI and DCS Mission Environment__
DCS have Export or GameGUI environment and mission environment. mission environment divided two sub-environment that mission management and mission internal. if you want using mission environment lua classes, you can call and get return via ```net.dostring_in('server', 'string return code')```. this function will request to mission management environment and return string value. if inner return is void, you will get blank string value.

```lua
-- result: blank (string)
print(net.dostring_in("server",
  "return env.info('Hello, World!', true)"
))

-- result: "0" (string)
print(net.dostring_in("server",
  "return timer.getTime()"
))
```

if you want call user defined function where mission environment(management and internal), you can do that via ```a_do_script(string code)```. this function is same with "Do Script" trigger of mission editor. so, you can call user defined function but can't return any value. in this reason, this app have plural udp object in mission environment. you can use this as follow.

```lua
-- In GameGUI or Export Environment
net.dostring_in("mission", "return a_do_script('Function()')")

-- In Mission Environment
function Function()
  env.info("...")
  udp:send("...")
end
```

# __DevNote__
