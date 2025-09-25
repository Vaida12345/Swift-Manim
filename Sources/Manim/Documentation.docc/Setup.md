
# Environment Setup

Guides to setup the Python and Latex environment for Manim.

## Overview

`Swift-Manim` uses Python [ManimCE](https://docs.manim.community/en/stable/index.html) as its engine, hence it is essential to setup Python and let `Swift-Manim` know where to look.

### Setup Python

If you haven't already, [install python](https://www.python.org/downloads/).

Run ``withManim(scene:configuration:)``, and observe the logs. You should be able to see something like:

```sh
Using Python 3.13.7 (main, Aug 14 2025, 11:12:11) [Clang 17.0.0 (clang-1700.3.19.1)]
```
If it runs into errors, you specify the python `dylib` path using ``ConfigurationProxy/pythonLibraryPath``.

```swift
try await withManim {
    ...
} configuration {
    $0.pythonLibraryPath = "<#Insert Path Here#>" 
}
```

### Setup Dependencies

It is recommended to use a Python venv for dependencies.

But before that, you need to locate the correct Python. In the example above, we are using Python3.13.

```sh
$ which python3.13
/opt/homebrew/bin/python3.13
```

Then, using the returned path, we can install and setup dependencies.

```sh
$ /opt/homebrew/bin/python3.13 -m venv ~/Documents/Swift\ Manim/manim-venv
$ source ~/Documents/Swift\ Manim/manim-venv/bin/activate
$ pip install manim numpy
```

> If you want to specify your own path, configure ``ConfigurationProxy/pythonPackagesPath``.
> ```swift
> try await withManim {
>     ...
> } configuration {
>     $0.pythonPackagesPath = "<#Insert Path Here#>" 
> }
> ```

### Setup Latex

By default, `Swift-Manim` uses `latex` located at the following:
```
/Library/TeX/texbin/latex
```

You can double check yours with a shell command.

```sh
$ which latex
```

If it differs, set ``ConfigurationProxy/latexPath`` to the returned path. You may also need to change ``ConfigurationProxy/dvisvgmPath``.

```swift
try await withManim {
    ...
} configuration {
    $0.latexPath = "<#Insert Path Here#>" 
    $0.dvisvgmPath = "<#Insert Path Here#>" 
}
```
