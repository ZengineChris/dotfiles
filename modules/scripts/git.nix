{pkgs, ...}:

{
    pkgs.writeShellScriptBin "git-test" ''
        echo "hello from here"
    ''
}
