set windows-shell := ["powershell.exe", "-NoLogo", "-Command"]

# Calls depending on which build syntax is used
BUILD_CALL := if LEGACY_PY == "true" { "build.py" } else { "build.py --flow=build" }
COMPILE_CALL := if LEGACY_PY == "true" { "compile.py" } else { "build.py --flow=compile" }

# Extra flags for vsmake and nisim
VSMAKE := ""
NISIM := ""

# Location of verible configs
DOTVIM := x'~/.vim/'

SVFORMAT_FLAGFILE := DOTVIM / "verible_fmt.txt"
SVFORMAT_CONFIG := ""

SVLINT_RULEFILE := DOTVIM / "verible_lint.txt"
help:
    just -f "{{justfile()}}" --list

_hwtools_check:
    #!/usr/bin/env sh
    if [ -z "${WORKSPACE_ROOTDIR:-}" ]; then echo "Run hwsetup first!"; exit 1; fi

[no-cd]
vhdl_ls MODELSIM_DIR:
    #!powershell.exe
    $REPO_ROOT = git rev-parse --show-toplevel
    gen_vhdl_toml {{ MODELSIM_DIR }}/vcom_filesfull.txt $REPO_ROOT

compile: _hwtools_check
    cd {{ HDL_DIR }}; python {{ COMPILE_CALL }}

build: _hwtools_check
    cd {{ HDL_DIR }}; python {{ BUILD_CALL }}

vsmake: _hwtools_check
    cd {{ HDL_DIR }}; vsmake {{ VSMAKE }}

nisim: vsmake
    cd {{ HDL_DIR }}; nisim {{ NISIM }}

[no-cd]
svfmt *FILES:
    @verible-verilog-format --inplace --flagfile {{ SVFORMAT_FLAGFILE }} {{ SVFORMAT_CONFIG }} {{ FILES }}
    @echo "Formatted files:"; echo '{{ replace(FILES, " ", "\n") }}'

svfmt-all:
    just svfmt $(fd -e sv)

[no-cd]
svfmt-here:
    just svfmt $(fd -e sv .)

[no-cd]
svlint *FILES:
    @verible-verilog-lint --rules_config {{ SVLINT_RULEFILE }} {{ FILES }}

svlint-all:
    just svlint $(fd -e sv)

[no-cd]
svlint-here:
    just svlint $(fd -e sv .)
