alacritty/local.toml should contain specific machine configurations.
This file is not tracked by git, so it should be created everytime
a machine is configured.

So in the lenovo laptop it should look like this:
```toml
[window]
startup_mode = "Maximized"
decorations = "None"

[font]
size = 9.35
```

While in my main Acer laptop it should look like this:
```toml
[window]
startup_mode = "Windowed"
dimensions = { columns = 187, lines = 45 }

[font]
size = 11
```
