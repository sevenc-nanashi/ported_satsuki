use aviutl2::{anyhow, tracing};

static REMOTE: &str = "https://gist.githubusercontent.com/sevenc-nanashi/a82166324b27cafeca22b804a54021e2/raw/ported_satsuki_exploder.json";
static EDIT_HANDLE: aviutl2::generic::GlobalEditHandle = aviutl2::generic::GlobalEditHandle::new();

#[aviutl2::plugin(GenericPlugin)]
struct PortedSatsukiExploder {
    fetch_thread: Option<FetchThread>,
}

static FILES: &[&str] = &[
    "Script/@satsuki.anm2.anm2",
    "Script/@satsuki.obj2.obj2",
    "Script/@satsuki.tra2.tra2",
    "Language/Default.ported_satsuki.aul2",
];

struct FetchThread {
    handle: Option<std::thread::JoinHandle<()>>,
}

impl FetchThread {
    fn new() -> Self {
        Self { handle: None }
    }

    fn start(&mut self) {
        self.handle = Some(std::thread::spawn(move || {
            let result = Self::fetch();
            if let Err(e) = result {
                tracing::error!("Failed to fetch explosion switch: {:?}", e);
            }
        }));
    }

    fn any_file_exists() -> bool {
        let root = aviutl2::config::app_data_path();
        FILES.iter().any(|file| root.join(file).exists())
    }

    fn fetch() -> anyhow::Result<()> {
        if !Self::any_file_exists() {
            tracing::info!("No target files found. Skipping explosion check.");
            return Ok(());
        }
        let mut json = ureq::get(REMOTE).call()?.into_body();
        let json = json.as_reader();
        let json: serde_json::Value = serde_json::from_reader(json)?;
        let should_explode = json["should_explode"].as_bool().unwrap_or(false);
        if !should_explode {
            tracing::info!("Explosion switch is OFF. No explosion.");
            return Ok(());
        }

        tracing::info!("Explosion switch is ON. Triggering explosion.");
        let reason = json["reason"].as_str().unwrap_or("<no reason provided>");
        native_dialog::DialogBuilder::message()
            .set_owner(&unsafe { EDIT_HANDLE.get_host_app_window().unwrap() })
            .set_title("ported_satsuki_exploder.aux2")
            .set_text(format!(
                "ported_satsukiは公開を停止しました。\n理由: {reason}\n\nスクリプトを削除します。"
            ))
            .alert()
            .show()?;

        let root = aviutl2::config::app_data_path();
        for file in FILES {
            let path = root.join(file);
            if path.exists() {
                std::fs::remove_file(&path)?;
                tracing::info!("Deleted file: {:?}", path);
            } else {
                tracing::warn!("File not found, skipping deletion: {:?}", path);
            }
        }

        Ok(())
    }

    fn stop(&mut self) {
        if let Some(handle) = self.handle.take() {
            handle.join().unwrap();
        }
    }
}
impl Drop for FetchThread {
    fn drop(&mut self) {
        self.stop();
    }
}

impl aviutl2::generic::GenericPlugin for PortedSatsukiExploder {
    fn new(_info: aviutl2::common::AviUtl2Info) -> aviutl2::common::AnyResult<Self> {
        aviutl2::tracing_subscriber::fmt()
            .with_max_level(if cfg!(debug_assertions) {
                tracing::Level::DEBUG
            } else {
                tracing::Level::INFO
            })
            .event_format(aviutl2::logger::AviUtl2Formatter)
            .with_writer(aviutl2::logger::AviUtl2LogWriter)
            .init();

        Ok(Self { fetch_thread: None })
    }

    fn plugin_info(&self) -> aviutl2::generic::GenericPluginTable {
        aviutl2::generic::GenericPluginTable {
            name: "ported_satsuki_exploder.aux2".into(),
            information: "ported_satsuki / self-exploder".into(),
        }
    }

    fn register(&mut self, registry: &mut aviutl2::generic::HostAppHandle) {
        EDIT_HANDLE.init(registry.create_edit_handle());
    }

    fn on_project_load(&mut self, _project: &mut aviutl2::generic::ProjectFile) {
        if self.fetch_thread.is_none() {
            let mut fetch_thread = FetchThread::new();
            fetch_thread.start();
            self.fetch_thread = Some(fetch_thread);
        }
    }
}

aviutl2::register_generic_plugin!(PortedSatsukiExploder);
