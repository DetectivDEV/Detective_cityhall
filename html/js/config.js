document.addEventListener('DOMContentLoaded', () => {
    const serverName = document.getElementById('serverName');
    const defaultJob = document.getElementById('defaultJob');
    const jobsList = document.getElementById('jobsList');
    const enableLicenses = document.getElementById('enableLicenses');
    const maxCitizens = document.getElementById('maxCitizens');
    const saveBtn = document.getElementById('saveConfig');
    const resetBtn = document.getElementById('resetConfig');
    const alertBox = document.getElementById('alert');

    function loadConfig() {
        const cfg = JSON.parse(localStorage.getItem('detective_cityhall_config') || '{}');
        serverName.value = cfg.serverName || '';
        defaultJob.value = cfg.defaultJob || '';
        jobsList.value = (cfg.jobs || []).join('\n');
        enableLicenses.checked = !!cfg.enableLicenses;
        maxCitizens.value = cfg.maxCitizens || 50;
    }

    function showAlert(msg, type = 'success') {
        alertBox.style.display = 'block';
        alertBox.className = `alert alert-${type}`;
        alertBox.textContent = msg;
        setTimeout(() => alertBox.style.display = 'none', 3000);
    }

    saveBtn.addEventListener('click', () => {
        const cfg = {
            serverName: serverName.value.trim(),
            defaultJob: defaultJob.value.trim(),
            jobs: jobsList.value.split('\n').map(s => s.trim()).filter(Boolean),
            enableLicenses: enableLicenses.checked,
            maxCitizens: parseInt(maxCitizens.value, 10) || 50
        };

        localStorage.setItem('detective_cityhall_config', JSON.stringify(cfg));

        // Attempt to send to the game client (FiveM/NUI). Update resource name if needed.
        fetch('https://detective_cityhall/saveConfig', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(cfg)
        }).then(r => {
            showAlert('Configuration saved and sent to client.');
        }).catch(() => {
            showAlert('Configuration saved locally (network send failed).', 'warning');
        });
    });

    resetBtn.addEventListener('click', () => {
        localStorage.removeItem('detective_cityhall_config');
        loadConfig();
        showAlert('Configuration reset.', 'info');
    });

    loadConfig();
});
