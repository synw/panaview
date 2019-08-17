# Panaview

Desktop application to visualize Dart packages analysis. Runs [pana](https://pub.dev/packages/pana) and displays the results.

Uses [go-flutter](https://github.com/go-flutter-desktop/go-flutter) to build the desktop app.

## Install

### Install pana

```bash
pub global activate pana
```

### Install the Roboto font

For Debian/Ubuntu:

```bash
sudo apt install fonts-roboto
```

### Run

Use the binary release to run it for Linux:

```bash
wget https://github.com/synw/panaview/releases/download/0.2.0/panaview_linux.zip
unzip panaview_linux.zip
cd linux
./panaview
```

Or run with [hover](https://github.com/go-flutter-desktop/hover):

```bash
git clone https://github.com/synw/panaview.git
cd panaview
hover run
```

![Screenshot](img/screenshot.png)
