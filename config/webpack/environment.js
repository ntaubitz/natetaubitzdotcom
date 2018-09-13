const { environment } = require('@rails/webpacker')
const custom_config = require('./custom')
const vue =  require('./loaders/vue')
const ts =  require('./loaders/typescript')

environment.loaders.append('vue', vue)
environment.loaders.append('typescript', ts)

environment.config.merge(custom_config)

module.exports = environment
