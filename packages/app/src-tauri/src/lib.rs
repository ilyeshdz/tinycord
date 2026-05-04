use tauri::{
    webview::{Color, PageLoadEvent},
    WebviewUrl, WebviewWindowBuilder,
};

const DISCORD_APP_URL: &str = "https://discord.com/app";
const CLIENT_BUNDLE: &str = include_str!("../../src/generated/client.js");

#[tauri::command]
fn tinycord_ping() -> &'static str {
    "pong"
}

pub fn run() {
    tauri::Builder::default()
        .invoke_handler(tauri::generate_handler![tinycord_ping])
        .setup(|app| {
            let url = DISCORD_APP_URL
                .parse()
                .expect("Discord app URL should be a valid URL");

            WebviewWindowBuilder::new(app, "main", WebviewUrl::External(url))
                .title("Tinycord")
                .inner_size(1280.0, 800.0)
                .min_inner_size(940.0, 600.0)
                .visible(false)
                .background_color(Color(49, 51, 56, 255))
                .initialization_script(CLIENT_BUNDLE)
                .on_page_load(|window, payload| {
                    if matches!(payload.event(), PageLoadEvent::Finished) {
                        let _ = window.show();
                    }
                })
                .build()?;

            Ok(())
        })
        .run(tauri::generate_context!())
        .expect("error while running Tinycord");
}
