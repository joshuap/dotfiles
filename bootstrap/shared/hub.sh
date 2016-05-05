#!/bin/sh

# Install hub.
if ! hash hub 2>/dev/null; then
  rm -rf /tmp/hub
  git clone https://github.com/github/hub.git /tmp/hub
  cd /tmp/hub
  script/build -o $HOME/bin/hub
fi
