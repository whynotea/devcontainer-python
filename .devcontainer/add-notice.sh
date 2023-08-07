# Display a notice when not running in GitHub Codespaces

cat << 'EOF' > /usr/local/etc/conda-notice.txt
When using "conda" from outside of GitHub Codespaces, note the Anaconda repository 
contains restrictions on commercial use that may impact certain organizations. See
https://aka.ms/vscode-remote/conda/anaconda

EOF

notice_script="$(cat << 'EOF'
if [ -t 1 ] && [ "${IGNORE_NOTICE}" != "true" ] && [ "${TERM_PROGRAM}" = "vscode" ] && [ "${CODESPACES}" != "true" ] && [ ! -f "$HOME/.config/devcontainer-python/conda-notice-already-displayed" ]; then
    cat "/usr/local/etc/conda-notice.txt"
    mkdir -p "$HOME/.config/devcontainer-python"
    ((sleep 10s; touch "$HOME/.config/devcontainer-python/conda-notice-already-displayed") &)
fi
EOF
)"

echo "${notice_script}" | tee -a /etc/bash.bashrc >> /home/code/.zshrc
