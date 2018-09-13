import Vue from 'vue'
import Component from 'vue-class-component'

@Component({
    // All component options are allowed in here
    template: '<p>foo {{foowagon}}</p>'
})

export default class NateDogg extends Vue {
    foowagon: string = "wagon"
}