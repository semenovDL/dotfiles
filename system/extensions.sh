#!/usr/bin/env bash

###############################################################################
# Extensions                                                                  #
###############################################################################

defaults write com.apple.preferences.extensions.ShareMenu displayOrder -array \
    "com.apple.share.System.add-to-safari-reading-list" \
    "com.apple.share.Mail.compose" \
    "com.apple.share.Messages.compose" \
    "com.apple.Notes.SharingExtension" \
    "com.apple.share.AirDrop.send" \
    "com.apple.share.Twitter.post"
