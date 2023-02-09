set -e 
apt install -y build-essential git cmake cmake-data pkg-config python3-sphinx python3-packaging libuv1-dev libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libjsoncpp-dev libpulse-dev libiw-dev libasound2
git clone https://github.com/polybar/polybar.git 
cd polybar
./build.sh --pulseaudio --network --i3 --ipc --alsa --auto 
cd -
#rm -r polybar
