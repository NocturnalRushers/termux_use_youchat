#!/bin/bash

# 定义配置文件路径
CONFIG_JS="/data/data/com.termux/files/home/YOUChat_Proxy/config.js"
START_SH="/data/data/com.termux/files/home/YOUChat_Proxy/start.sh"

# 更新YOUChat_Proxy函数
update_youchat_proxy() {
    echo "正在更新YOUChat_Proxy..."
    cd YOUChat_Proxy
    git pull 
    echo "更新完成！"
}

# 编辑config.js函数
edit_config_js() {
    local choice
    echo "1. 添加cookie"
    echo "2. 添加user_agent"
    echo "3. 删除所有cookie和user_agent"
    read -p "请选择一个选项: " choice
    case $choice in
        1)
            read -p "请输入cookie: " cookie
            # 将用户输入的cookie添加到config.js文件
            sed -i "/\"cookie\":/c\    \"cookie\": \"$cookie\"," $CONFIG_JS
            echo "cookie已添加。"
            ;;
        2)
            read -p "请输入user_agent: " user_agent
            # 将用户输入的user_agent添加到config.js文件
            sed -i "/\"user_agent\":/c\    \"user_agent\": \"$user_agent\"" $CONFIG_JS
            echo "user_agent已添加。"
            ;;
        3)
            # 删除所有cookie和user_agent
            sed -i "/\"cookie\":/c\    \"cookie\": \"\"," $CONFIG_JS
            sed -i "/\"user_agent\":/c\    \"user_agent\": \"\"" $CONFIG_JS
            echo "所有cookie和user_agent已删除。"
            ;;
        *)
            echo "无效选项"
            ;;
    esac
}

# 编辑start.sh函数
edit_start_sh() {
    local choice
    echo "1. 修改PASSWORD"
    echo "2. 修改https_proxy"
    echo "3. 修改PORT"
    echo "4. 修改AI_MODEL"
    read -p "请选择一个选项: " choice
    case $choice in
        1)
            local current_password=$(grep -oP 'export PASSWORD=\K.*' $START_SH)
            echo "当前PASSWORD为: $current_password"
            read -p "是否修改? (y/n): " yn
            if [[ "$yn" == "y" ]]; then
                read -p "请输入新的PASSWORD: " new_password
                sed -i "/export PASSWORD=/c\export PASSWORD=$new_password" $START_SH
                echo "PASSWORD已修改。"
            fi
            ;;
        2)
            local current_proxy=$(grep -oP 'export https_proxy=\K.*' $START_SH)
            echo "当前https_proxy为: $current_proxy"
            read -p "是否修改? (y/n): " yn
            if [[ "$yn" == "y" ]]; then
                read -p "请输入新的https_proxy: " new_proxy
                sed -i "/export https_proxy=/c\export https_proxy=$new_proxy" $START_SH
                echo "https_proxy已修改。"
            fi
            ;;
        3)
            local current_port=$(grep -oP 'export PORT=\K.*' $START_SH)
            echo "当前PORT为: $current_port"
            read -p "是否修改? (y/n): " yn
            if [[ "$yn" == "y" ]]; then
                read -p "请输入新的PORT: " new_port
                sed -i "/export PORT=/c\export PORT=$new_port" $START_SH
                echo "PORT已修改。"
            fi
            ;;
        4)
            local current_model=$(grep -oP 'export AI_MODEL=\K.*' $START_SH)
            echo "当前AI_MODEL为: $current_model"
            echo "当前可以使用的模型如下："
            echo "1. gpt_4o"
            echo "2. gpt_4_turbo"
            echo "3. gpt_4"
            echo "4. claude_3_opus"
            echo "5. claude_3_sonnet"
            echo "6. claude_3_haiku"
            echo "7. claude_2"
            echo "8. llama3"
            echo "9. gemini_pro"
            echo "10. gemini_1_5_pro"
            echo "11. databricks_dbrx_instruct"
            echo "12. command_r"
            echo "13. command_r_plus"
            echo "14. zephyr"
            read -p "是否修改? (y/n): " yn
            if [[ "$yn" == "y" ]]; then
                read -p "请输入对应数字修改模型: " model_choice
                case $model_choice in
                    1) new_model="gpt_4o" ;;
                    2) new_model="gpt_4_turbo" ;;
                    3) new_model="gpt_4" ;;
                    4) new_model="claude_3_opus" ;;
                    5) new_model="claude_3_sonnet" ;;
                    6) new_model="claude_3_haiku" ;;
                    7) new_model="claude_2" ;;
                    8) new_model="llama3" ;;
                    9) new_model="gemini_pro" ;;
                    10) new_model="gemini_1_5_pro" ;;
                    11) new_model="databricks_dbrx_instruct" ;;
                    12) new_model="command_r" ;;
                    13) new_model="command_r_plus" ;;
                    14) new_model="zephyr" ;;
                    *)
                        echo "无效选项"
                        return
                        ;;
                esac
                sed -i "/export AI_MODEL=/c\export AI_MODEL=$new_model" $START_SH
                echo "AI_MODEL已修改为$new_model。"
            fi
            ;;
        *)
            echo "无效选项"
            ;;
    esac
}

# 主菜单
echo -e "                                              
————————主菜单————————
一键YouProxy使用脚本
运行时需要稳定的魔法网络环境"
while true; do
    echo "1. 更新YOUChat_Proxy"
    echo "2. 更改config.js"
    echo "3. 修改start.sh"
    echo "4. 退出"
    echo "5. 更新脚本"
    read -p "请输入选项: " menu_choice
    case $menu_choice in
        1)
            update_youchat_proxy
            ;;
        2)
            edit_config_js
            ;;
        3)
            edit_start_sh
            ;;
        4)
            echo "退出脚本。"
            break
            ;;
        5)
             # 更新脚本
            curl -O https://raw.githubusercontent.com/NocturnalRushers/termux_use_youchat/main/tuy.sh
	    echo -e "重启终端或者输入bash tuy.sh重新进入脚本"
            break ;;
        *)
            echo "无效选项"
            ;;
    esac
done
