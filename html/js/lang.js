class Locale {
    constructor(strings) {
        this.update(strings);
    }

    update(strings) {
        this.strings = strings;
        this.setUI();
    }


    get(key) {
        return this.strings[key];
    }

    setUI() {
        for (const key in this.strings) {
            let element = document.getElementById(key)
            if(!element) continue;
            element.innerHTML = this.get(key);
        }
    }
}

let stringsEN = {
    "text_jobs": "Work",
    "text_items": "Items",
    "text_information": "Info",
    "text_close": "Close",

    "text_identification": "Identification on file",
    "desc_identification": "Cards currently registered in your name.",

    "text_licenses": "Permits and licenses",
    "desc_licenses": "Permits currently registered in your name.",

    "text_buy": "Request",
    "text_apply": "Apply",

    "text_cost": "Fee: € ",
    "text_salary": "Salary: € ",
}


const locale = new Locale(stringsEN);