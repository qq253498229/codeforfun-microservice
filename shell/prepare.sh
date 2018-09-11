#!/usr/bin/env bash
apt-get update && apt-get install -y curl wget git zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"