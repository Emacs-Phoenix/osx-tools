# http://apple.stackexchange.com/questions/110778/open-new-tab-in-iterm-and-execute-command-there

newtabi()
{
    osascript -e 'tell application "iTerm" to activate' -e 'tell application "System Events" to tell process "iTerm" to keystroke "t" using command down'
}
