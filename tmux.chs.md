.tmux.conf 配置文件中的配置项如下：

1. bind C-a send-prefix -2：将 Ctrl-a 绑定为发送前缀键，用于激活 tmux 的命令模式。
2. bind e new-window -n "~/.tmux.conf.local" "sh -c '\${EDITOR:-vim} ~/.tmux.conf.local && tmux source ~/.tmux.conf && tmux display \"~/.tmux.conf sourced\"'"：将快捷键 e 绑定为打开一个新窗口并编辑 ~/.tmux.conf.local 文件。编辑完成后会重新加载配置文件并显示提示信息。
3. bind r source-file ~/.tmux.conf \; display '~/.tmux.conf sourced'：将快捷键 r 绑定为重新加载配置文件，并显示提示信息。
4. bind -n C-l send-keys C-l \; run 'sleep 0.1' \; clear-history：将快捷键 C-l 绑定为清屏。
5. bind C-c new-session：将快捷键 C-c 绑定为创建新的会话。
6. bind C-f command-prompt -p find-session 'switch-client -t %%'：将快捷键 C-f 绑定为查找会话。
7. bind - split-window -v：将快捷键 - 绑定为垂直分割窗口。
8. bind _ split-window -h：将快捷键 _ 绑定为水平分割窗口。
9. bind -r h select-pane -L：将快捷键 h 绑定为切换到左边的窗格。
10. bind -r j select-pane -D：将快捷键 j 绑定为切换到下边的窗格。
11. bind -r k select-pane -U：将快捷键 k 绑定为切换到上边的窗格。
12. bind -r l select-pane -R：将快捷键 l 绑定为切换到右边的窗格。
13. bind > swap-pane -D：将快捷键 > 绑定为交换当前窗格和下一个窗格。
14. bind < swap-pane -U：将快捷键 < 绑定为交换当前窗格和上一个窗格。
15. bind + run 'cut -c3- ~/.tmux.conf | sh -s _maximize_pane "#{session_name}" #D'：将快捷键 + 绑定为最大化当前窗格。
16. bind -r H resize-pane -L 2：将快捷键 H 绑定为将当前窗格向左调整大小。
17. bind -r J resize-pane -D 2：将快捷键 J 绑定为将当前窗格向下调整大小。
18. bind -r K resize-pane -U 2：将快捷键 K 绑定为将当前窗格向上调整大小。
19. bind -r L resize-pane -R 2：将快捷键 L 绑定为将当前窗格向右调整大小。
20. unbind n：解绑快捷键 n。
21. unbind p：解绑快捷键 p。
22. bind -r C-h previous-window：将快捷键 C-h 绑定为切换到前一个窗口。
23. bind -r C-l next-window：将快捷键 C-l 绑定为切换到后一个窗口。
24. bind Tab last-window：将快捷键 Tab 绑定为切换到最后一个活动窗口。
25. bind m run "cut -c3- ~/.tmux.conf | sh -s _toggle_mouse"：将快捷键 m 绑定为切换鼠标模式。
26. bind U run "cut -c3- ~/.tmux.conf | sh -s _urlview #{pane_id}"：将快捷键 U 绑定为使用 urlview 打开链接。
27. bind F run "cut -c3- ~/.tmux.conf | sh -s _fpp #{pane_id}"：将快捷键 F 绑定为使用 fpp 打开文件。
28. run -b 'tmux bind -t vi-choice h tree-collapse 2> /dev/null || true'：绑定 tmux 的 vi-mode 中的 h 键为折叠树形目录。
29. run -b 'tmux bind -t vi-choice l tree-expand 2> /dev/null || true'：绑定 tmux 的 vi-mode 中的 l 键为展开树形目录。
30. run -b 'tmux bind -t vi-choice K start-of-list 2> /dev/null || true'：绑定 tmux 的 vi-mode 中的 K 键为跳转到列表开头。
31. run -b 'tmux bind -t vi-choice J end-of-list 2> /dev/null || true'：绑定 tmux 的 vi-mode 中的 J 键为跳转到列表末尾。
32. run -b 'tmux bind -t vi-choice H tree-collapse-all 2> /dev/null || true'：绑定 tmux 的 vi-mode 中的 H 键为折叠全部树形目录。
33. run -b 'tmux bind -t vi-choice L tree-expand-all 2> /dev/null || true'：绑定 tmux 的 vi-mode 中的 L 键为展开全部树形目录。
34. run -b 'tmux bind -t vi-choice Escape cancel 2> /dev/null || true'：绑定 tmux 的 vi-mode 中的 Escape 键为取消操作。
35. run -b 'tmux bind -ct vi-edit H start-of-line 2> /dev/null || true'：绑定 tmux 的 vi-mode 中的 H 键为跳转到行首。
36. run -b 'tmux bind -ct vi-edit L end-of-line 2> /dev/null || true'：绑定 tmux 的 vi-mode 中的 L 键为跳转到行尾。
37. run -b 'tmux bind -ct vi-edit q cancel 2> /dev/null || true'：绑定 tmux 的 vi-mode 中的 q 键为取消操作。
38. run -b 'tmux bind -ct vi-edit Escape cancel 2> /dev/null || true'：绑定 tmux 的 vi-mode 中的 Escape 键为取消操作。
39. bind Enter copy-mode：将快捷键 Enter 绑定为进入复制模式。
40. run -b 'tmux bind -t vi-copy v begin-selection 2> /dev/null || true'：将 tmux 的 vi-copy 模式中的 v 键绑定为开始选择文本。
41. run -b 'tmux bind -T copy-mode-vi v send -X begin-selection 2> /dev/null || true'：将 tmux 的 copy-mode-vi 模式中的 v 键绑定为开始选择文本。
42. run -b 'tmux bind -t vi-copy C-v rectangle-toggle 2> /dev/null || true'：将 tmux 的 vi-copy 模式中的 C-v 键绑定为切换矩形选择模式。
43. run -b 'tmux bind -T copy-mode-vi C-v send -X rectangle-toggle 2> /dev/null || true'：将 tmux 的 copy-mode-vi 模式中的 C-v 键绑定为切换矩形选择模式。
44. run -b 'tmux bind -t vi-copy y copy-selection 2> /dev/null || true'：将 tmux 的 vi-copy 模式中的 y 键绑定为复制选择的文本。
45. run -b 'tmux bind -T copy-mode-vi y send -X copy-selection-and-cancel 2> /dev/null || true'：将 tmux 的 copy-mode-vi 模式中的 y 键绑定为复制选择的文本。
46. run -b 'tmux bind -t vi-copy Escape cancel 2> /dev/null || true'：将 tmux 的 vi-copy 模式中的 Escape 键绑定为取消操作。
47. run -b 'tmux bind -T copy-mode-vi Escape send -X cancel

