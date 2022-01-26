#!/bin/bash
# to make this run on login sudo defaults write com.apple.loginwindow LoginHook /etc/rebind_caplocks.sh
hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x70000002A}]}'
