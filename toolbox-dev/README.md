# Rust dev environment on immutable OS w/ Toolbox

1. From freshly updated system, do `toolbox create [NAME]` and let it use whatever latest base image, where `[NAME]` is whatever you want to use (I will use something like `dev`)
2. After creation, use `toolbox enter [NAME]` to enter it on the shell
3. (One time only per Kinoite install) Edit your .bashrc and add:
```
# If inside toolbox do something
if [[ "$(hostname)" = "toolbox" ]]; then
  # FIXME: also test that path exists before execution; avoid
  # chicken/egg error
	sh ~/src/misc/toolbox-dev/every-session.sh
fi
```
  Also do `chmod +x` as-needed
4. Run `first-time-setup.sh`
5. Verify working rustup in env via Step 7; verify rustup NOT infecting non-toolbox env
6. Install latest vscode rpm within toolbox env; goto [VSCode DL](https://code.visualstudio.com/download) to download, use `sudo dnf install ./filename.rpm` to install;
  A. NEED: update preferences (save on focusChange), install extensions, etc
7. Clone rust projects, use `code .` from within toolbox to open vscode, etc