# `zw2fit`

Converts workouts from [Zwift](https://zwift.com) `.zwo` to
[ANT+](https://www.thisisant.com/developer/ant-plus/ant-antplus-defined/)
binary `.fit`.

## Installation

From source:

```
$ git clone git@github.com:chrishunt/zw2fit.git
$ cd zw2fit/
$ bundle install
```

## Usage

```
$ ./bin/zw2fit --help

Usage: zw2fit [options]
        --zwo ZWO_PATH     Path to workout(s) in ZWO format
        --ftp CURRENT_FTP  Current FTP
    -v, --[no-]verbose     Run verbosely
```

Convert a single workout:

```
$ ./bin/zw2fit --zwo workout.zwo --ftp 250
```

Convert a directory of workouts:

```
$ ./bin/zw2fit --zwo workouts/ --ftp 250
```

## Testing

```
$ rake
```

## Requirements

- Ruby (required for `zw2fit`)
- Java (required for [ANT+ SDK](https://www.thisisant.com/developer))
