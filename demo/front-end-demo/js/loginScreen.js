LRObject.util.ready(function() {
  LRObject.loginScreen("loginscreen-container", options)
});

let options = {
  redirecturl: {
    afterlogin: "profile.html",
    afterreset: "index.html"
  }
}
