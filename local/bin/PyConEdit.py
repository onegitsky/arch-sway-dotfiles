#!/usr/bin/python
# Py menu mainly for testing purposes

import tkinter as tk
from tkinter import ttk
import subprocess

CONFIG = {
    "window_title": "󰤨  WiFi Meter",
    "window_width": 300,
    "window_height": 410,
    "background_color": "#3b4252",
    "title_text": "󱛆  Connection Settings",
    "title_font": ("FiraMono NerdFont", 14),
    "title_color": "#c0cbd8",
    "title_padding": 20,
    "button_width": 25,
    "button_height": 2,
    "button_font": ("FiraMono NerdFont", 10),
    "button_fg": "#c0cbd8",
    "button_bg": "#2e3440",
    "button_active_bg": "#434c5e",
    "button_border_color": "#ffffff",
    "button_border_width": 0,
    "button_padding": 10,
    "quit_button_bg": "#b74e58",
    "quit_button_active_bg": "#bf616a",
    "quit_button_border_color": "#ffffff",
    "quit_button_border_width": 0,
    "quit_button_text": " Quit",
    
    "popup_width": 400,
    "popup_height": 300,
    "popup_bg": "#3b4252",
    "popup_title_font": ("FiraMono NerdFont", 12),
    "popup_text_font": ("FiraMono NerdFont", 10),
    "popup_title_padding": 10,
    "popup_text_padding": 10,
    "popup_button_width": 10,
    "popup_button_height": 1,
    "popup_button_font": ("FiraMono NerdFont", 10),
    "popup_button_fg": "#c0cbd8",
    "popup_button_bg": "#2e3440",
    "popup_button_active_bg": "#434c5e",
    "popup_button_border_color": "#ffffff",
    "popup_button_border_width": 0,
    "popup_button_padding": 10,
    "popup_success_title": "",
    "popup_success_title_color": "#c0cbd8",
    "popup_success_text_color": "#c0cbd8",
    "popup_error_title": "Error",
    "popup_error_title_color": "#bf616a",
    "popup_error_text_color": "#c0cbd8",
    "popup_scrollbar_width": 0,
    "popup_scrollbar_bg": "#1a1a1a",
    "popup_scrollbar_active_bg": "#1a1a1a",
    
    "commands": [
        {"name": "Connect to 5GHZ", "cmd": "nmcli con down SSID ; nmcli con up SSID"},
        {"name": "Connect to 2.4GHZ", "cmd": "nmcli con down SSID ; nmcli con up SSID"},
        {"name": "Disconenct from 5GHZ", "cmd": "nmcli con down SSID"},
        {"name": "Disconnect from 2.4GHZ", "cmd": "nmcli con down SSID"},
    ]
}

def show_popup(title, message, is_error=False):
    popup = tk.Toplevel()
    popup.attributes('-type', 'dialog')
    popup.title(title)
    popup.geometry(f"{CONFIG['popup_width']}x{CONFIG['popup_height']}")
    popup.configure(bg=CONFIG["popup_bg"])
    popup.transient()
    popup.grab_set()
    
    title_color = CONFIG["popup_error_title_color"] if is_error else CONFIG["popup_success_title_color"]
    title_label = tk.Label(
        popup,
        text=title,
        font=CONFIG["popup_title_font"],
        fg=title_color,
        bg=CONFIG["popup_bg"]
    )
    title_label.pack(pady=CONFIG["popup_title_padding"])
    
    frame = tk.Frame(popup, bg=CONFIG["popup_bg"])
    frame.pack(padx=10, pady=10, fill="both", expand=True)
    
    scrollbar = tk.Scrollbar(
        frame,
        width=CONFIG["popup_scrollbar_width"],
        bg=CONFIG["popup_scrollbar_bg"],
        activebackground=CONFIG["popup_scrollbar_active_bg"]
    )
    scrollbar.pack(side="right", fill="y")
    
    text_color = CONFIG["popup_error_text_color"] if is_error else CONFIG["popup_success_text_color"]
    text_area = tk.Text(
        frame,
        font=CONFIG["popup_text_font"],
        fg=text_color,
        bg=CONFIG["popup_bg"],
        wrap="word",
        yscrollcommand=scrollbar.set
    )
    text_area.insert("1.0", message)
    text_area.config(state="disabled")
    text_area.pack(side="left", fill="both", expand=True)
    
    scrollbar.config(command=text_area.yview)
    
    if is_error:
        close_btn = tk.Button(
            popup,
            text="Close",
            command=popup.destroy,
            width=CONFIG["popup_button_width"],
            height=CONFIG["popup_button_height"],
            font=CONFIG["popup_button_font"],
            fg=CONFIG["popup_button_fg"],
            bg=CONFIG["popup_button_bg"],
            activebackground=CONFIG["popup_button_active_bg"],
            relief=tk.RAISED,
            borderwidth=CONFIG["popup_button_border_width"],
            highlightbackground=CONFIG["popup_button_border_color"],
            highlightthickness=CONFIG["popup_button_border_width"]
        )
        close_btn.pack(pady=CONFIG["popup_button_padding"])
    else:
        popup.after(1000, popup.destroy)
    
    popup.update_idletasks()
    x = (popup.winfo_screenwidth() - popup.winfo_width()) // 2
    y = (popup.winfo_screenheight() - popup.winfo_height()) // 2
    popup.geometry(f"+{x}+{y}")

def run_command(command):
    try:
        result = subprocess.run(command, shell=True, capture_output=True, text=True)
        show_popup(
            CONFIG["popup_success_title"],
            f"Executed successfully!\n\nOutput:\n{result.stdout}",
            False
        )
    except Exception as e:
        show_popup(
            CONFIG["popup_error_title"],
            f"An error occurred: {str(e)}",
            True
        )

def create_gui():
    root = tk.Tk()
    root.title(CONFIG["window_title"])
    root.geometry(f"{CONFIG['window_width']}x{CONFIG['window_height']}")
    root.configure(bg=CONFIG["background_color"])
    
    root.attributes('-type', 'dialog')
    
    title = tk.Label(
        root,
        text=CONFIG["title_text"],
        font=CONFIG["title_font"],
        fg=CONFIG["title_color"],
        bg=CONFIG["background_color"]
    )
    title.pack(pady=CONFIG["title_padding"])
    
    for command in CONFIG["commands"]:
        btn = tk.Button(
            root,
            text=command["name"],
            command=lambda c=command["cmd"]: run_command(c),
            width=CONFIG["button_width"],
            height=CONFIG["button_height"],
            font=CONFIG["button_font"],
            fg=CONFIG["button_fg"],
            bg=CONFIG["button_bg"],
            activebackground=CONFIG["button_active_bg"],
            relief=tk.RAISED,
            borderwidth=CONFIG["button_border_width"],
            highlightbackground=CONFIG["button_border_color"],
            highlightthickness=CONFIG["button_border_width"]
        )
        btn.pack(pady=CONFIG["button_padding"])
    
    quit_btn = tk.Button(
        root,
        text=CONFIG["quit_button_text"],
        command=root.quit,
        width=CONFIG["button_width"],
        height=CONFIG["button_height"],
        font=CONFIG["button_font"],
        fg=CONFIG["button_fg"],
        bg=CONFIG["quit_button_bg"],
        activebackground=CONFIG["quit_button_active_bg"],
        relief=tk.RAISED,
        borderwidth=CONFIG["quit_button_border_width"],
        highlightbackground=CONFIG["quit_button_border_color"],
        highlightthickness=CONFIG["quit_button_border_width"]
    )
    quit_btn.pack(pady=CONFIG["button_padding"])
    
    root.update_idletasks()
    x = (root.winfo_screenwidth() - root.winfo_width()) // 2
    y = (root.winfo_screenheight() - root.winfo_height()) // 2
    root.geometry(f"+{x}+{y}")
    
    root.mainloop()

if __name__ == "__main__":
    create_gui()
