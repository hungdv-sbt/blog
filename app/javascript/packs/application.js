// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
window.bootstrap = require("bootstrap");
import "../stylesheets/application.scss";

require("@rails/ujs").start()
//= require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
//= require ckeditor/init
//= require sweetalert2-rails
// import 'sweetalert2/src/sweetalert2.scss'
import * as Routes from './routes.js.erb';
import Popup from './popup';
import Comment from './comment';

window.Routes = Routes;
window.Popup = new Popup;
window.Comment = new Comment;
