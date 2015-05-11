[Appearance]
BoldIntense=false
ColorScheme=Solarized Dark
Font=Monospace,9,-1,5,50,0,0,0,0,0

[General]
Command=sh -c "tmux -q has-session && exec tmux attach-session -d || exec tmux new-session"
LocalTabTitleFormat=%d : %n
Name=Tmux
Parent=FALLBACK/
RemoteTabTitleFormat=%h : %u
ShowMenuBar=false
TabBarMode=1

[Keyboard]
KeyBindings=default

[Terminal Features]
FlowControlEnabled=false
