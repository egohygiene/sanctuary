#!/usr/bin/env bash

currentSetting=$(defaults read com.apple.Finder AppleShowAllFiles)

echo $currentSetting
