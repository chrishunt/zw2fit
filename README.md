# `zw2fit`

Converts workouts from [Zwift](https://zwift.com) `.zwo` to
[ANT+](https://www.thisisant.com/developer/ant-plus/ant-antplus-defined/)
binary `.fit`.

## Installation

```
$ bundle install
```

## Usage

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
