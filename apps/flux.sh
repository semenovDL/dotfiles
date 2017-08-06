#!/usr/bin/env bash

###############################################################################
# Flux                                                                        #
###############################################################################

defaults write org.herf.Flux.plist SUHasLaunchedBefore -int 1
defaults write org.herf.Flux.plist lateColorTemp -int 6500
defaults write org.herf.Flux.plist nightColorTemp -int 3400
defaults write org.herf.Flux.plist "offer-qs" -int 1
defaults write org.herf.Flux.plist steptime -int 30
defaults write org.herf.Flux.plist wakeTime -int 450
