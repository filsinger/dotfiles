# Adds the CrossPack-AVR path if it has been installed
# http://www.obdev.at/products/crosspack/index.html

if [ -e "/usr/local/CrossPack-AVR" ]; then
PATH="$PATH:/usr/local/CrossPack-AVR/bin"
export PATH
fi
