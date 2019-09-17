# Python Helpful Tools

## Create user based virtualenv to avoid root issues
* 1) Install virtualenv `pip install virtualenv`
* 2) Create a directory to store all virtualenvs, and `cd` to the directory
* 3) Execute `virtualenv [env_name]` - this will create a folder `[env_name]` with all the virtualenv files
* 4) Activate the venv: `source /path/to/[env_name]/bin/activate`
* 5) You can now `pip install [pkgs] --user`

## Pip offline packaging

### For machine with internet access
* 1) Make directory for storing the wheel files to be ported over e.g. `mkdir /path/to/pip_pkgs`
* 2) Execute `pip download [package_name(s)] -d /path/to/pip_pkgs`
* 3) Targz the pip packages directory: `tar czvf [pip_pkgs.tgz] [/path/to/pip_pkgs]`

### For machine without internet access
* 4) Untar pip_pkgs: `tar xzvf [pip_pkgs.tgz]`
* 5) Install pip packages: `pip install [/path/to/pip_pkgs/pip_pkg.whl(s)] -f [/path/to/pip_pkgs/] --no-index`
	1) `-f` being find links in source archive/directory provided
	2) `--no-index` being not pointing to PyPI for installing pip packages

## Pip install local library in development
* `pip install -e /path/to/[local_python_pkg]`
* This will include symlink in `site-packages` to `/path/to/[local_python_pkg]`, where you can then `import [local_python_pkg]` when running `python` anywhere in the machine
* When files in `/path/to/[local_python_pkg]` changes, latter will be reflected in `python` programs using it

## Building Cython
### Using MinGW for compiling Cython extensions
* [Installing & configure MinGW as compiler](https://cython.readthedocs.io/en/latest/src/tutorial/appendix.html)
* [Setting up other dependencies - libpython & m2w64-toolchain](https://python-at-risoe.pages.windenergy.dtu.dk/compiling-on-windows/configuration.html)

## Structuring projects
* https://dev.to/codemouse92/dead-simple-python-project-structure-and-imports-38c6
