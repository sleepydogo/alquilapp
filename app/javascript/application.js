// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import "controllers"
import "@hotwired/turbo-rails"
import { Turbo } from "@hotwired/turbo-rails"

Turbo.setConfirmMethod((method, element) => {
    console.log(message, element)

    let dialog = document.getElementById('turbo-confirm');
    dialog.showModal()

    return new Promise((resolve, reject) => {
        dialog.addEventListener('close', () => {
            resolve(dialog.returnValue = 'confirm')
        }, { once: true })
    })
})
