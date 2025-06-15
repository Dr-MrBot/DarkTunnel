#!/bin/bash

# ╔═══════════════════════════════════════════════════════════╗
# ║           🕶️ DarkTunnel - SSH Gateway Tool               ║
# ║      Expose Localhost or Host Folders Publicly           ║
# ║            🎓 Developer: Mohammad Fahad                  ║
# ╚═══════════════════════════════════════════════════════════╝
#
# 📝 Description:
# 🌐 DarkTunnel is a powerful tool that helps you expose your local services to the internet
# 🔒 It uses SSH tunneling to create secure connections
# 📂 You can either expose a local port or host a directory as a static website
# 🚀 Perfect for testing, sharing, or accessing your local services remotely
# ⚡ Quick and easy to use with a beautiful interface
# 🛡️  Secure and reliable for your networking needs
#
# 💡 Features:
# • Expose local ports to the internet
# • Host static websites from any directory
# • Custom subdomain support
# • Beautiful terminal interface
# • Secure SSH tunneling
# • Easy to use menu system
#
# ⚠️  Note: This tool is for legitimate purposes only
# 🔗 Uses serveo.net for tunneling

# Set up trap for Ctrl+C
trap 'echo -e "\n"; cleanup' INT

# ────────── CHECK DEPENDENCIES ──────────
check_dependencies() {
    for cmd in ssh python3; do
        if ! command -v $cmd &>/dev/null; then
            echo "❌ Missing dependency: $cmd"
            exit 1
        fi
    done
}

# ────────── BANNER ──────────
show_banner() {
    clear
    echo -e "\033[1;91m"
    echo "██████╗  █████╗ ██████╗ ██╗  ██╗████████╗██╗   ██╗███╗   ██╗██╗     ██╗     "
    echo "██╔══██╗██╔══██╗██╔══██╗██║  ██║╚══██╔══╝██║   ██║████╗  ██║██║     ██║     "
    echo "██████╔╝███████║██████╔╝███████║   ██║   ██║   ██║██╔██╗ ██║██║     ██║     "
    echo "██╔═══╝ ██╔══██║██╔═══╝ ██╔══██║   ██║   ██║   ██║██║╚██╗██║██║     ██║     "
    echo "██║     ██║  ██║██║     ██║  ██║   ██║   ╚██████╔╝██║ ╚████║███████╗███████╗"
    echo "╚═╝     ╚═╝  ╚═╝╚═╝     ╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═══╝╚══════╝╚══════╝"
    echo -e "\033[1;92m"
    echo "        [ DarkTunnel - Reverse Shell Gateway ]"
    echo "              🎓 Developer: Mohammad Fahad"
    echo -e "\033[0m"
    echo
}

# ────────── HOST DIRECTORY ──────────
start_web_server() {
    echo
    echo -e "\033[1;34m📁 Serving Directory:\033[0m $DIR"
    echo -e "\033[1;34m🌐 Local Access:\033[0m http://127.0.0.1:$PORT"
    echo -e "\033[1;34m🚀 Launching Python3 HTTP Server...\033[0m"
    echo
    cd "$DIR" || { echo "❌ Directory not found!"; exit 1; }
    python3 -m http.server "$PORT" &>/dev/null &
    SERVER_PID=$!
    sleep 2
}

# ────────── START SSH TUNNEL ──────────
start_ssh_tunnel() {
    echo
    if [[ -n "$SUBDOMAIN" ]]; then
        echo -e "\033[1;32m🌐 Public URL: \033[1;96mhttps://$SUBDOMAIN.serveo.net\033[0m"
        echo
        ssh -o StrictHostKeyChecking=no -R "$SUBDOMAIN:80:localhost:$PORT" serveo.net
    else
        echo -e "\033[1;32m🌐 Public URL: \033[1;96m(random subdomain)\033[0m"
        echo
        ssh -o StrictHostKeyChecking=no -R 80:localhost:$PORT serveo.net
    fi
}

# ────────── EXIT ANIMATION ──────────
goodbye_animation() {
    clear
    echo -e "\033[1;91m"
    echo "╔════════════════════════════════════════════════════════════════════════════╗"
    echo "║                                                                             ║"
    echo "║  ██████╗  ██████╗  ██████╗ ██████╗ ██████╗ ██╗   ██╗██████╗ ██╗          ║"
    echo "║  ██╔══██╗██╔═══██╗██╔═══██╗██╔══██╗██╔══██╗╚██╗ ██╔╝██╔══██╗██║          ║"
    echo "║  ██║  ██║██║   ██║██║   ██║██║  ██║██████╔╝ ╚████╔╝ ██║  ██║██║          ║"
    echo "║  ██║  ██║██║   ██║██║   ██║██║  ██║██╔══██╗  ╚██╔╝  ██║  ██║██║          ║"
    echo "║  ██████╔╝╚██████╔╝╚██████╔╝██████╔╝██████╔╝   ██║   ██████╔╝███████╗     ║"
    echo "║  ╚═════╝  ╚═════╝  ╚═════╝ ╚═════╝ ╚═════╝    ╚═╝   ╚═════╝ ╚══════╝     ║"
    echo "║                                                                             ║"
    echo "╠════════════════════════════════════════════════════════════════════════════╣"
    echo "║                                                                             ║"
    echo "║  🙏 Thank you for using DarkTunnel!                                         ║"
    echo "║  🔒 Your session has been securely terminated                               ║"
    echo "║  💻 Remember to stay secure and keep hacking!                              ║"
    echo "║  🌟 Your support helps make DarkTunnel better                               ║"
    echo "║  🎓 Developer: Mohammad Fahad                                              ║"
    echo "║                                                                             ║"
    echo "╚════════════════════════════════════════════════════════════════════════════╝"
    echo -e "\033[0m"
    echo
    sleep 1
    for i in 3 2 1; do
        echo -ne "👋 Closing in $i...\r"
        sleep 1
    done
    echo "🛑 Goodbye and stay secure!"
    exit 0
}

# ────────── CLEANUP ──────────
cleanup() {
    echo -e "\n🛑 Initiating secure shutdown..."
    echo -e "🔒 Cleaning up resources..."
    [ "$SERVER_PID" ] && kill "$SERVER_PID" 2>/dev/null
    sleep 1
    goodbye_animation
}

# ────────── MENU ──────────
main_menu() {
    show_banner
    echo "1) 🌐 Expose a local port"
    echo "2) 📂 Host a directory as static site"
    echo "0) ❌ Exit"
    echo
    read -rp "🎯 Select an option: " CHOICE

    case $CHOICE in
        1)
            read -rp "🔢 Enter local port to expose (e.g., 3000): " PORT
            read -rp "🎯 Custom subdomain (optional, e.g. darkhub): " SUBDOMAIN
            start_ssh_tunnel
            ;;
        2)
            read -rp "📁 Enter folder path to host (e.g., ./public): " DIR
            read -rp "🔢 Enter port to serve on (default 8080): " PORT
            PORT=${PORT:-8080}
            read -rp "🎯 Custom subdomain (optional): " SUBDOMAIN
            start_web_server
            start_ssh_tunnel
            ;;
        0)
            goodbye_animation
            ;;
        *)
            echo "❗ Invalid option. Try again."
            sleep 1
            main_menu
            ;;
    esac
}

# ────────── RUN ──────────
check_dependencies
main_menu
