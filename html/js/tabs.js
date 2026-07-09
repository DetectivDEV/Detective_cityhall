document.querySelectorAll('.mtc-tabs .mtc-tab').forEach((tab) => {
    tab.addEventListener('click', () => {
        document.querySelectorAll('.mtc-tabs .mtc-tab').forEach((t) => t.classList.remove('active'));
        tab.classList.add('active');
    });
});
